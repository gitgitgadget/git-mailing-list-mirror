X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Bash completion Issue?
Date: Sat, 4 Nov 2006 12:36:59 +0000
Message-ID: <200611041236.59989.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 4 Nov 2006 12:37:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30926>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgKm5-0008UN-GL for gcvg-git@gmane.org; Sat, 04 Nov
 2006 13:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965391AbWKDMhV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 07:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965398AbWKDMhV
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 07:37:21 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:12169 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S965391AbWKDMhU (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4
 Nov 2006 07:37:20 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GgKlz-0006D1-Ea for git@vger.kernel.org; Sat, 04 Nov 2006 12:37:19 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I am experiencing (and have for some time) a strange effect with bash 
completion on my Debian (Unstable) system.  Is this a git problem, or 
something else?

When I type a normal command on the bash command line (say emacs) followed by 
the partial directory name the completion completes the directory and then 
adds a slash.  If I type a git command (say git update-index) with the same 
partial directory name it completes the directory, but then adds a space.  I 
have to backspace, manually add the slash, before continuing with the next 
directory or filename.

In debian, there seems to be a directory /etc/bash_completion.d with files for 
each of the packages, and the debian git packages have entries in there.  So 
I assume they are derived from the completion work mentioned on this list.

What seems strange to me is that nobody else has mentioned this before now.

-- 
Alan Chandler
