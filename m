From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: Test fails on ubuntu breezy
Date: Sat, 15 Apr 2006 13:03:00 +0530
Message-ID: <cc723f590604150033t53fa1af5wa10f93a059f4a9ce@mail.gmail.com>
References: <20060413115447.11819.qmail@science.horizon.com>
	 <7vpsjl1ezb.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590604142347p7646aa40r52506a0d85b7d817@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux@horizon.com, "Peter Eriksen" <s022018@student.dtu.dk>,
	git@vger.kernel.org, "Carl Worth" <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 09:33:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUfHG-0001O0-FM
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 09:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWDOHdC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 03:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWDOHdB
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 03:33:01 -0400
Received: from wproxy.gmail.com ([64.233.184.224]:52410 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751566AbWDOHdB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 03:33:01 -0400
Received: by wproxy.gmail.com with SMTP id i11so358765wra
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 00:33:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fsIWsRv2+GXZX+Ii3OATYtR5VuXIB1bQ5+jAV7YorHXOuYarCuqYfLFnwopiL8tZfGlzeY7CKvoPmyF9ChRUz7fDU6FgevNQyNpTZkFdtfSadud3/r/AlwDIqbeDHAn/YJs6xSNJOUZQNGMGzrgI3Zm+lotgCFWDqh5/OahBhTg=
Received: by 10.64.3.9 with SMTP id 9mr163347qbc;
        Sat, 15 Apr 2006 00:33:00 -0700 (PDT)
Received: by 10.64.114.4 with HTTP; Sat, 15 Apr 2006 00:33:00 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <cc723f590604142347p7646aa40r52506a0d85b7d817@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18730>

On 4/15/06, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> I am still having failure with the top of the tree. I guess it is
> because git rm exit with status 0.
>
> kvaneesh@home:/tmp/test$ git rm -f a
> rm: cannot remove `a': Permission denied
> kvaneesh@home:/tmp/test$ echo $?
> 0
>


I think it is xargs
kvaneesh@home:/tmp/test$ echo a | xargs rm
rm: cannot remove `a': Permission denied
kvaneesh@home:/tmp/test$ echo $?
0
kvaneesh@home:/tmp/test$

on ubuntu Dapper it returns 123 status.   I will file a bug report
against xargs.

-aneesh
