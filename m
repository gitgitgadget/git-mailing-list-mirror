From: jupiter.hce@gmail.com
Subject: Re: 1.7.10.3 configure does not generate Makefiles
Date: Mon, 4 Jun 2012 09:34:20 +1000
Message-ID: <20120603233420.GA3002@gmail.com>
References: <20120529233238.GC3072@gmail.com> <CABPQNSZaNeu7n36_v_Xe26WHqtXNQWWXiPVutvVM7hk+q5S_-Q@mail.gmail.com>
Reply-To: jupiter.hce@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 13:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbVYd-0007MH-QS
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 13:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab2FDLeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 07:34:44 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48256 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab2FDLen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 07:34:43 -0400
Received: by dady13 with SMTP id y13so5711253dad.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YLq8jqkSP5XyvqrB+heKw96UhbGMI+nd62DzkIQprUM=;
        b=Yl0wDzFbn6uuNfz2G5ILmzERjY9YmiC0qBv6L/dgIgSmRYR15FdNXwzckEqCt2f9+O
         iVqNUsngcIrT/ndI7vwtstKlP5n+dpGFa3z3M2uZX/WP4PEShfxG/cCKoXmUEz8Y6EkO
         Pyf+OCh7waz/OLSRJIImPD5IZS74mQzS8Ewq+8n5GlXhZl1rAR1l2K/3gQfnFdUPDJS/
         qh2mzQwNdOZmkQZG7RwguR233J6+u7Q/+7jt1sPrHFwbl7a1L3H1FvQ6e+gmvlsmTsID
         dauUxHgSQ4Ccb8qut/GI7pJOvBfPIACXA/ojapvf/28xOTcKXOGy4fcLIfQ7k27dTuqE
         aqYg==
Received: by 10.68.219.41 with SMTP id pl9mr35285142pbc.61.1338809682833;
        Mon, 04 Jun 2012 04:34:42 -0700 (PDT)
Received: from debian ([210.56.81.12])
        by mx.google.com with ESMTPS id ve6sm13006354pbc.75.2012.06.04.04.34.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 04:34:41 -0700 (PDT)
Received: by debian (Postfix, from userid 1000)
	id C6679411A7; Mon,  4 Jun 2012 09:34:20 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <CABPQNSZaNeu7n36_v_Xe26WHqtXNQWWXiPVutvVM7hk+q5S_-Q@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199127>

I posted following comments on Forum many days ago, somehow, it was
pending for being accepted.Sorry if it is duplicated:

--- Attachement post on forum --

This post has NOT been accepted by the mailing list yet. 

In reply to this post by Erik Faye-Lund-2 

I thought I've sent the comments, but did not see on the forum, sorry
if it is duplicated. 

Thanks for all response. The Makefile is included in the source
directory, but I'd like to build the git in a separated build
directory, not the source directory. Is it possible to build the
git in a separated build directory? Or if there is any way to
geneerate a Makeifle in a separaed build directory? 

Thank you. 

Kind regards, 

hce

On 2012-05-30 13:38+0200, Erik Faye-Lund wrote:
>On Wed, May 30, 2012 at 1:32 AM,  <jupiter.hce@gmail.com> wrote:
>> Hi,
>>
>> I've just downloaded 1.7.10.3 source tarball and following the
>> instruction from INSTALL, I ran the autoconf to generate the
>> configure, then to run configure --prefix=/usr/local/git/1.7.10.3.
>> There were no errors but there was no Makefiles generated either. How
>> can I run the configure to generate Makefiles?
>>
>> .......
>> configure: creating ./config.status
>> config.status: creating config.mak.autogen
>>
>
>This is as expected. Git doesn't use Automake, only Autoconf. So all
>it generates is a config.mak.autogen, which gets included by the
>Makefile which is already present on the top-level.

-- 
