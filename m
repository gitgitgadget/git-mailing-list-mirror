From: jateeq <jawad_atiq@hotmail.com>
Subject: Git status shows modifications after cloning
Date: Mon, 8 Mar 2010 07:32:25 -0800 (PST)
Message-ID: <27821819.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 08 16:32:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Noewc-0000tk-44
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 16:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab0CHPc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 10:32:28 -0500
Received: from kuber.nabble.com ([216.139.236.158]:47954 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0CHPc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 10:32:27 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NoewT-0002eS-Ic
	for git@vger.kernel.org; Mon, 08 Mar 2010 07:32:25 -0800
X-Nabble-From: jawad_atiq@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141769>


Hello,

After cloning from a local repository, a git status shows me that each file
in the repository has been modified - I don't want this to happen. I have
searched around the net, and there is stuff about this happening if the
configurations for the original and the clone are not the same, with
specific mention of the variable core.autocrlf. However, this variable is
unspecified in both repositories, and the differences in config files is
listed below.

Origin:
[core]
	repositoryformatversion = 0
	filemode = true
	bare = true

Clone:
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = /home/ruggeddoc/Documents/Primary/InstallationGuides/RuggedBackbone
[branch "master"]
	remote = origin
	merge = refs/heads/master
[branch "jateeq.2010-03-08.09-49"]
	remote = origin
	merge = refs/heads/master

I haven't tried unsetting the logallrefupdates (I want to log updates). Does
anyone think this is a config file issue? If it is, any idead on how to
solve it? If not, what can I do so that git status, or git diff do not show
modified files right after cloning?

NOTE: On the origin, the only branch that exists is master, whereas after
I'm done cloning, I create another branch and then checkout that branch's
head right from the start. 

Thank you for your help, 
Jawad
-- 
View this message in context: http://old.nabble.com/Git-status-shows-modifications-after-cloning-tp27821819p27821819.html
Sent from the git mailing list archive at Nabble.com.
