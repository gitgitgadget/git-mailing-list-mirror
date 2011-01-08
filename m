From: David Chanters <david.chanters@googlemail.com>
Subject: Re: Creating CVS-style patch headers with git-diff
Date: Sat, 8 Jan 2011 13:43:31 +0000
Message-ID: <AANLkTinx9qM=fjH53UodY0G870Ne3wpFiFEgEGNXxOY7@mail.gmail.com>
References: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
	<4D284F57.2000808@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 14:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbZ53-0005a1-BB
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 14:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab1AHNne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 08:43:34 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53138 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab1AHNnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 08:43:32 -0500
Received: by fxm20 with SMTP id 20so17681746fxm.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=zRR0rb6jmwy96TSolb9VXwut39J96QgW5uCB3pg6ifk=;
        b=Bz9btZWwTncenaY7b+a784jbHdZWl14FWF5/4rKleJ8RYOiH8ik4V/V2X38b0qqjEC
         YR+zSGfLr0Ivxi22MSeBOnTsUq9XBtYCoYsBAriuU9I+Jba3+yO7PvJ1oMmShRNxSNZG
         BM1Iw4bKH9cj2NY6ldFr7Zy5MBTlwIjP4KSKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LQYHQE+jVcDSXLO9R9jVLxBAWRTi1nkqq3P3CGya8aViXP0OJai1g8B+GJpwnvs9z+
         kdH38xffnM8yHB7hGKU2JlvQV6ricPTUWETqVoeC3Ex2I5KO5wnE4QqE6h+NjRwS8auA
         R1QiLuUq0fqkdoWn0fECrjTsI/y+nEwfVYPxM=
Received: by 10.223.83.11 with SMTP id d11mr5773676fal.37.1294494211240; Sat,
 08 Jan 2011 05:43:31 -0800 (PST)
Received: by 10.223.86.197 with HTTP; Sat, 8 Jan 2011 05:43:31 -0800 (PST)
In-Reply-To: <4D284F57.2000808@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164821>

Hi Tomas,

On 8 January 2011 11:49, Tomas Carnecky <tom@dbservice.com> wrote:
> What exactly do you need to change in the patch? Remove the index line? The
> '--git' string? Remove or change the a/, b/ prefix?

Well, any one of those goals, really.  I just want to generate a patch
that CVS won't barf on -- what that means if not needing to use the
"-p" option to patch because git outputs a/ b/ prefix lines.  Your
"--no-prefix" option does that much, which might be enough.

I did read, I think on this list, that the GNU Patch program
interprets these "diff --git" lines?  What exactly are they for, do
you know?  I mean, even if I just did:

git diff --no-prefix

Would the presense of the other meta-data, such as the "diff --git"
line as well as the "Index" line cause any problems when applying this
patch in CVS (I suppose now, my question doesn't have to apply to CVS
at all, more likely it will apply to any file sets)?  I am not sure
how GNU Patch uses this meta information, and I assume "git diff" adds
it for a good reason.

I hope this all makes sense?

David
