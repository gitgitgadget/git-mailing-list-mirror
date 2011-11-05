From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/2] git-gui: make config gui.warndetachedcommit a boolean
Date: Sat, 05 Nov 2011 00:48:26 +0000
Message-ID: <878vnvo0md.fsf@fox.patthoyts.tk>
References: <0f4995b5df707782c73ec83171fb2f512ae887ef.1319312280.git.bert.wesarg@googlemail.com>
	<CAKPyHN24RwNjJanaMQ0AjXc2iorFw=taCmcS-iuNt0vQ46_TOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 01:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMUR3-00012l-JU
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 01:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab1KEAsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 20:48:32 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:8698 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752121Ab1KEAsb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 20:48:31 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111105004828.NOWR12094.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 5 Nov 2011 00:48:28 +0000
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RMUQu-0004k5-Bf; Sat, 05 Nov 2011 00:48:28 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id A5A4521CCC; Sat,  5 Nov 2011 00:48:27 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CAKPyHN24RwNjJanaMQ0AjXc2iorFw=taCmcS-iuNt0vQ46_TOg@mail.gmail.com>
	(Bert Wesarg's message of "Thu, 3 Nov 2011 12:27:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=Jolto1Igi64A:10 a=8nJEP1OIZ-IA:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=gt60NLyXC1wIhnloI2QA:9 a=sT2rnqnCZ6xWtw5FWNUA:7 a=wPNLvfGTeEIA:10 a=psFEWSvwNxIA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184811>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>On Sat, Oct 22, 2011 at 21:39, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>> ---
>> =A0lib/commit.tcl | =A0 =A02 +-
>> =A0lib/option.tcl | =A0 =A01 +
>> =A02 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/lib/commit.tcl b/lib/commit.tcl
>> index 372bed9..e27e148 100644
>> --- a/lib/commit.tcl
>> +++ b/lib/commit.tcl
>> @@ -263,7 +263,7 @@ proc commit_commitmsg {curHEAD msg_p} {
>> =A0 =A0 =A0 =A0global is_detached repo_config
>> =A0 =A0 =A0 =A0global pch_error
>>
>> - =A0 =A0 =A0 if {$is_detached && $repo_config(gui.warndetachedcommi=
t)} {
>> + =A0 =A0 =A0 if {$is_detached && [is_config_true gui.warndetachedco=
mmit]} {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set msg [mc "You are about to commit =
on a detached head.\
>> =A0This is a potentially dangerous thing to do because if you switch=
\
>> =A0to another branch you will loose your changes and it can be diffi=
cult\
>> diff --git a/lib/option.tcl b/lib/option.tcl
>> index 719103a..f7f866b 100644
>> --- a/lib/option.tcl
>> +++ b/lib/option.tcl
>> @@ -156,6 +156,7 @@ proc do_options {} {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{i-0..99 gui.commitmsgwidth {mc "Comm=
it Message Text Width"}}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{t gui.newbranchtemplate {mc "New Bra=
nch Name Template"}}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{c gui.encoding {mc "Default File Con=
tents Encoding"}}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {b gui.warndetachedcommit {mc "Warn be=
fore commiting to a detached head"}}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{s gui.stageuntracked {mc "Staging of=
 untracked files"} {list "yes" "no" "ask"}}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set type [lindex $option 0]
>
>Pat,
>
>if you're interessted in this patch, please fix the typo in the second
>hunk, mentioning 'commiting'.
>
>Also shouldn't this variable be called gui.warndetachedhead?
>
>Thanks.
>
>Bert

I've applied this with the spelling correction and also gitdir already
does [file join] on its args so squashed a slight modification there
too.

The flag is for warnings about commits. Calling 'warndetachedhead'
sounds like something that would warn you when you changed to a detache=
d
head - not for when you are about to commit to one so I think the name
is fine.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
