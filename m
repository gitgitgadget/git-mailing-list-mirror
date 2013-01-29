From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] README: fix broken mailing list archive link
Date: Tue, 29 Jan 2013 11:06:09 -0800
Message-ID: <7v4nhzq066.fsf@alter.siamese.dyndns.org>
References: <1359456039-20562-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0GW1-0003uS-FU
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361Ab3A2TGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 14:06:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754326Ab3A2TGM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:06:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A946DB548;
	Tue, 29 Jan 2013 14:06:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tXtrggdkd4syeeXn29Sw+sCu3Tk=; b=aLKL/s
	2XGoRZ0u+uoxBb1rwYrhXQ41aKfSKbYLsngPi0AL0wE+gPCw0zD0s4rmO3g/AuHe
	scqEEosZdocIAexjloEEMBTGYrPqJYZf+C1Tz5UfnxS/KXfLz7FIG3Ve1aHvSrrR
	vmDi83bjyii3DyZIAPlfT+e0LDBl9O5vfTrT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bqdqX/lQ3zSYvvlPQhydhINyIvheIYLC
	8XWHvvbZhHKoZrQmycu7grykAhUWSeQxWc0LWCKm8+arcsX7pUt4O0s2sypX+f4g
	18nShLqhzU6p8y5LhH5uTugh/mu1EONHU+tul+jX+2YyQZ9fPLqQqCvymXPV59r1
	loCncvbyFgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E24DB547;
	Tue, 29 Jan 2013 14:06:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1063B546; Tue, 29 Jan 2013
 14:06:10 -0500 (EST)
In-Reply-To: <1359456039-20562-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 29 Jan 2013 16:10:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1B4D008-6A46-11E2-8E44-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214956>

How about doing this instead, to update all outdated or incorrect
information in that file?  In addition to the marc.info update,

 - refer to gmane;

 - git-scm.org gives a CNAME with less commercial feeling to the
   same thing;

 - "A note from the maintainer" is not usually followed by useful
   discussion to discuss status, direction nor tasks;

 - There is no separate "What's in git (stable/topics)".

 README | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/README b/README
index 49713ea..5b83a9a 100644
--- a/README
+++ b/README
@@ -38,7 +38,7 @@ CVS users may also want to read Documentation/gitcvs-migration.txt
 ("man gitcvs-migration" or "git help cvs-migration" if git is
 installed).
 
-Many Git online resources are accessible from http://git-scm.com/
+Many Git online resources are accessible from http://git-scm.org/
 including full documentation and Git related tools.
 
 The user discussion and development of Git take place on the Git
@@ -47,11 +47,10 @@ requests, comments and patches to git@vger.kernel.org (read
 Documentation/SubmittingPatches for instructions on patch submission).
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
-available at http://marc.theaimsgroup.com/?l=git and other archival
-sites.
-
-The messages titled "A note from the maintainer", "What's in
-git.git (stable)" and "What's cooking in git.git (topics)" and
-the discussion following them on the mailing list give a good
-reference for project status, development direction and
-remaining tasks.
+available at http://news.gmane.org/gmane.comp.version-control.git/,
+http://marc.info/?l=git and other archival sites.
+
+The maintainer frequently sends the "What's cooking" reports that
+list the current status of various development topics to the mailing
+list.  The discussion following them give a good reference for
+project status, development direction and remaining tasks.
