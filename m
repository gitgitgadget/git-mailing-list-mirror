From: Sebastian Pipping <webmaster@hartwork.org>
Subject: "git cat-file <sha1>" shows usage but should not?
Date: Wed, 15 Apr 2009 18:50:47 +0200
Message-ID: <49E61067.6060802@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 18:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8Ld-0000k4-7o
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbZDOQuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZDOQuv
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:50:51 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:48219 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbZDOQuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:50:50 -0400
Received: from [85.179.43.251] (helo=[192.168.0.3])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Lu8K0-0001Xe-B8
	for git@vger.kernel.org; Wed, 15 Apr 2009 18:50:48 +0200
User-Agent: Thunderbird 2.0.0.19 (X11/20090216)
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116627>

Here is what I did:


$ git cat-file -t b8c11fbbffbe171c4960058fa2d96f708e57a80c
commit

$ git cat-file b8c11fbbffbe171c4960058fa2d96f708e57a80c
usage: git cat-file [-t|-s|-e|-p|<type>] <sha1>
   or: git cat-file [--batch|--batch-check] < <list_of_sha1s>
[..]

$ git --version
git version 1.6.3.rc0.1.gf800.dirty



Sebastian
