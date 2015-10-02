From: Spencer Graves <spencer.graves@prodsyse.com>
Subject: Re: can't install on OS X
Date: Fri, 2 Oct 2015 08:10:07 -0500
Message-ID: <560E822F.3010802@prodsyse.com>
References: <560E2936.6020101@prodsyse.com>
 <CANoM8SWptQZPOJVwX48h6D8HEV1jo=gYzJcvsp2nc2BnX4TrKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 15:12:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi06e-0000LF-Be
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 15:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbbJBNKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 09:10:31 -0400
Received: from cuda.garlic.com ([216.139.0.68]:38058 "EHLO Cuda.garlic.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbbJBNKa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 09:10:30 -0400
X-ASG-Debug-ID: 1443791408-089ede16d0638e80001-QuoKaX
Received: from nake.garlic.com (nake.garlic.com [216.139.50.102]) by Cuda.garlic.com with ESMTP id 77GK3UEvIsZNOyGV; Fri, 02 Oct 2015 06:10:08 -0700 (PDT)
X-Barracuda-Envelope-From: spencer.graves@prodsyse.com
X-Barracuda-Apparent-Source-IP: 216.139.50.102
Received: from cpe-75-87-186-149.kc.res.rr.com ([75.87.186.149] helo=Spencer-Bryce-Gravess-MacBook-Pro.local)
	by nake.garlic.com with esmtpsa (UNKNOWN:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <spencer.graves@prodsyse.com>)
	id 1Zi06C-0006HN-HV; Fri, 02 Oct 2015 06:10:08 -0700
X-ASG-Orig-Subj: Re: can't install on OS X
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <CANoM8SWptQZPOJVwX48h6D8HEV1jo=gYzJcvsp2nc2BnX4TrKg@mail.gmail.com>
X-Barracuda-Connect: nake.garlic.com[216.139.50.102]
X-Barracuda-Start-Time: 1443791408
X-Barracuda-URL: https://cuda.garlic.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at garlic.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using per-user scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.23114
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278920>



On 10/2/2015 7:02 AM, Mike Rappazzo wrote:
> Looks like you have it installed properly.  The typical usage is from
> the terminal, (try `git --version` to be sure).


a-MacBook-Pro:~ sbgraves$ git --version
xcrun: error: invalid active developer path 
(/Library/Developer/CommandLineTools), missing xcrun at: 
/Library/Developer/CommandLineTools/usr/bin/xcrun


???

> There is also a
> pretty great UI packaged with git called git-gui.  You should be able
> to make a link or an alias to it in your Applications folder (or
> invoke it from the terminal `git gui`).


       How?


       Thanks very much for the reply.


       Spencer Graves
>
> On Fri, Oct 2, 2015 at 2:50 AM, Spencer Graves
> <spencer.graves@prodsyse.com> wrote:
>> What's the procedure for installing Git under OS X 10.11?
>>
>>
>> I downloaded "git-2.5.3-intel-universal-mavericks.dmg" per instructions.
>> When I tried to install it, I first had trouble because it wasn't from the
>> Mac App Store nor an "identified developer".  I ultimately found "System
>> Preferences" > "Security & Privacy" > "Click the lock to make changes" >
>> entered password > AND clicked to "Allow apps downloaded from: Anywhere".
>> Then the install appeared to run and  proclaimed, "The installation was
>> successful."  However, git is not listed under "Applications", and RStudio
>> says, "Git was not detected on the system path."
>>
>>
>> "README.txt" says I need "sudo mv /usr/bin/git /usr/bin/git-system".  I
>> tried that and got, "mv: rename /usr/bin/git to /usr/bin/git-system:
>> Operation not permitted" (after entering my password).  [My directory now
>> includes "/usr/local/git", and "/usr/bin" includes git, git-cvsserver,
>> git-receive-pack, git-shell, git-upload-archive, and git-upload-pack.]
>>
>>
>> Suggestions?  Thanks, Spencer Graves
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
