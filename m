From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Tue, 27 Apr 2010 13:57:08 +0000
Message-ID: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 15:58:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lIm-0002JD-M4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 15:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab0D0N6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:58:06 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:54347 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab0D0N6E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:58:04 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id D6B925CD9
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:19:09 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com D6B925CD9
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 0FB19ACB;
	Tue, 27 Apr 2010 13:58:02 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id E883111D4D1; Tue, 27 Apr 2010 13:58:01 +0000 (UTC)
User-Agent: quilt/0.46-1
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145903>

Here are the portability patches we needed at TWW to enable git-1.7.1
to compile and run on all of the wide range of Unix machines we
support.  These patches apply to the git-1.7.1 release,  and address
all of the feedback from the previous three times I posted them to
this list, including fixing the massive testsuite failures I was
experiencing and taking into account that the ss_family fixes and
partial GMT_CMP_TEST fixes that have been pushed since my last post of
this patch queue.

With the exception of a hand-full of test failures outside of Linux 
and Solaris8+, git now compiles and passes all tests on the following
architectures:

        Solaris 2.6/SPARC
        Solaris 7/SPARC
        Solaris 8/SPARC  
        Solaris 9/SPARC
        Solaris 10/SPARC         
        Solaris 10/Intel         
        HP-UX 10.20/PA
        HP-UX 11.00/PA 
        HP-UX 11.11/PA   
        HP-UX 11.23/PA   
        HP-UX 11.23/IA
        HP-UX 11.31/PA
        HP-UX 11.31/IA   
        AIX 5.1  
        AIX 5.2
        AIX 5.3  
        AIX 6.1  
        Tru64 UNIX 5.1   
        IRIX 6.5         
        RHEL 3/x86       
        RHEL 3/amd64     
        RHEL 4/x86 
        RHEL 4/amd64     
        RHEL 5/x86       
        RHEL 5/amd64     
        SLES 10/x86      
        SLES 10/amd64    

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
