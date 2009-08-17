From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/11] Add gitignore and ReadMe file for MSVC Build
Date: Mon, 17 Aug 2009 19:16:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171915130.4991@intel-tinevez-2-302>
References: <1250525340-412-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5om-0008Eu-OQ
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbZHQRQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbZHQRQM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:16:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:55538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754433AbZHQRQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:16:12 -0400
Received: (qmail invoked by alias); 17 Aug 2009 17:16:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 17 Aug 2009 19:16:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+51Ap/Ngy5XNP0LswQKZN75Sn1dIt9Idllem++9i
	SLaOnzGOmzl5DK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250525340-412-1-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126239>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> Add ReadMe to user how to build git with MSVC.
> Add gitignore to filter out files created file by MSVC.
> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>

Please use the plural form "files" where appropriate.

> diff --git a/compat/vcbuild/ReadMe b/compat/vcbuild/ReadMe
> new file mode 100644
> index 0000000..47c089e
> --- /dev/null
> +++ b/compat/vcbuild/ReadMe
> @@ -0,0 +1,13 @@
> +The Steps of Build Git with VS2008
> +
> +1. Create VC Build Environment.
> +
> +   git clone git://repo.or.cz/gitbuild.git
> +
> +   gitbuild include VS solution file and library such as zlib.

How, if you do not have Git?

> +2. Get Submodule
> +  
> +   git submodule update

This is missing '--init'.

Ciao,
Dscho
