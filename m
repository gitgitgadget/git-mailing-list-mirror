From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/2] gitk: Fix the geometry when restoring from zoomed state
Date: 18 Sep 2009 14:24:13 +0100
Message-ID: <87d45obd36.fsf@users.sourceforge.net>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	<8763bkcsxb.fsf@users.sourceforge.net>
	<19122.10359.725107.949551@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexy Borzenkov <snaury@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Sep 18 15:24:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ModSL-0001ZR-O7
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 15:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbZIRNYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 09:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755479AbZIRNYR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 09:24:17 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:38131 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754836AbZIRNYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Sep 2009 09:24:16 -0400
Received: from [172.23.170.141] (helo=anti-virus02-08)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1ModRi-00028q-Dq; Fri, 18 Sep 2009 14:24:18 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1ModRg-00076m-0c; Fri, 18 Sep 2009 14:24:16 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 1EA5D51843; Fri, 18 Sep 2009 14:24:14 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <19122.10359.725107.949551@cargo.ozlabs.ibm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128796>

Paul Mackerras <paulus@samba.org> writes:

>Pat Thoyts writes:
>
>> The patch to handle the geometry of a restored gitk by Alexy Borzenkov
>> causes the position of the columns to creep each time the application
>> is restarted.  This patch addresses this by remembering the application
>> geometry for the normal state and saving that regardless of the actual
>> state when the application is closed.
>
>So this patch replaces Alexey's patch, then?  The context in your patch
>doesn't match the changes made in Alexey's patch AFAICS.

Correct. I posted a response to Alexy's patch saying I'd post an
alternative as I had trouble with the columns resizing and creeping
due to the assertion of 'wm state normal' during the settings save
each time.
See
 http://thread.gmane.org/gmane.comp.version-control.git/128026/focus=128652
The context of mine should be the gitk repository master (was
c21398be).

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
