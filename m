From: Marc Liyanage <marc@entropy.ch>
Subject: Unable to checkout a particular SVN revision
Date: Fri, 27 Nov 2009 18:05:11 -0800
Message-ID: <718EEBA2-FA4B-402D-B2FC-A8F14D79F6FF@entropy.ch>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 03:05:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NECgs-0003ZP-Ie
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 03:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbZK1CFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 21:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbZK1CFO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 21:05:14 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:59055 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbZK1CFO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 21:05:14 -0500
Received: by gxk4 with SMTP id 4so367447gxk.8
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 18:05:20 -0800 (PST)
Received: by 10.151.95.3 with SMTP id x3mr2843159ybl.6.1259373920180;
        Fri, 27 Nov 2009 18:05:20 -0800 (PST)
Received: from ?192.168.19.81? (adsl-69-107-85-176.dsl.pltn13.pacbell.net [69.107.85.176])
        by mx.google.com with ESMTPS id 21sm806752ywh.31.2009.11.27.18.05.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 18:05:19 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133944>


I'm trying to clone a specific SVN revision with git-svn:

    git svn clone -r 12345 https://host/svn/foo/branches/bar xyz

but it doesn't check out any files, I see just this:

    Initialized empty Git repository in /Users/liyanage/Desktop/xyz/.git

If I try the same thing with SVN like this:

    svn co -r 12345 https://host/svn/foo/branches/bar xyz
    
then I get what I expect, it checks out all the files and "svn info" gives me this revision.


I think it's because this particular revision wasn't committed on this branch, i.e. it doesn't show up in "svn log". If I try a revision that is listed in the log, it works as expected.


Is there a way to make this work?
    
