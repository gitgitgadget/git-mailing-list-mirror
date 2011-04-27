From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: preserve-merges fails on
 merges created with no-ff
Date: Wed, 27 Apr 2011 10:29:52 -0700
Message-ID: <7vfwp38uwf.fsf@alter.siamese.dyndns.org>
References: <1303357080-25840-1-git-send-email-andrew.kw.w@gmail.com>
 <4DB77E53.7070206@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8Z3-0001ub-Vv
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706Ab1D0RaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 13:30:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759701Ab1D0RaF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 13:30:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17A6B4A45;
	Wed, 27 Apr 2011 13:32:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=73PQ+uNFDIJozV0pQC3i2/E3C8k=; b=TR9ln0
	aqEmT0p7dvntUIe1VFXgCGGEg5/805fx2GQfAPsAZ7iexBnUKtYXoVOxp6hXYCOT
	6scUsFsJIYHnld3AaCsp3mIXwaBXYFRGBq5F1VnQef4QkZv3L1iP7Lh1k6W+JJN5
	7yhbmALn3w8CgkaFCHVyUGWB3aHxPPEh4oKwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ETv4BGZ2JICpeOqmpZy6XicZn6p9OosQ
	uIRy88j8YRa6GmJI3Xv2xeHypYuV7LcuwB/sIYoqmvssbliH3EPXlRsOpls/2rhv
	0A00lbiLnPKnqgYG6/JU3ihL//afvgjOxmqoWoudcAsJOtoihmD5/LSM3qzE3jgH
	wSrS7CrZN88=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE0DD4A44;
	Wed, 27 Apr 2011 13:31:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD7AA4A41; Wed, 27 Apr 2011
 13:31:55 -0400 (EDT)
In-Reply-To: <4DB77E53.7070206@sohovfx.com> (Andrew Wong's message of "Tue,
 26 Apr 2011 22:24:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41B2E26E-70F4-11E0-8628-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172251>

Andrew Wong <andrew.w@sohovfx.com> writes:

> Could someone please take a look at this patch?

Can you add a test for this change, perhaps to either t3409 or t3414?
