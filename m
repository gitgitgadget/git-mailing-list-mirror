From: Kevin Sheedy <kevinsheedy@gmail.com>
Subject: Re: Git unpack-objects on Windows
Date: Thu, 13 Jan 2011 05:54:41 -0800 (PST)
Message-ID: <1294926881696-5918228.post@n2.nabble.com>
References: <1294916875939-5917819.post@n2.nabble.com> <4D2EF04B.20108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 13 14:54:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdNdY-00074P-En
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 14:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815Ab1AMNyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 08:54:43 -0500
Received: from sam.nabble.com ([216.139.236.26]:34196 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab1AMNym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 08:54:42 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <kevinsheedy@gmail.com>)
	id 1PdNdR-0003vA-Mf
	for git@vger.kernel.org; Thu, 13 Jan 2011 05:54:41 -0800
In-Reply-To: <4D2EF04B.20108@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165052>


Ah, ok. I guess unpacking isn't what I need to do. I'm quite new to git and
don't really understand the internals yet. Anyway, cvs2git produced 2 .dat
files that I'm trying to import into a git repository using the following
commands:

git init
cat cvs2svn-tmp/git-blob.dat cvs2svn-tmp/git-dump.dat | git fast-import

I'm following the instructions from here:
http://cvs2svn.tigris.org/cvs2git.html

It looks like the objects have been added to the repository but that no
branches have been created.

Any idea how to create a branch and add the 66000 objects to it?
-- 
View this message in context: http://git.661346.n2.nabble.com/Git-unpack-objects-on-Windows-tp5917819p5918228.html
Sent from the git mailing list archive at Nabble.com.
