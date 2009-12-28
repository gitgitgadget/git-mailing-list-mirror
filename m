From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 14:09:49 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810048-332373020-1262002222=:5582"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?L=E9na=EFc_Huard?= <lenaic@lhuard.fr.eu.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 13:10:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPEQw-0007nh-0h
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 13:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbZL1MKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 07:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbZL1MKb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 07:10:31 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:39041 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbZL1MKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 07:10:30 -0500
Received: from [88.193.196.75] (88.193.196.75) by kirsi2.inet.fi (8.5.014)
        id 4B17EFA601030C0E; Mon, 28 Dec 2009 14:10:22 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <200912281154.09442.lenaic@lhuard.fr.eu.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135736>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810048-332373020-1262002222=:5582
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi Lénaïc,

On Mon, 28 Dec 2009, Lénaïc Huard wrote:

> The attached patch makes git configure libcurl to negotiate the most suitable 
> HTTP authentication method.
> Thanks to that patch, I manage to clone and fetch my git repository hosted on 
> my web server requesting an authentication through the « Digest  » method.

Something similar has already been queued for inclusion, and is available 
in the branch 'next', in commit b8ac923010484908d8426cb8ded5ad7e8c21a7f6. 
The patch available there requires you to set http.authAny for the libcurl 
option to be enabled.

// Martin
---1463810048-332373020-1262002222=:5582--
