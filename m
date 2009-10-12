From: Vietor Liu <vietor@vxwo.org>
Subject: Re: [PATCH] git-gui: Fixed _main window_ for screen height equal
 600 px
Date: Mon, 12 Oct 2009 16:23:32 +0800
Message-ID: <1255335812.2326.20.camel@localhost.localdomain>
References: <1255329194-2757-1-git-send-email-vietor@vxwo.org>
	 <alpine.DEB.1.00.0910120934420.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 12 10:24:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxGCG-0008HA-2Q
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 10:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbZJLIVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 04:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbZJLIVZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 04:21:25 -0400
Received: from mail-px0-f111.google.com ([209.85.216.111]:61514 "EHLO
	mail-px0-f111.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbZJLIVY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 04:21:24 -0400
Received: by pxi9 with SMTP id 9so514767pxi.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 01:20:48 -0700 (PDT)
Received: by 10.114.7.25 with SMTP id 25mr9433982wag.21.1255335648527;
        Mon, 12 Oct 2009 01:20:48 -0700 (PDT)
Received: from ?192.168.254.100? ([123.113.93.118])
        by mx.google.com with ESMTPS id 22sm124628pzk.6.2009.10.12.01.20.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 01:20:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910120934420.4985@pacific.mpi-cbg.de>
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129995>

On Mon, 2009-10-12 at 09:35 +0200, Johannes Schindelin wrote:
>  
> So what you _actually_ do is reduce the space for the diff, no?
>

Yes. 
The _main window_ support auto resize. I was tested some way, only
modify _diff body_ space could work. The _diff body_ is part of _main
window_. 

Whether modify the commit message? 
