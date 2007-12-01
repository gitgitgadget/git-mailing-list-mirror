From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Try harder in parse_tag; perhaps it was given ambiguous name
Date: Sat, 1 Dec 2007 04:06:42 +0100
Message-ID: <200712010406.44203.jnareb@gmail.com>
References: <200712010245.29204.jnareb@gmail.com> <200712010247.25107.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 04:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIhH-0001VD-FB
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 04:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752AbXLADGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 22:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758551AbXLADGz
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 22:06:55 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:19919 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558AbXLADGy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 22:06:54 -0500
Received: by mu-out-0910.google.com with SMTP id i10so469439mue
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 19:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=gwW20poYpXjYJc/cnTBI/lchUcEcJKVy/DBKlWJZ2uE=;
        b=fRq193lRrLow9xrHLr+oDs0KBOZ999tCv5ID1CsGg+puNyn2uoN55FTpfISEHgEbQWmzADw8hmu5eWMnuF24OSiWc1LvJRt/tY4yh6Z2lqURE9oXJYEHqEdKYvXZcjCebFlPghnIlMyyosvHt4IXqDXyH5KvZGCk6JhHxtOHBHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Qp59VKqKXZj7UllwzdZvFfDArmSy7XnQhioqFoJUnWuJczZJqshDd+ocC2n0Du8MM9S+7JCf6mWWOrtzG/pEETtZMxpbEY+cWzgzYLLaSiqvoHHGJn2cbx7O22e8Nf5AOt+Yw6EqKop829BeRbVGnqmKeJtPbc+9g+DFn4kG3Jw=
Received: by 10.86.72.15 with SMTP id u15mr3034814fga.1196478412528;
        Fri, 30 Nov 2007 19:06:52 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.40])
        by mx.google.com with ESMTPS id e11sm4491599fga.2007.11.30.19.06.50
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Nov 2007 19:06:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712010247.25107.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66693>

This patch should be RFC.
Sorry for missing that. 

-- 
Jakub Narebski
Poland
