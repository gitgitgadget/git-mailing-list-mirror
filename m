From: Michael Bergin <michaeljbergin@gmail.com>
Subject: Re: Git Option/Subcommand Processing Library?
Date: Sat, 25 Jul 2009 15:51:39 -0400
Message-ID: <D30CE3A7-176D-4132-88A6-23C46A4EA185@gmail.com>
References: <231BD892-07B1-452C-A224-047829E21991@gmail.com> <alpine.DEB.1.00.0907251830420.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 25 21:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUnI8-0005Xa-3A
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 21:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbZGYTvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbZGYTvz
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 15:51:55 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:22554 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbZGYTvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 15:51:55 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1253740qwh.37
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 12:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=Y4P5wEDKFVFDbOpid6RwYXj3B6eWzh/joT+8wsxg8pw=;
        b=hFpq54yBfOZZp5O2Ci5wHu/8Wig5VbyE/wHJUtY8oqpF9ejFVxKRSMD2Jcyg+3xt9A
         9kcEy8MmVQshuAmZfTsIdVMLzMg3P8/V8N8VFF4C6CxzZYb/mW/+dIt8bV6M2n4hPhoZ
         cqlJHNimW5foBiI+pZf1ynBYu9q3HoaPGVbp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=tbUaJ9tVJSdqnhKmE1kGbj7DNGvM9ZmtCgiFXPwcA0yNNIUebePSjilAvoPF3n0H0O
         cvVs1TuWzW9xAPPq94cOMsVNqPo4WRnTKyy7E4WEHvFpiFqWSAnXJdf6cvY7lYPz0+L5
         qT+ig29R8gJbuwha5STnkv2I0/L+sB0MdicyY=
Received: by 10.224.73.193 with SMTP id r1mr4582673qaj.136.1248551514439;
        Sat, 25 Jul 2009 12:51:54 -0700 (PDT)
Received: from ?166.203.39.195? ([166.203.39.195])
        by mx.google.com with ESMTPS id 5sm7347302qwg.55.2009.07.25.12.51.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 12:51:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907251830420.8306@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124062>

Thanks for the pointers.  I also want to create a generic library for  
command facades like git.  For that I will probably use git.c as a  
guide but to make it generic I would need to add/rearrange code.   
GPLv2 works fine for my purposes.  I hope this isn't an offensive  
question or anything but would releasing just the library under LGPL  
be considered?

On Jul 25, 2009, at 12:32 PM, Johannes Schindelin wrote:

> Hi,
>
> On Sat, 25 Jul 2009, Michael Bergin wrote:
>
>> Is there a library containing just the option and subcommand  
>> processing
>> code from git?  I saw a post about gitopt but can't find a project  
>> with
>> that name.
>
> The "library" is contained in the files parse-options.[ch] in  
> git.git.  I
> am unsure if you need strbuf.c, too, or not.
>
>> If not is there any problem with me doing this?
>
> Not if you abide by the license of git.git, which is GPLv2.
>
> Ciao,
> Dscho
>
>
