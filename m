From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git gui equivalent to git checkout -b
Date: Wed, 30 Mar 2011 13:56:39 +0100
Message-ID: <87y63wpy0o.fsf@fox.patthoyts.tk>
References: <imrapc$f7u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Matt Seitz" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 14:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4uxC-0005Fe-Rd
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 14:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab1C3M4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 08:56:49 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:2823 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750798Ab1C3M4s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 08:56:48 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20110330125647.STGF13167.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Wed, 30 Mar 2011 13:56:47 +0100
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Q4ux4-0001K5-Im; Wed, 30 Mar 2011 13:56:47 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id ED044234BE; Wed, 30 Mar 2011 13:56:39 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <imrapc$f7u$1@dough.gmane.org> (Matt Seitz's message of "Mon, 28
	Mar 2011 17:57:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=MCWc6U7z1pIA:10 a=kj9zAlcOel0A:10 a=AUd_NHdVAAAA:8 a=Rf460ibiAAAA:8 a=sovSHtb86k8SgacWyLEA:9 a=WIwe7G4_w7KBs0MR9BAA:7 a=MM9Ri0sICPrlwIBp7pJXPOWjsPIA:4 a=CjuIK1q_8ugA:10 a=JfD0Fch1gWkA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170381>

"Matt Seitz" <matseitz@cisco.com> writes:

>What is the git gui equivalent to "git checkout -b"?
>
>I have a working tree with changes that I don't want to commit to "master" 
>yet.  So I want to create a new branch to contain my changes.
>
>If I go to "Branch->Checkout", I don't see an option to create a new branch.
>
>If I go to "Branch->Create", I see an option to "Checkout After Creation", 
>but I want to be sure that is the right choice.

Create.

% echo junk >> git-gui.sh
% git status --short --branch
## master
 M git-gui.sh

% git gui # selected Branch, Create, Name=pt/demo, Checkout after Creation
% git status --short --branch
## pt/demo
 M git-gui.sh

If we don't select 'Checkout after Creation' then we don't move to the
new branch. It is created but we remain on master.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
