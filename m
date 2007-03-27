From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Makefile: remove test-chmtime program in target clean.
Date: Tue, 27 Mar 2007 11:46:38 +0200
Organization: eudaptics software gmbh
Message-ID: <4608E7FE.86CD5F31@eudaptics.com>
References: <20070327093843.14074.qmail@7a32cdb4370c3b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 12:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8m3-0004Rq-5t
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbXC0KS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753757AbXC0KS6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:18:58 -0400
Received: from main.gmane.org ([80.91.229.2]:41599 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753AbXC0KS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:18:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HW8Qq-0001uV-2l
	for git@vger.kernel.org; Tue, 27 Mar 2007 11:57:36 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 11:57:36 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 11:57:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43246>

Gerrit Pape wrote:
> 
> While running 'make test', the test-chmtime program is created, and should
> be cleaned up on 'make clean'.
>[...]
>  clean:
>         rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
> -               $(LIB_FILE) $(XDIFF_LIB)
> +               test-chmtime $(LIB_FILE) $(XDIFF_LIB)

test-chmtime$X you mean, right?

-- Hannes
