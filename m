From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/3] git-p4: default submit to use rename detection
Date: Thu, 21 Jan 2010 21:42:48 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001212139540.1726@xanadu.home>
References: <4B590778.30403@naughtydog.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9U6-0007NU-1f
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab0AVCmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755869Ab0AVCmu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:42:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38718 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab0AVCmt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:42:49 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KWM002KGNJCFH80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Jan 2010 21:42:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4B590778.30403@naughtydog.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137725>

On Thu, 21 Jan 2010, Pal-Kristian Engstad wrote:

> Enable git's rename detection by default. This is needed to preserve
> Perforce's history.
> 
> Removed the '-M' flag and added a '--no-detect' flag to preserve the
> old behavior.

You should keep the -M flag, even if it ends up doing nothing, for 
backward compatibility.  And --no-detect is really a bad flag name.  
Maybe --no-detect-renames instead?


Nicolas
