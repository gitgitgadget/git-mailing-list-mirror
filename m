From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-mv is not able to handle directory with one file in it
Date: Wed, 23 Nov 2005 12:07:09 +0100
Message-ID: <200511231207.09846.Josef.Weidendorfer@gmx.de>
References: <200511231141.57683.lan@ac-sw.com> <438420CC.4050303@op5.se> <200511231621.34259.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 23 12:08:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EesTB-0002m8-Ry
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 12:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVKWLHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 06:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVKWLHN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 06:07:13 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:27103 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030400AbVKWLHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 06:07:12 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 33EBF2771
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 12:07:11 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <200511231621.34259.lan@ac-sw.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12618>

On Wednesday 23 November 2005 11:21, Alexander Litvinov wrote:
> On Wednesday 23 November 2005 13:57, Andreas Ericsson wrote:
> > This is broken. It only checks if there's just one source-file
> > regardless of whether or not it resided in a subdirectory.

Yes.
For git-update-index we have to use the file inside the directory.

I just sent a patch for this.

Josef
