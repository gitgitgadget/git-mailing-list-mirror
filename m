From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] pack-refs --all
Date: Sun, 8 Oct 2006 14:02:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610081401000.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4pufkz55.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 14:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWXMd-0000lA-Rw
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 14:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWJHMCg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 08:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWJHMCg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 08:02:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:47843 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751115AbWJHMCg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 08:02:36 -0400
Received: (qmail invoked by alias); 08 Oct 2006 12:02:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 08 Oct 2006 14:02:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pufkz55.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28533>

Hi,

On Sun, 8 Oct 2006, Junio C Hamano wrote:

> This changes 'git-pack-refs' to pack only tags by default.

Since there is not really a high cost attached, why not migrate towards 
only-packed-refs? (Of course, this means that git-update-ref should learn 
to update in-place)?

Ciao,
Dscho
