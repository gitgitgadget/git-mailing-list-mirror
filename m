From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Gitweb indentation wrong in Internet Explorer
Date: Wed, 11 Oct 2006 19:15:26 +0100
Message-ID: <20061011181526.GA13892@linux-mips.org>
References: <20061011172553.GA1147@linux-mips.org> <egjang$nmh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 20:15:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXibz-0007ES-AB
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWJKSPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWJKSPT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:15:19 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:31703 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1161105AbWJKSPS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 14:15:18 -0400
Received: from localhost.localdomain ([127.0.0.1]:51608 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037784AbWJKSPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 19:15:16 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9BIFR5S014003;
	Wed, 11 Oct 2006 19:15:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9BIFQSh014002;
	Wed, 11 Oct 2006 19:15:26 +0100
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <egjang$nmh$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28735>

On Wed, Oct 11, 2006 at 07:47:24PM +0200, Jakub Narebski wrote:

> >> When I use it (and I believe I've seen this on my laptop as well as my
> >> workstation) all left-hand margin whitespace is collapsed to nothingness.
> >> Once can still parse the code, but it's harder with no indentations.
> > 
> > A screenshot from a Windows laptop to illustrate the problem is at
> > http://www.linux-mips.org/~ralf/gitweb.png.  It shows the code was
> > preformatted correctly which seems to be an IE bug but the following patch
> > seems to work around it.
> 
> Which version of gitweb? We have removed s/ /&nbsp;/g; in esc_html
> subroutine in favor of using "white-space: pre;" in CSS some time ago,
> and we have added escaping FORM FEED and ESCAPE characters.

Anything since since at least June 19 seems affected, including yesterday's
version.

> Could you send git patches, by the way? Or at least '-p' diffs?

Nope.  I'm just forwarding this.

  Ralf
