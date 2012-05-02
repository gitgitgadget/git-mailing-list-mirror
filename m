From: Rolf Leggewie <foss@rolf.leggewie.biz>
Subject: broken bash completion
Date: Wed, 02 May 2012 22:09:26 +0800
Message-ID: <4FA14016.8050503@rolf.leggewie.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 16:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPaFZ-000122-00
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab2EBOJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 10:09:46 -0400
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:60082 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755092Ab2EBOJp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 10:09:45 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mx.arcor.de (Postfix) with ESMTP id F2DD41AB9BC
	for <git@vger.kernel.org>; Wed,  2 May 2012 16:09:43 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id EC8E21F90A2
	for <git@vger.kernel.org>; Wed,  2 May 2012 16:09:43 +0200 (CEST)
Received: from [192.168.3.3] (unknown [110.55.115.205])
	(Authenticated sender: leggewie@arcor.de)
	by mail-in-12.arcor-online.net (Postfix) with ESMTPA id D4009266AE
	for <git@vger.kernel.org>; Wed,  2 May 2012 16:09:40 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net D4009266AE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196823>

forward from http://code.google.com/p/git-core/issues/detail?id=11
and https://bugs.launchpad.net/bugs/853081


Hello,

not sure you guys pay much attention to the issue tracker over on 
code.google.com so I'll try my luck here.

Current bash completion works the following way.

1) only tag-completion possible: complete tag as much as possible
2) only file/dir-completion possible: complete path as much as possible
3) all of tag/file/dir-completion possible: complete tag (!) as much as 
possible

1 and 2 are fine, but for #3 git should really stop at the lowest common 
denominator for all of tags, files and directories. This is explained 
better in above tickets, but I'll also include an example here for 
illustration.  Let's say I had tags debian/1.4.9-1 and debian/1.4.9-2 as 
well as debian/changelog file (as is common when using git-buildpackage, 
this is a real life example).  Current bash-completion behavior for "git 
log debiTAB" is to complete to "git log debian/1.4.9-" when it really 
should be "git log debian/".

Thank you for your attention.

Regards

Rolf
