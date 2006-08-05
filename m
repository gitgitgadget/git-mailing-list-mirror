From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/4] gitweb: blame table row no highlight fix
Date: Fri, 4 Aug 2006 17:51:48 -0700 (PDT)
Message-ID: <20060805005148.12923.qmail@web31807.mail.mud.yahoo.com>
References: <7v4pwshx3h.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 02:51:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9AOO-0004RG-QE
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 02:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWHEAvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 20:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWHEAvt
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 20:51:49 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:21689 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422677AbWHEAvt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 20:51:49 -0400
Received: (qmail 12925 invoked by uid 60001); 5 Aug 2006 00:51:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WyLBTdBShdyt4BLpH+6eRGUmDKzMmShjYGbpxMCp7wLX0ky3EzfwTj+tPzmgA8pUqORwjvZe6v/KqGYB9VXGX+GpOnIa2ZLZ7N8+cQV+g7BUOq8A0pAT25fbFV4NITeRIAQkE3Vp6h8ixN+2U8KuS1R5IV3VZ36+5WRp5VCj4rU=  ;
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Fri, 04 Aug 2006 17:51:48 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pwshx3h.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24871>

--- Junio C Hamano <junkio@cox.net> wrote:
> I do not see "tr.light" but "tr.light:hover" in the original
> CSS.  That is kind of understandable (unhovered light ones just
> use default), but this patch completely lost me.  You use light2
> class but nothing affects that class in the CSS.

Yes, it is the default, just as there is no "tr.light", there is
no "tr.light2".

> Maybe it is the commit log message that is misleading?  I guess
> what you are trying to achieve is to disable the color change
> that follows the pointer?

Yes, indeed.  It is very annoying.

   Luben
