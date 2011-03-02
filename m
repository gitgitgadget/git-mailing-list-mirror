From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 0/2 v2] Adding Beyond Compare as a merge tool
Date: Wed, 02 Mar 2011 00:28:06 +0000
Message-ID: <87hbbmqsbt.fsf@fox.patthoyts.tk>
References: <4D6A355C.3000805@gmail.com>
	<7voc5wk5wl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	Chris Packham <judge.packham@gmail.com>, charles@hashpling.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 01:28:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuZvc-0007OM-9W
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 01:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab1CBA21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 19:28:27 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:51388 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755799Ab1CBA20 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 19:28:26 -0500
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PuZvT-0002XP-BT; Wed, 02 Mar 2011 00:28:23 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PuZvI-0007NG-7l; Wed, 02 Mar 2011 00:28:12 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 59EC121850; Wed,  2 Mar 2011 00:28:06 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7voc5wk5wl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 27 Feb 2011 22:52:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168285>

Junio C Hamano <gitster@pobox.com> writes:

>Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> Sebastian Schuberth (2):
>>   mergetool--lib: Sort tools alphabetically for easier lookup
>>   mergetool--lib: Add Beyond Compare 3 as a tool
>>
>>  Documentation/git-difftool.txt         |    4 +-
>>  Documentation/git-mergetool.txt        |    4 +-
>>  Documentation/merge-config.txt         |    8 +-
>>  contrib/completion/git-completion.bash |    2 +-
>>  git-gui/lib/mergetool.tcl              |  101 +++++++------
>>  git-mergetool--lib.sh                  |  247 +++++++++++++++++---------------
>>  6 files changed, 195 insertions(+), 171 deletions(-)
>
>Hmm, I really would have liked if you took the hint and separated git-gui
>bits into separate patches.
>
>I saw Tested-by from Chris, so I'll add that to what is queued on 'pu',
>ask Pat to keep an eye on the ss/git-gui-mergetool branch, and then merge
>my ss/mergetool--lib branch to 'master' during my next integration run.

Where is this branch?

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
