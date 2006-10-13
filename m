From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Fri, 13 Oct 2006 16:05:56 +0200
Organization: Dewire
Message-ID: <200610131605.56913.robin.rosenberg.lists@dewire.com>
References: <20061011172553.GA1147@linux-mips.org> <200610120745.00909.robin.rosenberg.lists@dewire.com> <200610122321.18630.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 16:55:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYOQx-0000us-2c
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 16:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWJMOyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 10:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWJMOyo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 10:54:44 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27183 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751087AbWJMOyn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 10:54:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id AF9CB8028AB;
	Fri, 13 Oct 2006 16:51:40 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10735-08; Fri, 13 Oct 2006 16:51:40 +0200 (CEST)
Received: from [10.9.0.9] (unknown [10.9.0.9])
	by torino.dewire.com (Postfix) with ESMTP id 5D165802677;
	Fri, 13 Oct 2006 16:51:38 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.4
In-Reply-To: <200610122321.18630.jnareb@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28850>

torsdag 12 oktober 2006 23:21 skrev Jakub Narebski:
> Robin Rosenberg wrote:
> > onsdag 11 oktober 2006 23:27 skrev Jakub Narebski:
> > > Pazu wrote:
> > > > The XML declaration forces IE6 into quirks mode, breaking our
> > > > nice standards compliant stylesheet.
> > >
> > > But isn't it _required_ by XML/XHTML?
> >
> > For pure XML document it is required, but not for XHTML, unless the
> > encoding is something other than UTF-8 or (shudder) UTF-16. W3C
> > recommends it though.
>
> So what should be our decision? Honor IE quirks ;-) and either remove
> XML declaration, or use Transitional DTD? Add back SPC to &nbsp; conversion
> in esc_html? Ignore broken browsers?

It isn't required by the standard. Why not just drop it?

-- robin
