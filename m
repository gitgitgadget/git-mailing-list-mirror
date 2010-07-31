From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: On MacOS, 1.7.2, git svn clone seems to fail silently
Date: Fri, 30 Jul 2010 20:13:32 -0500
Message-ID: <20100731011332.GE5817@burratino>
References: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benson Margulies <bimargulies@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 03:14:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of0f7-0000U6-TX
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab0GaBOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 21:14:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56478 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab0GaBOs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:14:48 -0400
Received: by ywh1 with SMTP id 1so820375ywh.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ppv09ZVa5htg8iUnD4FcPn3cpD0/6nuvSEBeC/IfUIY=;
        b=HaoLL6iAgt08Wq64zFY6fPKmQgF7LM6pDC7tjQ1hfLCdk6SSQSOFtyMXxaD3bd5qle
         /e5YmH/+ewviIdqrH4rbpWjSp7gtKo4/UIq2XF/pn4VOosGDdO7S6vBZCBGP5SRUdkL/
         ngEkTDv3gL0UYBBEJKNuASNgSZBgbWkl8oLso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SQakfePAdVKcGmtPR7ObXGzDsDp8Bbbq0MCQsCdbl7FVw7zTJ9rzQUBVStcP2ER7DD
         bGbFjM+hSyLVnWrFutls9hiM7CAwHZCXupcF3F95oBrtiU/PLnCjFXlRvHe/n3WBKP2R
         qXnVy96LgKErdsSTJ0eaVQbPluxDa9Bq7lk30=
Received: by 10.151.132.7 with SMTP id j7mr4235870ybn.39.1280538888095;
        Fri, 30 Jul 2010 18:14:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v32sm1463306yba.18.2010.07.30.18.14.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 18:14:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152281>

Hi Benson,

Benson Margulies wrote:
> git svn clone -s https://gate.svn.sourceforge.net/svnroot/gate
[...]
> No errors, no messages. No branches, no contents. Just the
> wind whistling through the bytes.

Heh - you might be the one to figure out
http://thread.gmane.org/gmane.comp.version-control.git/134936

But first, it would be good to confirm:

 - if you run "echo $?" right after such a failure, what
   status code do you get?

 - what is the output of "git branch -r" when you finish?

Coping strategy: usually with "git svn clone" failures, you can resume
where you left off with "git svn fetch".

Good luck,
Jonathan
