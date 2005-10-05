From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Confused as to the correct syntax
Date: Thu, 6 Oct 2005 00:33:50 +0100
Message-ID: <200510060033.51010.alan@chandlerfamily.org.uk>
References: <200510052350.07217.alan@chandlerfamily.org.uk> <7v7jcrh7wu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 06 01:34:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENIll-0003Ee-Rv
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 01:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbVJEXdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 19:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVJEXdv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 19:33:51 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:46497
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1030437AbVJEXdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 19:33:50 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1ENIli-0000ia-8R
	for git@vger.kernel.org; Thu, 06 Oct 2005 00:33:50 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7v7jcrh7wu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9747>

On Thursday 06 Oct 2005 00:16, Junio C Hamano wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:
> > "A  suffix  ~<n>  to  a  revision parameter means the commit object that
> > is the <n>th generation grand-parent of the named commit object,
> > following only the first parent. I.e. rev~3 is equivalent to rev^ which
> > is equivalent to rev11^1."
> >
> > Why is rev~3 equivalent to rev^,  surely it is equivalent to rev^^^
> >
> > Why is rev~3 equivalent to rev11^1, should that not be rev^1^1^1
>
> Sorry, for not knowing how to do that properly in Asciidoc ;-).
>
> The source to the man page and HTML page reads like this:
>
> * A suffix '~<n>' to a revision parameter means the commit
>   object that is the <n>th generation grand-parent of the named
>   commit object, following only the first parent.  I.e. rev~3 is
>   equivalent to rev^^^ which is equivalent to rev^1^1^1.

No the HTML page is screwed up too.


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
