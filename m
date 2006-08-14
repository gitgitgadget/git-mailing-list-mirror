From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/9] gitweb: Great subroutine renaming + task separation into subroutines + improvements
Date: Mon, 14 Aug 2006 02:02:45 +0200
Message-ID: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:16:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZUs-0001pc-8P
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbWHNKQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbWHNKQf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:24460 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751964AbWHNKQf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:35 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20978nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KQcr3OGPUk8xF+5LW2rtT0Q1iFl8UPgcUYkQG7GJaDJFei/fZlv5BxGMogVaQ80xAGguPK0Yu2a4K6/aYWbDukLJt47P/qQXroCup424YZ4teponBKY7y8eCderZKkAq/cqiCl2hcDPUtSJBfxqDfD9wYFPjAGohBgDLuSj1KvQ=
Received: by 10.48.254.10 with SMTP id b10mr1006105nfi;
        Mon, 14 Aug 2006 03:16:33 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.32;
        Mon, 14 Aug 2006 03:16:33 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25336>

This series of patches is based on the 'next' branch, commit
10a6653c818f78c6032d45e1d4da544085e1f28b (v1.4.2-g10a6653)

It begins with:
* [PATCH 1/9] gitweb: Great subroutines renaming

Then there is series of patches which separate task into subroutine; 
'refactor' in patch subject here means that we use new subroutine in 
more than one place, 'separate' here means that new subroutine is (for 
now) used only in one place
* [PATCH 2/9] gitweb: Separate ref parsing in git_get_refs_list 
  into parse_ref
* [PATCH 3/9] gitweb: Refactor printing shortened title 
  in git_shortlog_body and git_tags_body
* [PATCH 4/9] gitweb: Separate main part of git_history 
  into git_history_body
* [PATCH 5/9] gitweb: Separate finding project owner 
  into git_get_project_owner

Then there is couple of improvements
* [PATCH 6/9] gitweb: Change appereance of marker of refs pointing 
  to given object
* [PATCH 7/9] gitweb: Skip comments in mime.types like file
* [PATCH 8/9] gitweb: True fix: Support for the standard mime.types map
  in gitweb

And finally yet another separation of task into subroutine, with small 
improvements (and perhaps to be reused)
* [PATCH 9/9] gitweb: Separate printing difftree in git_commit into
  git_difftree_body


-- 
Jakub Narebski
Poland
