From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Include version check and test for tearoff menu entry
Date: Tue, 15 Feb 2011 00:31:39 +0000
Message-ID: <8762smdtp0.fsf@fox.patthoyts.tk>
References: <20110212164344.GA19433@book.hvoigt.net>
	<AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
	<20110213134753.GC31986@book.hvoigt.net>
	<20110213135714.GE31986@book.hvoigt.net>
	<878vxilndt.fsf_-_@fox.patthoyts.tk>
	<20110214213148.GB50815@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@gmail.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 01:31:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp8pa-0000lD-GF
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 01:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab1BOAbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 19:31:45 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:53406 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082Ab1BOAbo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 19:31:44 -0500
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Pp8pR-00036j-Bm; Tue, 15 Feb 2011 00:31:41 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Pp8pQ-0004mg-Bv; Tue, 15 Feb 2011 00:31:40 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id A746E217C4; Tue, 15 Feb 2011 00:31:39 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20110214213148.GB50815@book.hvoigt.net> (Heiko Voigt's message
	of "Mon, 14 Feb 2011 22:31:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166800>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>Hi,
>
>On Mon, Feb 14, 2011 at 01:03:24PM +0000, Pat Thoyts wrote:
>> The --all option for git fetch was added in v1.6.6 so ensure we have a usable version before adding
>> the menu items.
>> Sometimes people use tearoff menus and these offset the entry indices by one.
>> 
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> ---
>> 
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> >It just came to my mind that I probably should implement a version check
>> >of the commandline to ensure that this option is available. Thats why I
>> >tagged only this patch with RFC.
>> >
>> >Cheers Heiko
>> 
>> The posted patch seems fine except that an error is reported if tearoff
>> menus are present. So this patch accommodates tearoff's. I looked up
>> when the --all option was added (1.6.6) and skip adding the menu entry
>> if we have an older version.
>> 
>> Seems to do the right thing.
>
>Works and looks good to me as well. Did not know about tearoff menues
>how do you get those?
>
>Cheers Heiko
>
>P.S.: I discovered a whitespace issue in line 258 which came from my patch.
>Could you correct that?

Sure - squashed in.

The tearoff's appear by default on unix but are disabled on windows as
they are not normal gui features on that platform. Search for
*Menu.tearOff 0 in git-gui.sh. Unix users can disable these using the
.Xresources file adding *Menu.tearOff: 0

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
