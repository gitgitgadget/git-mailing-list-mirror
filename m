From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Hunk splitting in "git gui"
Date: Fri, 28 Dec 2007 16:37:45 +0100
Message-ID: <1CD46F56-71FE-408B-AC9D-E416754862AE@wincent.com>
References: <3F129AD6-EA27-4584-B5C8-2866964AB93E@wincent.com> <4774EE35.10905@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 28 16:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8HHs-00014B-6p
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 16:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXL1Phu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Dec 2007 10:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbXL1Phu
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 10:37:50 -0500
Received: from wincent.com ([72.3.236.74]:35270 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922AbXL1Phu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Dec 2007 10:37:50 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBSFblPA011837;
	Fri, 28 Dec 2007 09:37:48 -0600
In-Reply-To: <4774EE35.10905@viscovery.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69289>

El 28/12/2007, a las 13:38, Johannes Sixt escribi=F3:

> Wincent Colaiuta schrieb:
>> I'd use "git gui" a lot more if I could split hunks in it (like you =
=20
>> can
>> in "git add --interactive").
>>
>> Problem is, I have zero knowledge of Tcl/Tk. Can someone who has
>> knowledge of this offer an opinion on whether this would be a =20
>> feasible
>> project for a beginner? I'm willing to have a shot at it, but =20
>> before I
>> embark on this I'd like to know if others consider it useful and =20
>> doable!
>
> Look at the sub-thread that started here:
>
> http://article.gmane.org/gmane.comp.version-control.git/68091
>
> Be sure not to skip the explanation why --unidiff-zero is dangerous.

Ah, yes now I remember seeing that thread. I didn't actually like what =
=20
was proposed in that patch (hunk-splitting on arbitrary, user-=20
selectable lines) and much prefer what "git add --interactive" does =20
(explode a hunk deterministically into multiple hunks wherever there =20
are intervening context lines).

Cheers,
Wincent
