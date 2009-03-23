From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [bug?] git-format-patch produces a 0-byte long patch for the first
 commit
Date: Mon, 23 Mar 2009 11:34:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0903231119110.4871@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 11:35:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhVI-0005Ik-By
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbZCWKeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbZCWKeF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:34:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:47863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753042AbZCWKeC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:34:02 -0400
Received: (qmail invoked by alias); 23 Mar 2009 10:33:59 -0000
Received: from p57BD2C84.dip0.t-ipconnect.de (EHLO axis700.grange) [87.189.44.132]
  by mail.gmx.net (mp006) with SMTP; 23 Mar 2009 11:33:59 +0100
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX19UPkVKot9UWqX1Wi8UhR0sdQOtX6L0OEQjiIIIxG
	L4zGLwNW/5qMc5
Received: from lyakh (helo=localhost)
	by axis700.grange with local-esmtp (Exim 4.63)
	(envelope-from <g.liakhovetski@gmx.de>)
	id 1LlhTs-0001We-0Y
	for git@vger.kernel.org; Mon, 23 Mar 2009 11:34:08 +0100
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114277>

Hi,

I noticed some special "features" of the first git commit, which seem at 
least inconsistent to me, even though I've got some explanations on IRC.

E.g., the sequence

mkdir x
cd x
git-init
echo hi > greating
git-commit -a
git-format-patch -1

produces a 0-byte long patch. git-format-patch HEAD^ produces an error, 
whereas with more than one commit it produces tha last patch. Yes, I know 
about "--root" and that it does allow to extract the very first commit.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
