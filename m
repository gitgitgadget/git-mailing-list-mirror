From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 8
Date: Thu, 24 Jun 2010 19:42:40 -0500
Message-ID: <20100625004240.GB4762@burratino>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
 <AANLkTik1fV1yYZL5mKbVfGKOao7VjzMsg2D_7FkL8nR2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 02:43:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORx0V-0007yy-6j
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 02:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734Ab0FYAmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 20:42:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51366 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab0FYAmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 20:42:51 -0400
Received: by iwn41 with SMTP id 41so1404520iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GwG5SET/1L1jteCAtDqTq8B4dwNgcqEO44BJJrgit0k=;
        b=tlYU8SY94q4hkvo2K1AeHVVgmjJa/TFejbH28p+ZU3o8OXhKkhaUfS8SwE0W+jShjO
         Ijx2ACDcGtZwNDkV8Y8BVFH4CaJWkIjQ8DN9piws8HrDOSTeD+I6T4c7SZavhLzcU42H
         IGP9ge7c6KBtM3UDdRT9/xuBMmvEE9aQJEw6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xBI3qKhUOPlaqHo18NDctarPgaqxlsIzUq0vRPIUET7W5Ojyzgfag6HeSNUCqGos/S
         g1lBHoabn6TNXLki4U2O9BjK3vFByMnnYKrf31D5WgKVMMM9px2uvtdDNDR6sor0kfet
         lVoEfiSlbJhA0vAyrjDEyB9aqCQ6Lduvu40cQ=
Received: by 10.231.193.209 with SMTP id dv17mr10747971ibb.134.1277426570903;
        Thu, 24 Jun 2010 17:42:50 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm35814571ibi.11.2010.06.24.17.42.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 17:42:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik1fV1yYZL5mKbVfGKOao7VjzMsg2D_7FkL8nR2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149660>

Ramkumar Ramachandra wrote:

> shall I
> also include one patch that imports dump.c from the Subversion trunk
> directly and another to strip off the unnecessary parts, clean up
> whitespace and style?

This is just my preference, but I would prefer your cleaned up version
(with a link to the pristine version in trunk I can diff against, of
course).

Jonathan
