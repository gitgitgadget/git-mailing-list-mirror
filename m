From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH] git-gui: make sure placement of panedwindow
 sashes 	happens correctly on startup
Date: Sun, 02 May 2010 21:00:50 +0200
Message-ID: <4BDDCBE2.7040204@kdbg.org>
References: <20100501182918.GA19769@atlantic.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, msysgit@googlegroups.com
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun May 02 21:01:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ePe-0000NN-5B
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 21:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab0EBTBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 15:01:00 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:35896 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751516Ab0EBTA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 15:00:59 -0400
Received: from [77.118.71.226] (77.118.71.226.wireless.dyn.drei.com [77.118.71.226])
	by bsmtp.bon.at (Postfix) with ESMTP id A17D7CDF82;
	Sun,  2 May 2010 21:00:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <20100501182918.GA19769@atlantic.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146194>

Am 01.05.2010 20:29, schrieb Adam Spiers:
> diff --git a/git-gui.sh b/git-gui.sh
> index 8996d2d..9585d7f 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3466,6 +3466,7 @@ $main_status show [mc "Initializing..."]
>   catch {
>   set gm $repo_config(gui.geometry)
>   wm geometry . [lindex $gm 0]
> +update
>   if {$use_ttk} {
>   	.vpane sashpos 0 [lindex $gm 1]
>   	.vpane.files sashpos 0 [lindex $gm 2]

This flashes git-gui briefly with the default size before it resizes to 
the final size on startup. Not that it matters a lot, because the 
incorrect sash position is much more annoying than this flashing.

But I do wonder why gitk does not have the same problem with its sashes...

-- Hannes
