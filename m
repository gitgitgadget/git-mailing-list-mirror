From: AJ <alljeep@gmail.com>
Subject: Feature Request: gitignore recursion
Date: Sun, 6 Oct 2013 22:23:09 +0000 (UTC)
Message-ID: <loom.20131007T000517-673@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 07 00:25:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSwlF-0005X3-TC
	for gcvg-git-2@plane.gmane.org; Mon, 07 Oct 2013 00:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab3JFWZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 18:25:06 -0400
Received: from plane.gmane.org ([80.91.229.3]:48093 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab3JFWZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 18:25:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VSwl5-0005V3-Hk
	for git@vger.kernel.org; Mon, 07 Oct 2013 00:25:03 +0200
Received: from 63.92.225.169 ([63.92.225.169])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Oct 2013 00:25:03 +0200
Received: from alljeep by 63.92.225.169 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Oct 2013 00:25:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.92.225.169 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.30.1 (KHTML, like Gecko) Version/6.0.5 Safari/536.30.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235753>

I'm hoping to get the following feature implemented into git.

Add the ability to recursively include using:
!/my_dir/**/*

Currently, in order to include a directory with multiple sub-directories
within a excluded directory, you must do the following:
!/my_dir/
!/my_dir/*
!/my_dir/*/*
!/my_dir/*/*/*
!/my_dir/*/*/*/*
!/my_dir/*/*/*/*/*

Here is a use case:
When developing a WordPress site you typically only place the wp-content/themes
directory under version control. Once you start adding custom plugins, README
files, and a task manager like Grunt JS, you then have to starting getting
creative with your .gitignore if your .git directory is in the web root
directory.

Here is an example:
https://gist.github.com/AJ-Acevedo/6859779

Thanks for taking the time to consider this feature
AJ
