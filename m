From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Wed, 27 Aug 2014 12:31:29 -0700
Message-ID: <20140827193128.GX20185@google.com>
References: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: dev <dev@cor0.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:31:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMiwT-0002a4-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433AbaH0Tbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:31:34 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55336 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaH0Tbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:31:33 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so1069852pad.10
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2DwhBzwb1wBHfnDYzH31826N1COJvLiEHpa5HYPk6JU=;
        b=MXAebHnphyq69G9haFXm4ldfUQhWPhtvSsUZf3b12p51hPzoWMzuLsAsjHK+QWb/D5
         BXY2lsQA5TrL2FNT2nkmHaM7TObbL8RR+sl97Vx9+v7KzLh/iXBzDPFYN6YaE+0P3IEB
         SnGQ1mXu5RGi68KulZK4obdQhWv3e+W7AeA5G+hYY+of7hymCJ7RcWEn/4vrGUkJ6yvO
         T4iZ2PaSm3Vnzu3DH2Yo0QYLmhwdEx8APgB2xNfau7PcBg0R6vKuM2yxsA0ox9iYK4xe
         /YpQzmP1SrKAeEVjdc3NGPv19yR0tM/jfBTOwAQpnB/BMn41q4ZZCICbmZhW91bmPy6i
         8Ubg==
X-Received: by 10.66.246.109 with SMTP id xv13mr24257330pac.144.1409167891640;
        Wed, 27 Aug 2014 12:31:31 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id zm5sm1172545pbb.76.2014.08.27.12.31.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 12:31:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256029>

Hi,

dev wrote:

>     CC credential-store.o
> "git-compat-util.h", line 516: error: identifier redeclared: inet_ntop
>	current : function(int, pointer to const void, pointer to char, unsigned long) returning pointer to const char
>	previous: function(int, pointer to const void, pointer to char, unsigned int) returning pointer to const char :
>	"/usr/include/arpa/inet.h", line 68

Why is NO_INET_NTOP set?  What commands are you using to build?  If
you are using autoconf, what does your config.mak.autogen say?

Puzzled,
Jonathan
