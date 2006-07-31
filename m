From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: gitweb: how to name main "action" subroutines?
Date: Mon, 31 Jul 2006 20:38:44 +0200
Message-ID: <200607312038.44337.Josef.Weidendorfer@gmx.de>
References: <eal2ic$14o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 31 20:38:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7cfC-0002xP-Sc
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 20:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWGaSis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 14:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWGaSis
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 14:38:48 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:485 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030269AbWGaSir (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 14:38:47 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 3F4B2278B;
	Mon, 31 Jul 2006 20:38:46 +0200 (MEST)
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <eal2ic$14o$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24534>

On Monday 31 July 2006 16:03, you wrote:
> I'm going to rename some gitweb subroutines to better correspond to what
> given subroutine does. I have problem: how to name main "action"
> subroutines? Currently they use git_ prefix, e.g. git_logo.
> git_project_list, git_rss, git_summary, git_heads,...

print_* or write_* ?
At least, the functions print/write the HTML code to stdout of the script.

Josef

> 
> I have thought about do_logo, or gitweb_logo, or out_logo etc., but somehow
> none is best.
