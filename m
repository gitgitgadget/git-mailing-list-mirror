From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Add title attribute with unshortened value
 for table cells
Date: Tue, 20 Jun 2006 12:46:06 +0300
Message-ID: <20060620124606.4e3e226c.tihirvon@gmail.com>
References: <200606201012.31684.jnareb@gmail.com>
	<7vd5d4chmg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 11:46:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FscoJ-0007BY-S5
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 11:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWFTJqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 05:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFTJqN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 05:46:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:33880 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932537AbWFTJqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 05:46:11 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1377678nfa
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 02:46:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=d2uHVDCe2XPxcQ9kLLm6DHT26A99DMccpBgD6awSCzRNkvvBta7dftYsS23wp8syIevTowo/XJQRA0t82AF4scqsWoiANt3Z0F9BtnhFM+Eh99palaDydThgbgbISJEdDqB8DVtVVW0s7b4w3uNKTXTzrhofPs5Bs2jWJLqadr8=
Received: by 10.48.232.17 with SMTP id e17mr3541456nfh;
        Tue, 20 Jun 2006 02:46:10 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id x27sm6611492nfb.2006.06.20.02.46.08;
        Tue, 20 Jun 2006 02:46:09 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5d4chmg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22186>

Junio C Hamano <junkio@cox.net> wrote:

> I wonder if there is somebody who is willing to run gitweb from
> the "next" branch on some public site, so that I can be
> reasonably confident before breaking one of the most important
> infrastructure of the kernel development?  Volunteers?

I can help.

http://onion.dynserv.net/git/gitweb.cgi

Note: http://onion.dynserv.net/git/ (index.cgi) is an old version.

Global symbol "$path" requires explicit package name at
/var/www/localhost/htdocs/git/gitweb.cgi line 1521.
Execution of /var/www/localhost/htdocs/git/gitweb.cgi aborted due to
compilation errors.

The line is:

$file =~ m#^/# or $file = "$projectroot/$path/$file";

$path seems to be undefined.  I don't understand perl very well so I
can't fix it.

-- 
http://onion.dynserv.net/~timo/
