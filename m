From: Hans Ginzel <hans@matfyz.cz>
Subject: Re: How to rebase one branch of the merge commit?
Date: Mon, 9 Feb 2015 12:38:31 +0100
Message-ID: <20150209113831.GA58641@artax.karlin.mff.cuni.cz>
References: <20150201184214.GA89666@artax.karlin.mff.cuni.cz>
 <1422818908.29011.6.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 12:38:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKmfm-0006Vf-V6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 12:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759835AbbBILie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2015 06:38:34 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:48743 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbbBILie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 06:38:34 -0500
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 1975)
	id 6C8B3468001; Mon,  9 Feb 2015 12:38:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1422818908.29011.6.camel@kaarsemaker.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263563>

On Sun, Feb 01, 2015 at 08:28:28PM +0100, Dennis Kaarsemaker wrote:
>On zo, 2015-02-01 at 19:42 +0100, Hans Ginzel wrote:
>> Hello!
>>
>> Suppose following git history:
>>
>> A=E2=80=93M=E2=80=93C
>>   /
>> B
>>
>> How to achieve this with commits metadata preserving?
>>
>> A=E2=80=93M'=E2=80=93C'
>>   /
>> B'
>>
>> I did
>>
>> git checkout B
>> git add something_not_in_other_commits
>> git commit --amend
>>
>> So I have B'. How to continue, please? My git version is 1.7.1 (Cent=
os 6.5).
>
>Assuming you have a branch pointing to C and no uncommitted changes:

>1) git checkout branch-that-points-to-c
>2) git rev-parse branch-that-point-to-c
>3) git reset --hard A
>4) git merge B'

This creates a new merge comit (M').

>5) git cherry-pick sha1-that-was-the-output-of-step-2

This does nothing: "Finished one cherry-pick. nothing to commit (workin=
g directory clean)"

Thank you, but how to preserve date, message author of the original mer=
ge commit (M)
to the new one (M'), please?

Regards,
HG
