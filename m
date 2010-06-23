From: Laszlo Papp <djszapi@archlinux.us>
Subject: Re: Uncommitted source and header files disappeared after a git mv 
	operation
Date: Wed, 23 Jun 2010 12:50:24 +0200
Message-ID: <AANLkTim8TblD_TUpmGR2vCjQnXMfK4WAFA3dh39dloAs@mail.gmail.com>
References: <AANLkTikeW1-Kzdyu1APSqzKGsNnny6InueWluXsKMccU@mail.gmail.com>
	<AANLkTiloMDccUDObmPXPGWI_HYVDMk57EoHxZjFUiSvi@mail.gmail.com>
	<AANLkTilNI0lq0rUqvUIdNRpubNUNqKf3_5nX3TGauvQv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jun 23 12:50:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORNXL-00019h-Kt
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 12:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab0FWKu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 06:50:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64267 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab0FWKu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 06:50:26 -0400
Received: by wyi11 with SMTP id 11so627943wyi.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 03:50:24 -0700 (PDT)
Received: by 10.216.160.66 with SMTP id t44mr2356288wek.75.1277290224800; Wed, 
	23 Jun 2010 03:50:24 -0700 (PDT)
Received: by 10.216.163.6 with HTTP; Wed, 23 Jun 2010 03:50:24 -0700 (PDT)
In-Reply-To: <AANLkTilNI0lq0rUqvUIdNRpubNUNqKf3_5nX3TGauvQv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149506>

I had some news.

I have just checked the bash history on linux, which doesn't contain
any intereting, but I have just realised the situation now, so the
following happened:

1) So the uncommitted files were on windows
2) I renamed the whole directory under linux.
3) I pushed the changes under linux
4) At last I did a git pull under windows.

The files disappeared on windows and they weren't committed :(

I use this versions on windows:
MySYSGIT: http://code.google.com/p/msysgit/downloads/detail?name=msysGit-fullinstall-1.7.1-preview20100612.exe&can=2&q=
TortoiseGIT:
http://code.google.com/p/tortoisegit/downloads/detail?name=TortoiseGit-1.5.2.0-32bit.msi&can=2&q=

Best Regards,
Laszlo Papp
