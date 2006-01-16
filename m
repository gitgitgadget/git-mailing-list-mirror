From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb on kernel.org broken
Date: Mon, 16 Jan 2006 20:05:56 +0100
Message-ID: <20060116190556.GA14184@vrfy.org>
References: <43CBE993.9060701@zytor.com> <20060116185342.GA14088@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 16 20:07:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyZgB-0001FH-Fs
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 20:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWAPTGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 14:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWAPTGH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 14:06:07 -0500
Received: from soundwarez.org ([217.160.171.123]:41625 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751160AbWAPTGH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 14:06:07 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id EF6F77C0DB; Mon, 16 Jan 2006 20:05:56 +0100 (CET)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <20060116185342.GA14088@vrfy.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14753>

On Mon, Jan 16, 2006 at 07:53:42PM +0100, Kay Sievers wrote:
> On Mon, Jan 16, 2006 at 10:44:35AM -0800, H. Peter Anvin wrote:
> > It seems that gitweb throws an error every time.  This means that 
> > nothing gets cached, and therefore the load on the kernel.org machines 
> > is driven into the high double digits:
> > 
> > [Mon Jan 16 10:42:01 2006] [error] [client 82.181.110.11] [Mon Jan 16 
> > 10:42:01 2006] index.cgi: Use of uninitialized value in scalar 
> > assignment at /home/httpd/html/git/index.cgi line 411.
> > [Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] fatal: Not a 
> > git repository: '/pub/scm/linux/hotplug/hotplug-ng.git'
> > [Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] [Mon Jan 16 
> > 10:42:03 2006] index.cgi: Use of uninitialized value in scalar chomp at 
> > /home/httpd/html/git/index.cgi line 406.
> > [Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] [Mon Jan 16 
> > 10:42:03 2006] index.cgi: Use of uninitialized value in pattern match 
> > (m//) at /home/httpd/html/git/index.cgi line 407.
> > 
> > This is all very bad...
> 
> Junio, seems your "textual symref HEAD" change is causing this?
>   http://www.kernel.org/git/?p=git/gitweb.git;a=blob;hb=HEAD;f=gitweb.cgi#l399

I've comment "strict" and "warnings" out, until it's fixed proper.

Kay
