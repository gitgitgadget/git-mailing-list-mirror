From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: HTTP redirection with git-clone/git-fetch ?
Date: Thu, 10 Nov 2005 14:09:48 +0100
Message-ID: <200511101409.48618.Josef.Weidendorfer@gmx.de>
References: <200511092331.36421.Josef.Weidendorfer@gmx.de> <20051110002419.GB4051@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 10 14:11:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaCBj-0005Ek-3x
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 14:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVKJNJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 08:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKJNJz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 08:09:55 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:14323 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750770AbVKJNJz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 08:09:55 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id CEC3F283D
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 14:09:51 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051110002419.GB4051@reactrix.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11482>

On Thursday 10 November 2005 01:24, Nick Hengeveld wrote:
> On Wed, Nov 09, 2005 at 11:31:36PM +0100, Josef Weidendorfer wrote:
> 
> > This seems because git-fetch should understand redirections, too.
> > I am not familiar to the curl API. So perhaps another one can try to
> > fix this?
> 
> This should fix it, although it still tries every GET with the original
> URL which is a bit inefficient.

Thanks, I just sent a patch for git-clone, including your patch, to
Junio.

Josef
