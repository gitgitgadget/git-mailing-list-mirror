From: Wincent Colaiuta <win@wincent.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 11:15:11 +0100
Message-ID: <9A4AC53D-BCFA-4BEE-BD53-AA7F29781454@wincent.com>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 14 11:16:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja6x9-00079t-2Z
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 11:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYCNKPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 06:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbYCNKPQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 06:15:16 -0400
Received: from wincent.com ([72.3.236.74]:41663 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332AbYCNKPP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 06:15:15 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2EAFCA4002973;
	Fri, 14 Mar 2008 05:15:13 -0500
In-Reply-To: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77200>

El 14/3/2008, a las 10:46, Geoff Russell escribi=F3:

> This should be simple! I have a series of commits:
>
>           1---2---3---4---5
>
> I want to go back to 3 but not branch, so I want
>
>           1---2---3---4---5---3
>
> ?
>
>         git checkout 3...
>
> gets me the commit on a detached head, but I don't know how to put =20
> this back
> as the HEAD.
>
> I'm on git 1.5.0.5

How about?

   git cherry-pick the-sha-1-id-of-commit-3

Wincent
