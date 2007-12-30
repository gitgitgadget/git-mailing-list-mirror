From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to find a commit containing a given sha1
Date: Sun, 30 Dec 2007 11:56:16 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712301153361.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <46dff0320712300238p67e82c66r5bf49900dd21aefa@mail.gmail.com>
 <46dff0320712300239m54ab8280w9c1ec6347f095b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 11:56:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8vqX-0006Lr-1K
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 11:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXL3K4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 05:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbXL3K4T
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 05:56:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:44080 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbXL3K4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 05:56:18 -0500
Received: (qmail invoked by alias); 30 Dec 2007 10:56:16 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp058) with SMTP; 30 Dec 2007 11:56:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+j210Lb62jJ6zoi7fQBM5+evdaW/3VxOQI6WYAVL
	9GOILOoQlSO2+Z
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <46dff0320712300239m54ab8280w9c1ec6347f095b40@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69348>

Hi,

On Sun, 30 Dec 2007, Ping Yin wrote:

> Given a blob sha1, is there a simple way to find which file it 
> corresponds to and which commit it is contained?

Yes.  "git log --raw --abbrev=40 --all" and then search for the blob name 
(SHA-1).

Hth,
Dscho
