From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Wed, 22 Aug 2012 12:39:38 -0700
Message-ID: <7vehmy7m2t.fsf@alter.siamese.dyndns.org>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
 <1345523464-14586-7-git-send-email-pclouds@gmail.com>
 <7v628bdhol.fsf@alter.siamese.dyndns.org>
 <CANYiYbE9sJNOXxxFX_xdow=tnWfUwBYOx4S0_CgaB+bUQxDSRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 21:39:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GmJ-0008Pm-FA
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab2HVTjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:39:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab2HVTjl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:39:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94BF29334;
	Wed, 22 Aug 2012 15:39:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OAJJaDeC9IFhTGgcTbLT1ac8cFQ=; b=gha6Ho
	hNws/dJYV88G6RhAIRvJG/wpLxcaAaegvzr8sDqgPy2PUaqvoOl7hIBlwKVgQFxy
	tn3SDwRZqfsnrKw/NfOn07JpVxoVywzoFrky6CjUerYs2aDXrJ91ojvcZm8IrTLZ
	ivuiUAKpf3Vah3zf+STReAo6GvFu9bv9gFcBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0GHS1K223ohyx5GgzF/2aGCNhIlOl19
	SpckBK3D4erIORjkdECXWpXOEcaz8piKYC9Q4BagtQe1zraEHJFBoeuZ6rPTzwxH
	9D6o9Tn9YQOzoHgqvAhVWYdZn7cBIgDkskjfXdcu+7yVpyn0Xgpo109sThnqDuLg
	mTby00HPHc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8177A9333;
	Wed, 22 Aug 2012 15:39:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1B9F9332; Wed, 22 Aug 2012
 15:39:39 -0400 (EDT)
In-Reply-To: <CANYiYbE9sJNOXxxFX_xdow=tnWfUwBYOx4S0_CgaB+bUQxDSRg@mail.gmail.com> (Jiang
 Xin's message of "Wed, 22 Aug 2012 22:56:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D125498-EC91-11E1-B4F9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204087>

Jiang Xin <worldhello.net@gmail.com> writes:

> Maybe we should bypass all testcases which calling check_remote_track().

Sounds like it.
