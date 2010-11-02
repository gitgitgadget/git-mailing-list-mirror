From: "Chris Forbes" <chrisf@farmworkspfs.co.nz>
Subject: RE: [PATCH] Remove restriction on notes ref base
Date: Wed, 3 Nov 2010 12:28:32 +1300
Message-ID: <62BAFF6485708A40A8955546574E52655362DE@server01.FarmWorks.local>
References: <1288657003-17802-1-git-send-email-kroot@google.com> <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com> <7vsjzj1v49.fsf@alter.siamese.dyndns.org> <201011022358.11340.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6Gz-0002u2-6a
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0KDUSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:18:43 -0400
Received: from farmworkspfs.co.nz ([219.89.194.176]:24813 "EHLO
	farmworkspfs.co.nz" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752476Ab0KDUSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 16:18:41 -0400
X-Greylist: delayed 161406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2010 16:18:41 EDT
In-Reply-To: <201011022358.11340.johan@herland.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Remove restriction on notes ref base
Thread-Index: Act64SGVigrcJyTWQw2Pu23DHoz53QAA+FOA
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160753>

Hi

> Although I'm starting to wonder whether our remote -> local refspec
mappings 
> are getting too varied (i.e. confusing). Currently we have:

>  Remote repo    ->   Local repo
>  ------------------------------------------------
>  refs/heads/*        refs/remotes/$remote/*
>  refs/tags/*         refs/tags/*

What's the rationale for the implicit/magic behaviour for tags? It
causes plenty of confusion for new users, etc.

-- Chris Forbes
