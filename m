From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 22:43:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703112241540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070311043250.GA21331@moooo.ath.cx> <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
 <20070311162201.GA26983@moooo.ath.cx> <7vlki3wngv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVox-0005aF-RO
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbXCKVnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbXCKVnM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:43:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:37662 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932808AbXCKVnK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:43:10 -0400
Received: (qmail invoked by alias); 11 Mar 2007 21:43:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 11 Mar 2007 22:43:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+n//w+cP6ns4fPG2v0DQv0GingpLDbXBvsXBBCK6
	sw1q6FCZuPsBAk
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlki3wngv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41990>

Hi,

On Sun, 11 Mar 2007, Junio C Hamano wrote:

> Why does read-only directory have changes to begin with???

Tracking (parts of) /etc/, I change as root, but commit as another user 
(to prevent accidental corruption).

Ciao,
Dscho
