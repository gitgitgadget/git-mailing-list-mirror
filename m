From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 14:32:22 +0000
Message-ID: <200701231432.24225.andyparkins@gmail.com>
References: <200701231259.27719.andyparkins@gmail.com> <ep51ie$i23$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 23 15:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9MiX-0004aK-Gt
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 15:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbXAWOdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 09:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933009AbXAWOdh
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 09:33:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:40403 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933004AbXAWOdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 09:33:36 -0500
Received: by nf-out-0910.google.com with SMTP id o25so256926nfa
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 06:33:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ArP5ZEDaFACRilrQPjqajSyQ1JFyM8fI2Qr2qMU+vWsalHCNc3NzKUxqJ7GTAeJMYpCk+Q6mMmFmOdMUnrFkhVeqzveLBJrtuR/bp6fTcT817UZ27wCRZC0VXM3snQkQ9UusDYJxf+TS8smmZ2lejSbr7rmqSDnwqrv5cKJmGHI=
Received: by 10.48.230.5 with SMTP id c5mr1112127nfh.1169562814928;
        Tue, 23 Jan 2007 06:33:34 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id k9sm2759252nfc.2007.01.23.06.32.26;
        Tue, 23 Jan 2007 06:33:30 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <ep51ie$i23$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37526>

On Tuesday 2007 January 23 13:12, Jakub Narebski wrote:

> The problem is when you delete branch 'foo', and then create branch
> 'foo/bar'. You can't have both 'foo' and 'foo/bar' reflog.

Ah; yes of course.  That is a bit of a deal breaker isn't it?

On the other hand, why delete it instantly?  Since the reflog is currently 
deleted by git-branch anyway, couldn't the deletion be delayed until the 
creation of foo/bar?  At least then the deletion only hits if it really has 
to.  In most circumstances foo then foo/bar is fairly unlikely.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
