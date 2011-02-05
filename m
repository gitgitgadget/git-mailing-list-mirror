From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git to p4 conversion
Date: Sat, 5 Feb 2011 01:53:08 +0100
Message-ID: <AANLkTi=onuZtGWPTYvw_-rKsR6t-R2UquAUPLHAm-TVV@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
	<AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
	<loom.20110204T004658-497@post.gmane.org>
	<AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
	<AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
	<AANLkTi=_spLE-KMnou-2LLQjwq4FUZxNr9pk7D9C=4PK@mail.gmail.com>
	<AANLkTi=dZdSqcNckyU7Lb2Zj-khfj=Xiyzbv7LSC+zT2@mail.gmail.com>
	<AANLkTimGaPQ=hRp+2pvw-hAOg+wp50nvc_sv9jNTay=n@mail.gmail.com>
	<AANLkTimJm81V0D8_j3OfZTcEkyn_jd6_QB2nv8T69JBY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	Ian Wienand <ianw@vmware.com>
To: Endre Czirbesz <endre@czirbesz.hu>
X-From: git-owner@vger.kernel.org Sat Feb 05 01:55:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlWR3-0002jN-GQ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 01:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab1BEAxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 19:53:10 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50000 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab1BEAxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 19:53:09 -0500
Received: by gxk9 with SMTP id 9so1145438gxk.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 16:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=imSxWvlmtHhNIRbxGzQ4yZo8cjV9UIS3Bb0f0zq2mos=;
        b=Nvdxywhtw6wR969gK+etEWio1Qed7a5YpmAToyZ0OZlUcglLzSd7ot8dop44MXrh79
         p8/aZTDl8fOWLIl68+sRcPTt8Qr3vQ+ViYT9lHXGV7KVLGevatIE8LBdu/qCn4VbWCix
         L/6LmgFpk+EFTR5L7j9vaqUsfOgLI41l1b2BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Tlt0pjP1EfyGTK9PhZph1Kj4CawLf5SNBIW1w1oWyaAOVjcDy3lIUmA1oMjGGTDcrs
         D2+7wi8l6yaFYN5eaONtOYmMyuoWNjDSHvvSw33/HTwfpBTtvAtwIQ/kOzRBzx7yX5ae
         aoTBITCS3TVz/85LGw/NEWQZ0Z0QWs6KYURr4=
Received: by 10.100.229.17 with SMTP id b17mr3177258anh.80.1296867188572; Fri,
 04 Feb 2011 16:53:08 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Fri, 4 Feb 2011 16:53:08 -0800 (PST)
In-Reply-To: <AANLkTimJm81V0D8_j3OfZTcEkyn_jd6_QB2nv8T69JBY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166068>

On Fri, Feb 4, 2011 at 5:52 PM, Endre Czirbesz <endre@czirbesz.hu> wrote:
> Hi Vitor,
>
> 2011/2/4 Vitor Antunes <vitor.hda@gmail.com>:
>>> I dropped the whole directory, and then recreated it, I do not know
>>> any better 'cleanup'. :)
>>
>> Which directory did you drop? Was is the git repository or the P4 workspace?
>> You need to clean up the later. Basically, a "rm -rf
>> path/to/p4_workspace" and a "p4 sync -f" should do the trick :)
>
> It is almost the same in my case. :)
> My p4 client root is ~/work/, my project dir is ~/work/projdir (and at
> the moment this is the only directory within ~/work/), and I dropped
> the latter.
> And then it was created again by git-p4 clone.

I... wonder if we're maybe talking past one another here...

Let's take a few things from the top, just in case... If we think
about the perforce setup (before we start doing any git stuff)... You
have a perforce workspace/client-spec, right? That is - a setup that
tells perforce where you want the files to be placed on your hard
drive when you do a standard "p4 sync". Let's call it ~/p4root/ and
let us say that your project will then be synced by perforce to
~/p4root/myproj/

When you want to do a git-p4 clone, you should definitely be *outside*
of ~/p4root/ . Let's say we have a ~/gitroot/ as well. So do cd
~/gitroot/ so that the git-p4 clone will be under ~/gitroot/myproj/ ;
and then do all the git-p4 stuff (clone, add remote, fetch, rebase,
sync, submit).

I think Vitors point was that before you do git-p4 submit, you should
clean - not ~/gitroot/myproj - but ~/p4root/myproj/.

This is probably not something that you need to do everytime you want
to submit back to perforce, but since we have had some rounds with
trial-and-error with this, we have probably placed some dirty files
inside the perforce folders... Make sure that you don't have files
opened in perforce before you sync.

Clearer? More confused? Best of luck anyway :)

    -- Tor Arvid
