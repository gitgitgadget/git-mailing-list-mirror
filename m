From: David Tonhofer <d.tonhofer@m-plify.com>
Subject: Add a note in the on-line Git book about installing the man pages?
Date: Tue, 02 Apr 2013 18:53:20 +0200
Message-ID: <515B0D00.6020506@m-plify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 19:13:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4lz-0005nS-2h
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871Ab3DBRM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:12:58 -0400
Received: from smtp.m-plify.net ([80.90.63.48]:44340 "EHLO smtp.m-plify.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932851Ab3DBRM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:12:57 -0400
X-Greylist: delayed 1175 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2013 13:12:57 EDT
Received: from freya.m-plify.lan (localhost [127.0.0.1])
	by smtp.m-plify.net (Postfix) with ESMTP id 06AA61485E
	for <git@vger.kernel.org>; Tue,  2 Apr 2013 18:53:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219805>

Hi,

It seems the git man pages (or HTML pages) are not installed by default 
when you install git as described in the http://git-scm.com/book

I propose to add a note to 
http://git-scm.com/book/en/Getting-Started-Installing-Git along those lines:




Getting the git manpages from 
"https://code.google.com/p/git-core/downloads/list" and unpack them 
(supposing you installed your git into "/opt/git"):

TARGET=/opt/git
VERSION=`$TARGET/bin/git --version | awk '{print $3}' | cut -d '.' -f1-3`
wget "http://git-core.googlecode.com/files/git-manpages-${VERSION}.tar.gz"
mkdir "$TARGET/share/man"
tar xz -C "$TARGET/share/man" -f "git-manpages-${VERSION}.tar.gz"
