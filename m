From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v3 0/5] Documentation/format-patch: more hints on
 submitting patches
Date: Thu, 14 Apr 2011 21:11:00 -0500
Message-ID: <20110415021100.GA19829@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
 <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:11:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAYVC-0007ug-TU
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 04:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab1DOCLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 22:11:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43192 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab1DOCLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 22:11:10 -0400
Received: by yxs7 with SMTP id 7so974715yxs.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 19:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+HMYRUgQTpgfriP/0AQrDLdY6Fscd40cHzUyQhBfYXk=;
        b=tc1W4rVKHpXGXmf8oBYPl/KbJnzwQIiPvkiqFRV0hH1U9zDX2wxQtSc4uMu66ZxPzO
         q4YREF0F78LR+FaG9dOEu/FOhSkFIMQPUHGgwzD1l8L8QIRwbGXSZsyhfa1/oS29tszz
         T7F5I8U0YW3oEfrNv18L6DtqiN52QsSntJR7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CAPklPqTpbBI1XZEHWwGd+VtPn089bHyi4RCrH3Qveb38U5Bsa4OqXP0EABhokxc1L
         pgU+tUrsQ3bAgWcSW9driqKexyOE0oMmxWd3f3DK60/fhfBTUUZgk5gn7kaKDLkhwsXQ
         KrWuYdUbW8BDRNElZl0UmUduLFbxc2RRdg+l0=
Received: by 10.150.48.28 with SMTP id v28mr2281409ybv.428.1302833470250;
        Thu, 14 Apr 2011 19:11:10 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.ameritech.net [69.209.64.230])
        by mx.google.com with ESMTPS id q33sm86379yba.28.2011.04.14.19.11.07
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 19:11:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171576>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -linkgit:git-am[1], linkgit:git-send-email[1]
>> +linkgit:git-am[1], linkgit:git-send-email[1], linkgit:git-imap-send[1],
>> +Documentation/SubmittingPatches
>
> Hmm, I suspect this is (1) bad because the end users without the source
> may not have access to it, and (2) bad because it may indicate that there
> are hints and tricks in SubmittingPatches file, which narrowly targets
> developers of this project, but they would also be helpful to the general
> audience.  Perhaps some text needs moving from there to here?

Yep, true.  How about this?

Patch 1 explains the "canonical" and "with scissors" formats of mails
with patches.  It's basically the same as before, except with lots of
nice suggestions from Junio incorporated.

Patch 2 explains how new patch submitters can test their tools before
unleashing them on the world.  It should be common sense, but...  The
text is taken from Documentation/SubmittingPatches.

Patch 3 is rough; it exposes the Thunderbird MUA-specific hints.  Help
making it accurate and consistent with git-imap-send(1) would be very
much appreciated

Patch 4 contains KMail hints from SubmittingPatches; help would
appreciated in making sure that's still accurate, too.

Patch 5 contains the famous GMail hints, finally spreading them out
in EXAMPLES sections where they belong.

Maybe this can be a good starting point for future changes.

Jonathan Nieder (5):
  Documentation: describe the format of messages with inline patches
  Documentation: explain how to check for patch corruption
  Documentation: hints for sending patches inline with Thunderbird
  Documentation: publicize KMail hints for sending patches inline
  Documentation: publicize hints for sending patches with GMail

 Documentation/SubmittingPatches    |  207 +++-------------------------------
 Documentation/git-format-patch.txt |  217 ++++++++++++++++++++++++++++++++++++
 Documentation/git-imap-send.txt    |   29 +++++
 Documentation/git-send-email.txt   |   19 +++-
 4 files changed, 277 insertions(+), 195 deletions(-)
