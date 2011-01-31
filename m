From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Mon, 31 Jan 2011 13:39:27 +0000
Message-ID: <AANLkTinKQRfwaMpGQiDCkh1RerQ_MrakwvNLAqgmbF9A@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
 <1290648419-6107-1-git-send-email-vitor.hda@gmail.com> <AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
 <AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
 <AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
 <AANLkTi=PPN69uuJmUBDHKtmn59DzUbdk=Qu4Ug-kok89@mail.gmail.com>
 <AANLkTi=kmcWn9WWbhA4bMZ5bEo1imacEugT0BcOU9jry@mail.gmail.com>
 <AANLkTinCL6+oTAbh4WpsWHx8cZ8cxZvQxSO9EX_xsHh0@mail.gmail.com> <AANLkTinrALdy9w7K50r=k-oMV9V5+7+LKvui_DSmJ6nK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 14:41:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pju0P-00064H-Nk
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 14:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab1AaNlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 08:41:16 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47454 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1AaNlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 08:41:15 -0500
Received: by qwa26 with SMTP id 26so5472607qwa.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0EGeLMs22MoMzT0Pa0kx9HlwOGDEo1S1E3oAZAaa5yY=;
        b=ECjl1d2YlmAt6/1mzYIUvJnBqhgSod3mza7wPz9Wv7tmKeJM+5iImMSW3ohTjrulUD
         XRrZnKOxldAUw8cR+rBjPB0+3akKB8jEBwO92P3Jk/QmNwhFJ1Sj+fIoSNk8ovP9/Ko2
         JZdLXWLONEM7KeHtNIPp0b7hG7yRInevEf3Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JQRJu79UPxMlwxO1FJAvG2Q9reDgSc46Ncx3Q/UqXb75K9DTPi3jSAIL3nQs5bfTl8
         Cbbtprx/t+ULOftVS1j2Gzd4MTLDqoAuHxrV8h2YQr4UDZbNS7/hMwHt+x+X4vIgR1/f
         U0RGWX5SNolnffoOvAw46Yj7FjcYEGo5mO5vM=
Received: by 10.224.6.149 with SMTP id 21mr6350582qaz.321.1296481229908; Mon,
 31 Jan 2011 05:40:29 -0800 (PST)
Received: by 10.220.192.8 with HTTP; Mon, 31 Jan 2011 05:39:27 -0800 (PST)
In-Reply-To: <AANLkTinrALdy9w7K50r=k-oMV9V5+7+LKvui_DSmJ6nK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165729>

Hi Thomas,

On Mon, Jan 31, 2011 at 12:51 PM, Thomas Berg <merlin66b@gmail.com> wrote:
>> Maybe I'm not seeing some obvious limitation, but I can't imagine a
>> branching structure that can't be imported into git. Could please you
>> give me an example?
>
> Here I was thinking of the fact that git-p4 (last time I checked the
> implementation ) uses the list of branch specs in Perforce for
> figuring out the parent of a branch. Our branch specs have changed
> over time (they are used for different integration purposes), so they
> are no longer usable for this purpose.

My personal git-p4 script uses a configuration option to define the
list of branches. I also added an option to get the list of branches
filtered by user (p4 branches -u), which avoids waiting for the server
since I don't have any branches defined.

> I also discovered bugs in git-p4: in some cases, if the first submit
> to a new branch in Perforce is not identical to the branch it derives
> from, the import was not correct.

Another thing that I modified was the following lines:

1559                         for (prev, cur) in
zip(self.previousDepotPaths, depotPaths):
1560                             for i in range(0, min(len(cur), len(prev))):
1561                                 if cur[i] <> prev[i]:
1562                                     i = i - 1
1563                                     break

This tries to find the root directory of all branches, but does that
comparing char by char. So, if you have something like:

//depot/branches/branch
//depot/branches/branch_test1
//depot/branches/branch_test2

It will assume that your root branch is //depot/branches/branch, which is wrong.
I've modified this to split the string by "/" and compare those items,
making sure it will detect //depot/branches as the root directory.

> One other issue with Perforce, CVS and many other systems is that they
> branch per file. Therefore Perforce can represent partial merges
> between two branches, which git cannot. Because of this, translating
> merges in Perforce to merges in git is not always possible or
> desirable:
> - if you integrate just one file from one branch to another in
> Perforce, and leave the rest unmerged, you probably want to represent
> it as a normal git commit (not a merge)
> - if you merge almost everything, but leave out a file for some
> reason, you may still want to represent it as a merge in git

Yes, merge detection is something that is working. I never tried to
look into this because I don't find it too important for my work flow.

> The git-p4raw tool has excellent handling of merges, see details in
> this file around line 4300:
> https://github.com/samv/git-p4raw/blob/master/git-p4raw
> It supports several algorithms for automatic merge detection, as well
> as manually changing it after the import is done.

I'll have to look into this later :)

Bye,
-- 
Vitor Antunes
