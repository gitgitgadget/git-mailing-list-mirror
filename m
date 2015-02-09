From: erik@aercon.net
Subject: Windows Bluescreen
Date: Mon, 09 Feb 2015 20:12:18 +0000
Message-ID: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:41:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKv8o-0005bt-EH
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760959AbbBIUlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:41:05 -0500
Received: from aercontechnologies.net ([162.243.220.235]:54133 "EHLO
	server.aercontechnologies.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760926AbbBIUlE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 15:41:04 -0500
X-Greylist: delayed 1723 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2015 15:41:04 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aercon.net; s=default;
	h=MIME-Version:Content-Type:Subject:To:From:Message-ID:Date; bh=vs6dGcjPilI7ZAy0E+1lA32TjmNeyEB4MC+d/bmc9ME=;
	b=QLebDPHf/Nvk8FXmOAUciUbGJhmN3frQWI1jrRZRC+AriQVO4TTzWFe/g35TtKMZ5P0xd3WDBf9iEt2eZ+NC3HaYiqcBcwX20VffgCPZUCc5iWdHxwu0eRMxs93xmDt4Sr/NzlAx7VTCkwDtXa3hixyB+QuImKg1RkrH2Snf+ks=;
Received: from localhost ([::1]:60047 helo=server.aercontechnologies.net)
	by server.aercontechnologies.net with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.84)
	(envelope-from <erik@aercon.net>)
	id 1YKugt-0005t2-9U
	for git@vger.kernel.org; Mon, 09 Feb 2015 15:12:19 -0500
Received: from 69.27.55.4 ([69.27.55.4]) by server.aercontechnologies.net
 (Horde Framework) with HTTP; Mon, 09 Feb 2015 20:12:18 +0000
User-Agent: Internet Messaging Program (IMP) H5 (6.1.4)
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.aercontechnologies.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - aercon.net
X-Get-Message-Sender-Via: server.aercontechnologies.net: authenticated_id: erik@aercon.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263591>


I find that preview 1.8 is bluescreening on about 1 of 3 ssh pushes.   
1.9 preview 12-17-2014 doesn't even bluescreen, the windows gui locks  
until reset.

Sample command:
git push omv master\r

config. =

[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
	hideDotFiles = dotGitOnly
[remote "omv"]
	url = gitpush@192.168.0.100:/git-repos/HexEncrypter
	fetch = +refs/heads/*:refs/remotes/omv/*
