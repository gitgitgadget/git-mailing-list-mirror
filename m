From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk repo
Date: Wed, 09 May 2012 10:33:16 -0700
Message-ID: <7vhavptg2r.fsf@alter.siamese.dyndns.org>
References: <4FA9BDAD.6080401@onimail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pedro Rodrigues <pedro@onimail.net>
X-From: git-owner@vger.kernel.org Wed May 09 19:33:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSAlP-0003gE-Mf
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab2EIRdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:33:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab2EIRdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:33:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 297E76659;
	Wed,  9 May 2012 13:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mhwold+nvidrGy+B8WE9M/RZa0c=; b=aHXBpC
	p8ETHc6g6h23PN/YpJCNX49xjYnGDdJIYtstxUKSmHA5TxvlcgMbx6d2sDxVxQBc
	tOdTj4pxNCEDxdPf3WoqP2cOsjiUakODlXBV5Dh7qWk/6jK9WH6WDMgagQb7kvgs
	KS0ytXRqg32mtaKJx8tDPecBGojmITBlZZ4lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ccO/fPm0T1gH8kzxpZRI/nMWEWIcTT9m
	L1GgP6nGRYIrc+XQryY1OaDj7tz0tHCZEtGrI8ILT8cQGfAwrjzQ6cimYDt7RrTY
	wkd/qShmH0Ea0lOtHa/XXzruWqXKNdaNHarQLRC7PKhUxkHKBsjl32+wnjK7+NP6
	trRQfX65SKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 210A86658;
	Wed,  9 May 2012 13:33:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A12106657; Wed,  9 May 2012
 13:33:17 -0400 (EDT)
In-Reply-To: <4FA9BDAD.6080401@onimail.net> (Pedro Rodrigues's message of
 "Wed, 09 May 2012 01:43:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10470FC4-99FD-11E1-9D9C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197482>

Pedro Rodrigues <pedro@onimail.net> writes:

> I'd like to hack a bit on gitk.

Paul Mackerras <paulus@samba.org> is the guy you want to pull from, ask
guidances from, and send your patches to.

	[remote "paulus"]
	        url = git://ozlabs.org/~paulus/gitk.git
