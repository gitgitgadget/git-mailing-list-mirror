From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE;
 it may be the user's cwd
Date: Thu, 15 Mar 2012 01:12:04 -0700
Message-ID: <7vvcm6jnaj.fsf@alter.siamese.dyndns.org>
References: <7vlin3qdpt.fsf@alter.siamese.dyndns.org>
 <1331769333-13890-1-git-send-email-johan@herland.net>
 <7vipi6l52w.fsf@alter.siamese.dyndns.org>
 <7v7gyml4g7.fsf@alter.siamese.dyndns.org>
 <CALKQrgfpM-y=9O=h33jxirVoOO8dHHO8tWCR9RatxTottpRXFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	david@tethera.net, pclouds@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S85nD-0001cz-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760151Ab2COIML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 04:12:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35689 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760102Ab2COIMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 04:12:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEE0D5341;
	Thu, 15 Mar 2012 04:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bedkwjvA1fXqkFUNKFr9JTXRs/c=; b=BsmT4I
	tvVLspsROn2jNnC8Ree9xmnd3rPbVm8UZ5yeVBXyYPL7fehbnM04NXZljcM9Wswa
	gGhGKIdMbFHDpYuK5aHeL7r5vblRLVFVQ5KNclDwG3RwvTIAcN0GhW7HZ/OzjkkM
	dwBJOvdCDGdno9DeYcsgYQmPFSkiFu+L/1rwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g6hDpEwqnuATBMlV83EITkFMNy82lHwK
	71IyTJTcH8r8Ia8mWh2zVotR6NyvJXFwGmEuM2xllF3FkxSYYSknAz3wR0lyc2LV
	fWPA89f4aSJak2ecTkiN86aryQ8L7AclsKWu7vToGe6ZCeihDlLQW1aokWzksl8C
	XPKnY/ywr+0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D407B5340;
	Thu, 15 Mar 2012 04:12:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63A61533F; Thu, 15 Mar 2012
 04:12:05 -0400 (EDT)
In-Reply-To: <CALKQrgfpM-y=9O=h33jxirVoOO8dHHO8tWCR9RatxTottpRXFA@mail.gmail.com> (Johan
 Herland's message of "Thu, 15 Mar 2012 08:39:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D557698-6E76-11E1-AED6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193197>

Johan Herland <johan@herland.net> writes:

> ... The patch
> below looks good to me, and should become patch #3 in this series,
> with my "3/2" patch being adjusted accordingly and becoming patch #4.
> Do you want me to send the whole series again, or is it easier for you
> to simply fix it up yourself?

I'd rather not to do this myself, as this alleged #3 in v2 was written
merely as a response to the "refactoring dir.c:remove_dir_recursively is
ugly", without reading other parts of the patch (i.e. the logic you use to
decide when to call this function with what arguments) at all.

Thanks.
