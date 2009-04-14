From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: git init permissions?
Date: Tue, 14 Apr 2009 20:09:50 +0200
Message-ID: <49E4D16E.9050500@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 20:11:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltn6d-0004FT-Gi
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 20:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303AbZDNSJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 14:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757501AbZDNSJy
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 14:09:54 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:36721 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757379AbZDNSJx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 14:09:53 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 85B8958BDA0
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 20:09:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116549>

Hi list,

Maybe a silly question but I couldn't figure out the answer.

I'm looking at the git init --shared=group result and see:

drwxrwsr-x 7 ferry ferry  111 2009-04-14 19:51 .
drwxrwxr-x 3 ferry ferry   17 2009-04-14 19:51 ..
drwxrwxr-x 2 ferry ferry    6 2009-04-14 19:51 branches
-rw-rw-r-- 1 ferry ferry  127 2009-04-14 19:51 config
-rw-rw-r-- 1 ferry ferry   58 2009-04-14 19:51 description
-rw-rw-r-- 1 ferry ferry   23 2009-04-14 19:51 HEAD
drwxrwxr-x 2 ferry ferry 4.0K 2009-04-14 19:51 hooks
drwxrwxr-x 2 ferry ferry   20 2009-04-14 19:51 info
drwxrwsr-x 4 ferry ferry   28 2009-04-14 19:51 objects
drwxrwsr-x 4 ferry ferry   29 2009-04-14 19:51 refs

Is there some kind of reason that the branches directory is
not created with +s permissions?

I can understand it for the hooks and info directories since
you can not push into those. You _can_ however push into
branches and I would expect it to have +s too, like objects
and refs.

Bug or my misunderstanding?

git version 1.6.0.6
