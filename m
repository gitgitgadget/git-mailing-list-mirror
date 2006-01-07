From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Sat, 7 Jan 2006 01:47:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601070142570.30029@wbgn013.biozentrum.uni-wuerzburg.de>
References: <dp3qpb$7uk$1@sea.gmane.org> <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
 <43BF05A3.8060407@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jan 07 01:47:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev2Eo-0004mn-7m
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 01:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWAGArP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 19:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWAGArP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 19:47:15 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4263 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030256AbWAGArO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 19:47:14 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id C9E1A13FF72
	for <git@vger.kernel.org>; Sat,  7 Jan 2006 01:47:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id BD0189E5
	for <git@vger.kernel.org>; Sat,  7 Jan 2006 01:47:13 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id A30528EF
	for <git@vger.kernel.org>; Sat,  7 Jan 2006 01:47:13 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 86F2F13FF72
	for <git@vger.kernel.org>; Sat,  7 Jan 2006 01:47:13 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
In-Reply-To: <43BF05A3.8060407@op5.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14234>

Hi,

we still could go back to \d.\d.\d.GIT, you know?

Using the output of git-describe only helps if you use git from the 
official repository. But when you have a private branch, they are only 
misleading. And if you use git from the official repository, you are more 
likely to take official versions anyway.

Ciao,
Dscho
