From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH v2] t3300-*.sh: Fix a TAP parse error
Date: Tue, 24 Jul 2012 14:17:07 -0500
Message-ID: <20120724191707.GA5210@burratino>
References: <500EEDF4.7050007@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stkbo-0001Qr-KY
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab2GXTRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:17:19 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63912 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860Ab2GXTRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:17:16 -0400
Received: by gglu4 with SMTP id u4so7061681ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WudoGbHXJ8eEU/SBRZw6wOypZjn5SIwjSh20uZ49dlM=;
        b=Ile5vlUJi7lrnUV17EIZzBReOovX+DjqUfXMnzOwL5yhHq5IdBbfUcdGRcu4/OYLry
         4s0NTtpXAFC2ZIVA72suqgOUVjTsFDJpS6bC7kTO8b7eoOPY2rihChX3ChdAXNxHTdmT
         Q1nj+biCVyvGO3XARbBWmGax8VBdRKQdd3MUFFICinRtQkk1fK9/+oMywSZqagZZzGbu
         vOJvXBmqKgSxhT6g0ZStmgk+EEO23MzmftcRzcMJamqVMaEAbMQbA1l0sBEG9z3ki6Ed
         1HJwiJp0Pf03tfbOedmGCfMijkNtIbFINnLLydJYoRy+TaH8iL/rc6k+oEr/fks30P5j
         xyIA==
Received: by 10.42.38.200 with SMTP id d8mr12390327ice.19.1343157435756;
        Tue, 24 Jul 2012 12:17:15 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ch4sm2699253igb.2.2012.07.24.12.17.14
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 12:17:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500EEDF4.7050007@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202055>

Hi,

Ramsay Jones wrote:

> Hi Jonathan,
>
> This version of the patch only moves code to determine the test
> prerequisite to the outer level, while leaving the 'setup' aspects
> of the first test in place.

I guess I don't see the point.  The current convention of "don't do
anything complicated outside test assertions" is easy to explain.
What new convention are you suggesting to replace it?

Thanks,
Jonathan
