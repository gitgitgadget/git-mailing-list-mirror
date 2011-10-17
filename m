From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/4] git-gui: add smart case search mode in searchbar
Date: Tue, 18 Oct 2011 00:29:48 +0100
Message-ID: <87ipnngpsj.fsf@fox.patthoyts.tk>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
	<9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
	<CAH5451=jUS5PpMddwML36F-mH=pxxh8FsP2ZiRH2_NFBBy+Q5g@mail.gmail.com>
	<CAKPyHN2XQYrGDhfjX4G12Ggw6DuJasuYbLQvfbmikBbMezp4=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 01:29:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFwd2-0001Li-RX
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 01:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab1JQX3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 19:29:52 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:51032 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756098Ab1JQX3v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 19:29:51 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111017232949.VCLX8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 18 Oct 2011 00:29:49 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RFwcv-0000sL-PA; Tue, 18 Oct 2011 00:29:49 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id EBFDA207BF; Tue, 18 Oct 2011 00:29:48 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CAKPyHN2XQYrGDhfjX4G12Ggw6DuJasuYbLQvfbmikBbMezp4=g@mail.gmail.com>
	(Bert Wesarg's message of "Mon, 17 Oct 2011 07:32:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=YsCNshLnuF8A:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=afQi3bkrn6jeFow40qkA:9 a=ayVdYnBsbU8ON8GNZvkA:7 a=CjuIK1q_8ugA:10 a=9xyTavCNlvEA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183844>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>On Mon, Oct 17, 2011 at 00:32, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>> I don't really know tcl so I'm not certain, but it looks like you
>> never reset the case sensitive flag once it has been set by entering
>> an upper case letter. If I accidentally enter an upper case letter and
>> have set smartcase true, I would expect that deleting that character
>> would turn case sensitivity off again.
>>
>
>I never reset it, because your case is a way to search case-sensitive
>for an expression in all lower-case. For example, if you would like to
>search for 'git' case-sensitively, you would type: 'gitA^H'. A direct
>shortcut to toggle the case flag could also be of use. The other idea
>which come to mind, is to reset the case flag, if you clear the input
>field. I.e. type 'G^Hgit' would still seach case-insensitive.
>
>Bert

I don't really like the way it works at the moment. It seems very keen
to enable the case sensitive mode and you must use the mouse to disable
that. I see why you chose to make it work that way though. I think
resetting it in clearing the field makes sense.

The rest of the series looks good. The history recording is nice to have.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
