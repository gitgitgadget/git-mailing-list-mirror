From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] Make git_get_refs_list do work of git_get_references
Date: Tue, 19 Sep 2006 14:30:51 +0200
Message-ID: <200609191430.51252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 19 14:32:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPemR-0003P0-1E
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 14:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWISMcq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 08:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWISMcq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 08:32:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:1687 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030216AbWISMcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 08:32:45 -0400
Received: by nf-out-0910.google.com with SMTP id o25so136668nfa
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 05:32:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T6jQdiqBEDKRnuEPXAiPDBAYGXj/8lzX3LENxyTQ08jLTu/JLJpeM2vNthb+HY6B73vTbllABdUanzmfSx+cbzN5I7NzfBoLxTXWcQhaVMibGYQUNmU6FwmQLMxMZOlDOJVOliTlHlHa6EyE0pk/C300/5zh09UeLvYrLLgEPy8=
Received: by 10.78.157.8 with SMTP id f8mr3795362hue;
        Tue, 19 Sep 2006 05:32:43 -0700 (PDT)
Received: from host-81-190-25-93.torun.mm.pl ( [81.190.25.93])
        by mx.gmail.com with ESMTP id 3sm10953092hud.2006.09.19.05.32.42;
        Tue, 19 Sep 2006 05:32:43 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27273>

This is resend of short series of patches. Second patch in series
was corrected twice ([PATCH 2/2 (take 2)] and [PATCH 2/2 (take 3)]),
but neither of corrections made to git mailing list.

Shortlog:
 [PATCH 1/2] gitweb: Always use git-peek-remote in git_get_references
 [PATCH 2/2] gitweb: Make git_get_refs_list do work of git_get_references

Diffstat:
 gitweb/gitweb.perl |   76 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 44 insertions(+), 32 deletions(-)
-- 
Jakub Narebski
Poland
