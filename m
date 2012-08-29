From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: relative objects/info/alternates doesn't work on remote SMB repo
Date: Wed, 29 Aug 2012 20:56:19 +0200
Message-ID: <503E65D3.2010809@web.de>
References: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 20:56:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6nRE-0005uP-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 20:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab2H2S4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 14:56:22 -0400
Received: from mout.web.de ([212.227.15.4]:51321 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab2H2S4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 14:56:22 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LbaBL-1TUpey2ejr-00kg4n; Wed, 29 Aug 2012 20:56:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
X-Provags-ID: V02:K0:m+d2jSDF5DLUZyZIiV7XPIlApoDZr1jvFfHNUhOY+Gp
 ySqQuUyfOF43Y82iANbZzR84PqOKSINYVP0fCPkBF+Hmz/tw32
 8MkxR6r9UYst3bQ3tTguNUWhToV3fYXkkC3tPiYHKx0fjkf57b
 XnczdSw10oXMwnjbt3jlcWitjXHyEM4pgliOKens6VJjeuokTc
 vkFelpWI/CHnN/zGWx4Jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204494>

On 29.08.12 08:43, Orgad and Raizel Shaneh wrote:
> Hi,
> 
> I have a repo accessed through //server/share/foo/repo (Using msysgit).
> 
> .git/objects/info/alternates contains '../../../bare/objects'
> 
> Running 'git status' (or almost any other action) gives the following output:
> error: object directory /server/share/foo/bare/objects does not exist;
> check .git/objects/info/alternates.
> 
> Note that it tries to access /server instead of //server.
> 
> - Orgad
> --

You may consider to ask this question in the msys mailing list
(see CC above)

(And please specify which version of msysgit you use)
