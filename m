From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/4] git-prompt.sh: do not print duplicate clean color code
Date: Sat, 22 Jun 2013 15:26:40 +0200
Message-ID: <20130622132640.GL20052@goldbirke>
References: <cover.1371780085.git.erdavila@gmail.com>
 <a44fecc0b75c3eacc24675aa4ec4e3a3c95c84ad.1371780085.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	artagnon@gmail.com, s.oosthoek@xs4all.nl, gitster@pobox.com
To: "Eduardo R. D'Avila" <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 15:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqNql-0003XI-WA
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 15:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab3FVN11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 09:27:27 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:64020 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185Ab3FVN10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 09:27:26 -0400
Received: from localhost6.localdomain6 (f051195150.adsl.alicedsl.de [78.51.195.150])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MbgoP-1UXTXg1jq1-00Jjgx; Sat, 22 Jun 2013 15:26:41 +0200
Content-Disposition: inline
In-Reply-To: <a44fecc0b75c3eacc24675aa4ec4e3a3c95c84ad.1371780085.git.erdavila@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:F0iuR/hFtjkD0xMfV0OQ2iH0nywfDn2RuxoaoD8IOy2
 p30/13SAdsZ9S055rhJW9Cpm0RVMm0SHpxOyQ5gRnGoQcHgzlT
 bWJxQ2UukMTlxroInemlVUho8ip7LW6hJ1KKe4Ypb4QYc4J0pL
 XWqA1PR0c16AntwRVM9Ju7f79aDr579xnGmPf49t4eZvdKWUGS
 +GEvm8JWFyTjDSrFiuEnHnGErcDB9J574rEc1GdJJx5BhD2Ms4
 43kKCdN2N1rCXczCb4SKa5GfUc4vrUpgYujSPzbaBsXqFbi6W7
 g6IQx80jkpHmXmE4XzL05vbMRtbfuS8uOSz8ot0vW7p8T97umY
 SflTQepncrMBFtQI2/3hemVYXoZu/u+NsSlTcr0B+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228706>

On Thu, Jun 20, 2013 at 11:25:28PM -0300, Eduardo R. D'Avila wrote:
> Do not print a duplicate clean color code when there
> is no other indicators other than the current branch
> in colored prompt.
> 
> Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>

Great.  I wanted to point out in the previous versions of this series
that the patch claiming to refactor coloring actually touches the test
script because it silently fixes the clean color code duplication.
Thanks for splitting that patch before I even managed to find the time
to mention it ;)
