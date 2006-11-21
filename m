X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_NXDOMAIN,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RCVD_NUMERIC_HELO,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 21 Nov 2006 14:25:56 +0100
Message-ID: <ejuv2a$atg$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org>	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	<200611151858.51833.andyparkins@gmail.com>	<Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>	<f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>	<Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>	<Pine.LNX.4.64.0611151516360.2591@xanadu.home>	<Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 21 Nov 2006 13:32:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.11.48.246
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
In-Reply-To: <87velgs9hx.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31987>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmVjR-000322-20 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 14:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030947AbWKUNbG convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006 08:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030949AbWKUNbG
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 08:31:06 -0500
Received: from main.gmane.org ([80.91.229.2]:9140 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030947AbWKUNbD (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 08:31:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmViD-0002mW-W4 for git@vger.kernel.org; Tue, 21 Nov 2006 14:30:58 +0100
Received: from 212.11.48.246 ([212.11.48.246]) by main.gmane.org with esmtp
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21
 Nov 2006 14:30:57 +0100
Received: from t2a2e9z8ncbs9qg by 212.11.48.246 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 14:30:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Carl Worth wrote:
> Well, one of the problems is that with current git I can teach, (and =
I
> have), that there's a conceptual:
>=20
> 	pull =3D fetch + merge
>=20
> But then shortly after I have to teach an interface notion:
>=20
> 	merge =3D pull .
>=20
> So there's this goofy circular notion that people end up with
> mentally. If we fix it so that a local merge really is performed with
> "git merge <branch>" instead of "git pull . <branch>" then teaching
> pull=3Dfetch+merge really is a lot easier.

On a conceptual level, can we not perhaps explain that if

	pull =3D fetch + merge

then

	merge =3D pull - fetch

and that the latter (pull - fetch) happens to be expressed with the=20
interface as 'git pull .' ?

My 2 cents.
J=E9r=F4me
