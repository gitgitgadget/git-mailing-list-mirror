From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Repository authenticity question
Date: Sat, 13 Jun 2009 17:45:04 +0200
Message-ID: <4A33C980.40003@drmicha.warpmail.net>
References: <200906131527.03450.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?S8SBcmxpcyBSZXBzb25z?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 17:46:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFVQk-0005s9-Ur
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 17:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbZFMPp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2009 11:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZFMPp6
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 11:45:58 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35740 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752462AbZFMPp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 11:45:57 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 4225235E8FC;
	Sat, 13 Jun 2009 11:46:00 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 13 Jun 2009 11:46:00 -0400
X-Sasl-enc: 2mYujDiVi+B518zw1Y6XDP2/lBQ0J0890UPXAJ0UITtF 1244907959
Received: from localhost.localdomain (p5485A135.dip0.t-ipconnect.de [84.133.161.53])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 89D4231531;
	Sat, 13 Jun 2009 11:45:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090609 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <200906131527.03450.Karlis.Repsons@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121505>

K=C4=81rlis Repsons venit, vidit, dixit 13.06.2009 17:26:
> Hi,
> It would be good to know what did Linus meant, when he said "and they=
 will=20
> fail" about people, who would try changing some git projects' history=
 (that=20
> is, the content, that is added already)? If I loose my repository com=
pletely,=20
> can I still know, that those contributions there are the same after I=
 pull=20
> and how? What contents can be deleted, while still retaining consiste=
ncy?
>=20
> Regards,
> K=C4=81rlis

The sha1 ("object name") of a commit depends not only on its contents,
but on all its predecessors. So if you know one commit's sha1 to be
"original" you know for all its ancestors.

Michael
