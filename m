From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/3] Fix unnecessary (mtime) updates of files during
 merge
Date: Thu, 03 Mar 2011 09:52:21 -0800
Message-ID: <7vpqq8852i.fsf@alter.siamese.dyndns.org>
References: <1299132792-17497-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 18:52:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvChd-0002Ur-Ll
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 18:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab1CCRwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 12:52:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab1CCRwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 12:52:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 106423F11;
	Thu,  3 Mar 2011 12:53:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=XoHBvVGkvPKom8rkHJBjTfjDgEo=; b=au0/gO
	cpTs1froCHvvE4LS0cEd7T/7CIzGOvAFFNraNxxCyMXnXu6GHTciK3d2p0oUHHjn
	fknhmoNFccRFyAwQ9tMG8TEGuiF9PZjst9KlXh3Txs6fr+FdSCjhD4lBUqhEerda
	yLXoD9Q9pSk2+FEv0KIovPmLWoUp3q521/DZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CB89bvedbp/z0i/EsX8csWiDsktsisyF
	hmWUlz6lFV27CSgqBHJxO7zwSfxBKBzQuiMppiXc0ZUG9g9Q1Flf7jl9eHGQ61N0
	1onhlLoJAlOoKsIvZWOnHhB72xOS7nbdFxGjYCEtjRMW1bH1lzcy83LCZOpdfuK9
	Htsb29jrLtk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C37C03F0F;
	Thu,  3 Mar 2011 12:53:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8385E3F0B; Thu,  3 Mar 2011
 12:53:44 -0500 (EST)
In-Reply-To: <1299132792-17497-1-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Wed\,  2 Mar 2011 23\:13\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31CBAFC6-45BF-11E0-A524-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168402>

This seems to more-or-less match what I queued in 'pu' yesterday (v2 with
fix-ups from the list).

Thanks.
