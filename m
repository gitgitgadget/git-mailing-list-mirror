From: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: git am ~/Documents/mail-[1-9]-11.txt Patch format detection failed.
Date: Sun, 14 Aug 2011 02:20:47 -0600
Message-ID: <CAJfuBxx9Vh2rWsUA--qVrwa7Gfzboo-=D8auxXquZ8NaxqsQTg@mail.gmail.com>
References: <CAJfuBxx9Ayo8cHga+vK+Ynx5P7dhST7f=p87-qyjEzofSdZ=RQ@mail.gmail.com>
 <CALkWK0kmZLiSzSwZ9YqjZMpx3SzZ5gDC4Y6CFtSu3x2EcvE-rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	David Barr <davidbarr@google.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:23:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsVyT-0002VP-L3
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab1HNIVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 04:21:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50576 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1HNIVR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 04:21:17 -0400
Received: by pzk37 with SMTP id 37so1537753pzk.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nIvcBWCAEzHmxyMsK7oVcC7VoeAHe6RuZgyIyz7cVn4=;
        b=coewkyJGJB67JsYGfhcryrKv68i6EnJvrE56q00jj/iCoynjLNb1tZtwhtMymhF3p3
         YFHXgQytMos+RGJIQOOs+RFVS0GNi8JbtoCiLv8H3e2GQ/JsjHN9HgUvYQA2OpuAgjOL
         G4LxyN0ODEoN/Ex5G4Wl4981Km4KIN893mGLE=
Received: by 10.142.237.18 with SMTP id k18mr1204208wfh.311.1313310077109;
 Sun, 14 Aug 2011 01:21:17 -0700 (PDT)
Received: by 10.143.98.2 with HTTP; Sun, 14 Aug 2011 01:20:47 -0700 (PDT)
In-Reply-To: <CALkWK0kmZLiSzSwZ9YqjZMpx3SzZ5gDC4Y6CFtSu3x2EcvE-rQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179303>

On Sat, Aug 13, 2011 at 9:06 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi Jim,
>
> [+CC: David Barr]
>
> Jim Cromie writes:
>> git am is giving me trouble.
>>
>> Im a gmail user, and have saved a patch series by doing
>> show-original, save w rename for each patch
>> [...]
>> Ive attached mail-1-11, which applies cleanly to v3.0, but wont am.
>
> It works quite well for me after David's recent patch: 0e8341f2 (am:
> ignore leading whitespace before patch, 2011-08-08). =A0The patch has
> already made it to 'next', but hasn't hit 'master' yet. =A0Could you
> please try it and tell us if there are any issues?
>
> Thanks.
>
> -- Ram
>

thanks Ram,

I just pulled and built next branch, it worked for me.

[jimc@groucho linux-2.6]$ ../../git/git am ~/Documents/mail-[1-9]-11.tx=
t
Applying: dynamic_debug: Add __dynamic_dev_dbg
Applying: dynamic_debug: Consolidate prefix output to single routine
Applying: dynamic_debug: Remove uses of KERN_CONT in dynamic_emit_prefi=
x
Applying: dynamic_debug: Convert printks to pr_<level>
Applying: dynamic_debug: remove unused control variables
=2E..

thanks
