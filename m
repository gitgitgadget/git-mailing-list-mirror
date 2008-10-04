From: "Li Frank-B20596" <Frank.Li@freescale.com>
Subject: RE: [QGit] [PATCH] Modify Highlight Color at File Context View.
Date: Sat, 4 Oct 2008 22:32:09 +0800
Message-ID: <7FD1F85C96D70C4A89DA1DF7667EAE9607A45A@zch01exm23.fsl.freescale.net>
References: <gbak2u$v9b$1@ger.gmane.org> <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net> <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net> <e5bfff550809260337o1523995ele3333c0de9295393@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9607A217@zch01exm23.fsl.freescale.net> <e5bfff550809270547n15a210e3y386278db00966945@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9605EA4E@zch01exm23.fsl.freescale.net> <e5bfff550809302347r59621e09sdea5c679ef3794c8@mail.gmail.com> <e5bfff550810032319s57a0cd52m37aeb8d801019150@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 16:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Km8DH-0008GQ-KS
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 16:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbYJDOcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 10:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYJDOcT
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 10:32:19 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:50261 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbYJDOcS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Oct 2008 10:32:18 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m94EWFGa001277
	for <git@vger.kernel.org>; Sat, 4 Oct 2008 07:32:15 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m94EWDY4007161
	for <git@vger.kernel.org>; Sat, 4 Oct 2008 09:32:14 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <e5bfff550810032319s57a0cd52m37aeb8d801019150@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [QGit] [PATCH] Modify Highlight Color at File Context View.
Thread-Index: Ackl6TWRP3Y1ctl/TP6sWVep+nffvAARERkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97471>

 
Marco:
	
	It is difference between my patch and you applied patch. 

Git diff HEAD^
-	item->setForeground(b);
+		item->setForeground(fore);
+		item->setForeground(back);
 		item->setFont(f);

In my patch:

-		item->setForeground(b);
+		item->setForeground(fore);
+		item->setBackground(back);

It should be setBackground(back), not setForeground(back);


Best regards
Frank Li

-----Original Message-----
From: Marco Costalba [mailto:mcostalba@gmail.com] 
Sent: Saturday, October 04, 2008 2:20 PM
To: Li Frank-B20596
Cc: git@vger.kernel.org
Subject: Re: [QGit] [PATCH] Modify Highlight Color at File Context View.

On Wed, Oct 1, 2008 at 8:47 AM, Marco Costalba <mcostalba@gmail.com>
wrote:
> On Mon, Sep 29, 2008 at 3:27 AM, Li Frank-B20596
<Frank.Li@freescale.com> wrote:
>> Marco:
>>
>>          I don't get my patch by git-pull.
>>          There are not my patch at
>> http://git.kernel.org/?p=qgit/qgit4.git;a=summary.
>>
>> best regards
>> Frank Li
>> ________________________________
>
> I have pushed to my local repo, I will be able to push to public repo 
> only this week end.
>

Ok. Now is pushed to public repo.

Frank, are you sure it works? for me it does not seem to make any
difference.

Marco
