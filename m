From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [msysGit] crlf issues
Date: Fri, 19 Jun 2015 16:10:54 +0200
Organization: gmx
Message-ID: <b1d861878d2f0a4414490439bf865cbb@www.dscho.org>
References: <f96f4550-af8c-48b9-98ef-2c1f3282d8a7@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Rusi Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 16:11:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5x0c-0007Ny-FY
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 16:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbbFSOK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 10:10:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:61435 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbbFSOK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 10:10:56 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MV5hN-1ZcBlb37xl-00YPCz; Fri, 19 Jun 2015 16:10:54
 +0200
In-Reply-To: <f96f4550-af8c-48b9-98ef-2c1f3282d8a7@googlegroups.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:wV4xtz0vRizgCXSTPx5Xu2QaJKia59VbsODTiH0Zk9m4aiM/7Fz
 Vkjl4Ppdv2nVoQWDEPHfW/RxEr9/IZ556oKCrKazbuXYo/hRnakT2e6ciXK++CAVixN9mpC
 DcQOBmKYXhUJXF6CQiQV85BhlAHZf+ks/WpSCByNakw6kOPYHArrkwOXrKp/00k2EaC7m6V
 IHBNZB2EI+tk2j5cmGUZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ctAnkN2OwcU=:1P799k39OFpO3T9iyhdGwY
 BSkEWjve0hopGG3j8cUaNwJ4TSABv39C5BEEdn5+DUR+GTyR/iTWBaq1UDTvWGI4368ahsf/U
 /GzTwXQPtotD/aPVyQmtW/S2FWrQWk/SlFRsIXBOGMRu19OZpH5zsDmul8rb93JnDyQQ5RWvi
 QWiNLSfIzfAtxn2HO0/MY6r4hjslIXdjYuPlb+xRorkAwefmZX6bmw3SOR9QiPK+CqiMRCa0L
 o3N7rQbyy9lpSr5u1jUGSdmspnUWels7JD4QfKVdneErUyx6Ft+rf26VBVPNzBM4a3rXBaqrB
 0ersyzXNOFs9gpQd9wUXwWlkooBoQIqxFa1s6fVjWuXSbV77KOS8r6nEZKY3FYz7x694kx3Lb
 fEf6H73/gAdAcFGsHxFAN8TliDIb/gmO7vtKLHvYmSvgIJJanmKv01vpAemCMLwzlPf1I9Kzk
 FFjo+Xk8EkxBIS827iWZNLNK9EPjD9CcgDAz7/UlbrzVLshBdIQRf/VLz1mTINeOsokR+RPhS
 41tZtPWNjSkPNQgiWGM8QZABTLDk1HnBPLlXxziT9SS8TrsnhHo9w0VkvqOCDRjtsVaaQSJxb
 gY5Da3NxO01UHTfInhM5qGzCU/Zyt46pVbGUEZukcU+C/I21cKRNyTFAtD63lci1JJPJqkL5g
 +FbD+CJSAxroxOfzoo7ddJ8niEQjVR4oBpl9y565khD+rMNO4hpYWxS5XrJOiF6/CNOg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272157>

Hi Rusi,

Cc:ing the main Git list, as some of this has been discussed at the GitMerge in Paris, and some participants of that discussion might want to join this thread.
 
On 2015-06-19 14:55, Rusi Mody wrote:
> Trying to setup git.
> Majority folks are MS VS users but also some *nixers.
> 
> My current understanding/analysis of the situation:
> 
> 1. autocrlf is broken -- keep it false 
> 2. safecrlf is a cure (to some extent) -- keep it true
> 3. core.eol can be left native (or is crlf on windows/lf on *nix 
> preferred??)
> 
> And of course most crucial: 
> 4. Make sure ALL file types are covered in .gitattributes; eg
> 
> *.txt text
> *.cs text
> :
> :
> *.pdf binary
> etc
> 
> Still when we get a merge conflict the file (created by git with conflict 
> markers) shows ^M in vi
> ie I assume its unclean line endings.
> 
> Any tips what to do?

The most important preliminary question is: how cross platform is your project? If there is no risk of any developer working on a non-Windows platform, you could simply commit CRLF and be done with it.

As to autocrlf: I actually had some good experience with setting it to `input` when working with other developers.

Ciao,
Johannes
