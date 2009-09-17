From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 14/15] Add scripts to generate projects for other buildsystems (MSVC vcproj, QMake)
Date: Thu, 17 Sep 2009 22:28:28 +0200
Message-ID: <200909172228.28174.j6t@kdbg.org>
References: <cover.1253088099.git.mstormo@gmail.com> <260603a54845df34659d605fadaf663d0094c8cb.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, gitster@pobox.com, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com
To: "Marius Storm-Olsen" <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 22:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoNam-0007A1-C2
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 22:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbZIQU20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 16:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbZIQU20
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 16:28:26 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:16540 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbZIQU2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 16:28:25 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7479E2C400E;
	Thu, 17 Sep 2009 22:28:28 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 44AD3427BC;
	Thu, 17 Sep 2009 22:28:28 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128769>

On Mittwoch, 16. September 2009, Marius Storm-Olsen wrote:
> --- a/.gitignore
> +++ b/.gitignore
> @@ -179,3 +179,14 @@ configure
>  tags
>  TAGS
>  cscope*
> +*.obj
> +*.lib
> +*.sln
> +*.suo
> +*.ncb
> +*.vcproj
> +*.user
> +*.idb
> +*.pdb
> +Debug/
> +Release/

If I understand correctly, then 'make MSVC=1' still produce *.o files, not 
*.obj. But if the VC++ project is used, I expect that the *.obj, *.idb, and 
*.pdb end up in Debug/ or Release/ directories. Then why do you need entries 
for *.obj, *.idb, and *.pdb?

-- Hannes
