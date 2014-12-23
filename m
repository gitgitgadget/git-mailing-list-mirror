From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [msysGit] Re: Announcing Git for Windows 1.9.5
Date: Tue, 23 Dec 2014 13:50:17 +0100
Message-ID: <54996509.6060402@web.de>
References: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info> <0e0bcbf8-6e05-422d-ad4a-a85b1134947b@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Tressel <ptressel@myuw.net>, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Dec 23 13:50:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Ov6-0007Ig-ET
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 13:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbaLWMuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 07:50:32 -0500
Received: from mout.web.de ([212.227.17.11]:50742 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152AbaLWMub (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 07:50:31 -0500
Received: from macce.local ([93.222.20.216]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LeLSr-1XXLta2wrF-00qFDz; Tue, 23 Dec 2014 13:50:24
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <0e0bcbf8-6e05-422d-ad4a-a85b1134947b@googlegroups.com>
X-Provags-ID: V03:K0:HFRFf/K2VYbchOzEI8h8ysA02ahMRIuKpWtasyvU64siNsNGHpu
 /I/tz8PHHgAhtz3BWja1XWzsrErjkL3h8brZlRQZSnKmkFWmo/0IjUEtfp2Ns3Luczrkaf7
 jt6XGtud54vn1q/mLp3/R2MqiZYcmnGuhRHRSQwUfPvYVvtAaI7mb9UH94XJLtCQn/y54X1
 3YgzZ1fMBPjuDSGADOuAQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261729>

On 2014-12-23 10.48, Pat Tressel wrote:
> 
>             Bugfixes
>             - Safeguards against bogus file names on NTFS (CVE-2014-9390).
> 
> 
> Apologies, but...is it possible to get back an old version?  I installed this version, and it no longer recognizes non-English characters that appear in some file names we have in our repo.  I'm only guessing that this has to do with the vuln fix.
> 
> (If you want, I can file a bug report -- this should be easy to reproduce, as all that's needed should be to clone our repo (https://github.com/flavour/eden) and do "git status" -- two files will appear as deleted, but they're not.  Hmm, it may be necessary to do the git clone with an old version, if the new version is unable to handle those file names.)
> 
> Thanks!
> 
> -- Pat

You may consider to convert the repo into unicode,
and update all clients accessing this repo.


https://github.com/kblees/git/wiki
