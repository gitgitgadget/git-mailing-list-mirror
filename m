From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: git remote --mirror bug?
Date: Fri, 14 Mar 2008 14:05:56 +0100
Organization: Transmode AB
Message-ID: <1205499956.7589.4.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 14:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja9dH-0007xB-9y
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006AbYCNNGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 09:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755904AbYCNNGD
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:06:03 -0400
Received: from mail.transmode.se ([83.241.175.147]:19687 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755507AbYCNNGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:06:00 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 14 Mar 2008 14:05:57 +0100
X-Mailer: Evolution 2.12.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77219>

Created a mirror like so:
 git --bare init 
 git remote add --mirror os2kernel /usr/local/src/os2kernel

Git fetch errors out
 git fetch os2kernel 
fatal: * refusing to create funny ref 'refs/stash' locally

Also 
git remote show os2kernel 
* remote os2kernel
  URL: /usr/local/src/os2kernel
Warning: unrecognized mapping in remotes.os2kernel.fetch: +refs/*:refs/*

git --version
git version 1.5.4.3

 Jocke
