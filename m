From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #07; Fri, 22)
Date: Sat, 23 Jan 2010 03:18:17 -0800 (PST)
Message-ID: <m3my05ax5v.fsf@localhost.localdomain>
References: <7vtyudfqju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 12:18:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYe0a-0006tt-2A
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 12:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab0AWLSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 06:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754450Ab0AWLSU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 06:18:20 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:33011 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0AWLST (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 06:18:19 -0500
Received: by fxm21 with SMTP id 21so195592fxm.29
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 03:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uQHFK6Wntau7PodCNIwbE+Eh0/xnrBsF5J8rDW5lT3w=;
        b=TDljMqtpG8gJm+xlJYJGfdPBO1vt4JjRoqy7zheLNZDOqx4YfevwO5Qk+N/sZwBNYt
         B/LuOdT4d1rnbJg88p+27KUuNSGPOnI3IHgmbWwPU6Kc2miiUPWckYnv2Gm4NzmzjnBh
         Ul0ccmYf/FVJ7iZ7blNnFUen6m3XdZWgJMyzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=qzdfUQhAUwyZN3bILr/TNpiuKDONoXeDEwJQmCzviuXPvRG7uCT56QwbFO7E7JtIsr
         GIACaAHbKtn5g11TALrjzRDtndhI9/hS/gEeNFYSxbAz4KMWwj4UwUgXFcyt2enKdMaL
         /O03akSmDw7MiL0M4GUFFyTXyVb5Y3kU8Su3I=
Received: by 10.103.84.37 with SMTP id m37mr2079773mul.81.1264245497883;
        Sat, 23 Jan 2010 03:18:17 -0800 (PST)
Received: from localhost.localdomain (abws72.neoplus.adsl.tpnet.pl [83.8.242.72])
        by mx.google.com with ESMTPS id j9sm12341374mue.6.2010.01.23.03.18.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 03:18:17 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0NBHD8n023409;
	Sat, 23 Jan 2010 12:17:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0NBGiYs023404;
	Sat, 23 Jan 2010 12:16:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vtyudfqju.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137836>

Junio C Hamano <gitster@pobox.com> writes:

> * jh/gitweb-cached (2010-01-13) 9 commits
>  - gitweb: File based caching layer (from git.kernel.org)
>  - gitweb: Convert output to using indirect file handle
>  - gitweb: cleanup error message produced by undefined $site_header
>  - gitweb: add a get function to compliment print_sort_th
>  - gitweb: add a get function to compliment print_local_time
>  - gitweb: Makefile improvements
>  - gitweb: Add option to force version match
>  - gitweb: change die_error to take "extra" argument for extended die information
>  - gitweb: Load checking
> 
> Replaced with a re-roll.  Update to t9500 is probably needed.

I have sent proof of concept replacements for the last two
patches... and those do include update to t9500 (although caching is
tested only rudimentally).

I don't know if J.H. is working on replacement patches; I am planning
on re-rolling cleaned up version of split file based caching layer on
top of his changes / his re-roll.

-- 
Jakub Narebski
Poland
