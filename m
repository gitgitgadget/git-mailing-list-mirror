From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 3/3] git-gui: new config to control staging of untracked files
Date: Tue, 18 Oct 2011 09:24:31 +0100
Message-ID: <87ipnmn1vk.fsf@fox.patthoyts.tk>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
	<03727ea04f20c953e7de3f84ab1724a8360ca2c4.1318620267.git.bert.wesarg@googlemail.com>
	<20111017183430.GA2540@sandbox-rc>
	<CAKPyHN3pKUSLTs8_5QMo5i+=3w7KXAHJjDOfQ1XYG92ZbQ1SeA@mail.gmail.com>
	<20111017192706.GB3168@sandbox-rc> <87r52bgrky.fsf@fox.patthoyts.tk>
	<CAKPyHN2g2aVTB_Q7ZmpjfdznmUmkf=aodDmFEWgq6_KCMQe62w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 10:24:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG4yY-0004pm-9M
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 10:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab1JRIYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 04:24:36 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:57228 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936Ab1JRIYe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 04:24:34 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111018082432.QXFH8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 18 Oct 2011 09:24:32 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RG4yO-0004DD-Or; Tue, 18 Oct 2011 09:24:32 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 109FC207C2; Tue, 18 Oct 2011 09:24:31 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CAKPyHN2g2aVTB_Q7ZmpjfdznmUmkf=aodDmFEWgq6_KCMQe62w@mail.gmail.com>
	(Bert Wesarg's message of "Tue, 18 Oct 2011 08:34:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=OtpQyoxz0-8A:10 a=8nJEP1OIZ-IA:10 a=mK_AVkanAAAA:8 a=FP58Ms26AAAA:8 a=Y7828TS4AAAA:8 a=Rf460ibiAAAA:8 a=44VJrjDaTsSXeCfXPA8A:9 a=g2jvCtp7_PMn2yiLv1wA:7 a=wPNLvfGTeEIA:10 a=9xyTavCNlvEA:10 a=IUdvcfx5MVUA:10 a=yDdNMYjkDqErbghB:21 a=1ZLwYlMtuQRr00DH:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183874>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>On Tue, Oct 18, 2011 at 00:51, Pat Thoyts
><patthoyts@users.sourceforge.net> wrote:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>>
>>>Hi,
>>>
>>>On Mon, Oct 17, 2011 at 08:47:50PM +0200, Bert Wesarg wrote:
>>>> On Mon, Oct 17, 2011 at 20:34, Heiko Voigt <hvoigt@hvoigt.net> wro=
te:
>>>> > Here I am wondering whether we have a similar mechanism in git g=
ui like
>>>> > in core git that makes yes,true,1 equivalents (and similar with =
other
>>>> > values) ?
>>>>
>>>> But it is not only yes,true,1 or no,false,0 its a tristate with th=
e
>>>> third state 'ask'. For booleans, there is such functionality in gi=
t
>>>> gui. See is_config_true and is_config_false. Reusing these for thi=
s
>>>> tristate wouldn't work. The current check here is indeed very stri=
ct
>>>> and should be loosen by at least ignoring the case, surrounding
>>>> spaces, and allow also true/false. But also note, that this variab=
le
>>>> can be set via the Options menu, so you can't mistype it.
>>>
>>>Well if using git config you can ;-). I just wanted to ask whether w=
e
>>>may already have machinery which supports such tristate.
>>>If we do not I think the current "strict" configuration is fine. In =
most
>>>cases the user will use the gui itself to configure such behavior so
>>>thats no big deal.
>>>If someone needs that it can be added later on.
>>>
>>>Thanks, Heiko
>>>
>>
>> This set of 3 patches looks fine. I was a bit dubious of the new
>> phrasing for the ask condition but it is growing on me. I wonder it =
it
>> might be worth including the number of untracked files to be staged =
too
>> eg: "Stage 15 untracked files?"
>>
>> =A0 set reply [ask_popup [mc "Stage %d untracked files?" \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [llength $un=
tracked_paths]]]
>
>I thought about to list the untracked files in the dialog, but
>couldn't find a good template dialog for this. But the number is
>definitely worth I think.
>
>>
>> Loosening the check we can do using
>> =A0switch -glob -- [get_config gui.stageuntracked] {
>> =A0 =A0[Nn]* { set reply 0}
>> =A0 =A0[Yy]* { set reply 1}
>> =A0 =A0default { ... }
>> =A0}
>
>I think this is too loose ;-)

Heh - I'll add the number in the query dialog and leave the config chec=
k
unchanged then.
Thanks for all your work.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
