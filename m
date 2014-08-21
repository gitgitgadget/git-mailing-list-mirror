From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Bug in Git 1.9.4 (20140815) for Windows - cannot clone from SVN
Date: Thu, 21 Aug 2014 12:00:42 +0200
Message-ID: <53F5C34A.8080400@virtuell-zuhause.de>
References: <592191693.140260.1408614788186.open-xchange@patina.store>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Reiner Nothdurft <reiner@jnc-business.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 12:00:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKPAq-0005id-MI
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 12:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbaHUKAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 06:00:49 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:59793 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750791AbaHUKAs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Aug 2014 06:00:48 -0400
Received: from p5ddc3a77.dip0.t-ipconnect.de ([93.220.58.119] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XKPAk-0006Uo-N4; Thu, 21 Aug 2014 12:00:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <592191693.140260.1408614788186.open-xchange@patina.store>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1408615248;0e9d494a;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255605>

Am 21.08.2014 um 11:53 schrieb Reiner Nothdurft:
> Hi all,
>  
> I tried to move a repository from SVN to Git, but all my tries - on three
> different machines running Windows 7 with the latest patches - failed with the
> same reason. I am running the latest version of Git for Windows
> 1.9.4-preview-20140815. One of my first steps was to clone the repository from
> my server into my local file system, which led to the following reproducible
> error:
>  
> Command: git svn clone svn:////jnc
> C:\Program Files (x86)\Git\bin\perl.exe: *** unable to remap C:\Program Files
> (x86)\Git\bin\libneon-25.dll to same addre ss as parent -- 0x850000
>       0 [main] perl.exe" 1608 sync_with_child: child 10460(0x184) died before
> initialization with status code 0x1
>     748 [main] perl.exe" 1608 sync_with_child: *** child state child loading
> dlls C:\Program Files (x86)\Git\bin\perl.exe: *** unable to remap C:\Program
> Files (x86)\Git\bin\libsvn_repos-1-0.dll to same  address as parent -- 0x850000
> 5066339 [main] perl.exe" 1608 sync_with_child: child 13188(0x198) died before
> initialization with status code 0x1
> 5067125 [main] perl.exe" 1608 sync_with_child: *** child state child loading
> dlls
>  
> Same issue when I add parameters for the local path, trunk, branches, etc.
> Moving back to Git 1.9.2 for Windows fixed this issue finally. Meanwhile I heard
> from a collegue, that the issue also did not appear with 1.9.4 preview 20140611.

This was mentioned in the release notes, a fix is outlined in
https://github.com/msysgit/msysgit/pull/245.
