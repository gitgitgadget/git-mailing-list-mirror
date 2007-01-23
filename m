From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 08:18:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701230817010.32200@woody.linux-foundation.org>
References: <200701221433.13257.andre@masella.no-ip.org> <ep4q5e$ioc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 17:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9OM5-0005Bz-BO
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 17:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933073AbXAWQSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 11:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933089AbXAWQSh
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 11:18:37 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36453 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933073AbXAWQSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 11:18:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0NGIW3U008193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Jan 2007 08:18:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0NGISIM024107;
	Tue, 23 Jan 2007 08:18:31 -0800
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ep4q5e$ioc$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.838 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37544>



On Tue, 23 Jan 2007, Jakub Narebski wrote:
> 
> I wonder if it would be enought for SSH (and perhaps HTTP/WebDAV access)
> just to rely on filesystem write access to refs/heads files (different
> files having different access rights), and filesystem ACLs.

I think the solution is simple: mark the refs/ directory as being sticky.

This is really no different from the /var/spool/mail/ situation: people 
want to change their own files (and create new files), but you can't allow 
people to overwrite other peoples files and filenames.

		Linus
