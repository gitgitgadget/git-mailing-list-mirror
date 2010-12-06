From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git-gui: commit message box doesn't respond to enter (only return)
Date: Mon, 06 Dec 2010 20:55:45 +0000
Message-ID: <87mxoiy626.fsf@fox.patthoyts.tk>
References: <20101126170956.25856.63131.reportbug@alsuren-thinkpad.cbg.collabora.co.uk>
	<20101126203855.GA23258@burratino>
	<20101126232825.GE3264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Laban <alsuren+debbugs@gmail.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 22:01:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPiBD-00040P-Jq
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab0LFVA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 16:00:57 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:34671 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753709Ab0LFVA5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 16:00:57 -0500
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PPiB0-0000vV-Q4; Mon, 06 Dec 2010 21:00:52 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PPi66-0005xc-Lm; Mon, 06 Dec 2010 20:55:46 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 8FE0F218F6; Mon,  6 Dec 2010 20:55:45 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20101126232825.GE3264@localhost.localdomain> (Konstantin
	Khomoutov's message of "Sat, 27 Nov 2010 02:28:25 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163021>

Konstantin Khomoutov <flatworm@users.sourceforge.net> writes:

>On Fri, Nov 26, 2010 at 02:38:55PM -0600, Jonathan Nieder wrote:
>
>> David Laban wrote at http://bugs.debian.org/605041:
>> 
>> > Package: git-gui
>> > Version: 1:1.7.2.3-2
>> > Severity: minor
>> >
>> > If I click into the messagebox and hit enter, nothing happens.
>> >
>> > This is annoying because if I'm adding a new paragraph to my commit message, 
>> > I will often do <click> <enter><enter> <start typing as normal>
>> >
>> > Don't ask me why I do this. I think enter is a lighter/easier to press
>> > key than return, and is also on the path that my hand takes between the mouse
>> > and the rest of the keyboard.
>> >
>> > I have also provisionally reported the following bug in tk, but I feel like
>> > a bit of a n00b for doing so.
>> >
>> > http://sf.net/tracker/?func=detail&aid=3119824&group_id=12997&atid=112997
>> 
>> I can't reproduce this because this laptop does not have a distinct
>> "numpad enter" key.
>I've tested it on Debian Squeeze and added another comment on the
>upstream bug report. In short: KP_Enter is not bound to any action in
>Tk text widgets in X11, at least in 8.5.9.
>
>But git-gui can be trivially patched to support this; that would be a
>one-lineer. So if it is desired and will be accepted, I could prepare a
>patch.
>

I've no problem with that. On unix the messagebox bindings are applied
directly to the dialog window (.__tk__messagebox) and it does include
Dialog in the bindtags so you could use
 bind Dialog <Key-KP_Enter> { .... }
except that might affect other dialogs too. That might not be a
problem. On Windows the messagebox is native so the bindings there are
whatever are standard.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
