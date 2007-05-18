From: Raimund Bauer <ray007@gmx.net>
Subject: Re: autocrlf
Date: Fri, 18 May 2007 12:34:42 +0200
Message-ID: <1179484482.6453.19.camel@localhost>
References: <200705181111.53823.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 12:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoznQ-000881-RX
	for gcvg-git@gmane.org; Fri, 18 May 2007 12:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbXERKer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 06:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbXERKer
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 06:34:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:35769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755060AbXERKeq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 06:34:46 -0400
Received: (qmail invoked by alias); 18 May 2007 10:34:44 -0000
Received: from p5498ABC0.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.171.192]
  by mail.gmx.net (mp047) with SMTP; 18 May 2007 12:34:44 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1/yxKkv83zyZEMFNKKHa6GqLiYZRVdxWZVHzNPzGK
	d+5lbIpsORo+0A
In-Reply-To: <200705181111.53823.andyparkins@gmail.com>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47590>

On Fri, 2007-05-18 at 11:11 +0100, Andy Parkins wrote:
> Hello,
> 
> I've just been playing with gitattributes and was trying the crlf attribute.  
> The behaviour of this and/or core.autocrlf is not as I was expecting.
> 
> What I had imagined was that I could use .gitattributes to tell git which 
> files in my tree were text.  Then the line endings on checkout would be set 
> as appropriate to my platform, and on check in set to LF.
> 
> What actually happens is that any file with the crlf attribute is being 
> checked out with LF expanded to CRLF (I'm running Linux of course), which is 
> completely not what I wanted.

you need to set core.autoCrlf=input

I had the same problem some time ago ...

> Andy

-- 
best regards

  Ray
