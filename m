From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git branch -a prefixes origin/ branches with remotes/
Date: Wed, 31 Mar 2010 10:52:34 -0700 (PDT)
Message-ID: <m3aatoidl9.fsf@localhost.localdomain>
References: <18137.1270056387@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Wed Mar 31 19:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx25r-0005eT-CC
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 19:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920Ab0CaRwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 13:52:38 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:47859 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab0CaRwh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 13:52:37 -0400
Received: by bwz1 with SMTP id 1so275762bwz.21
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=hDXxIvzjQz5aa4qlMKjPbPc0nX3LBq+F95y+JKXX0ks=;
        b=Czht0c1q6iHdvjJOmyVTVFwHaUOm1oBeBEkdyR5nwu4DEQ82B+ulo75MjE/mHvqs0k
         p/VZn4Hbi22Xg+egn7U5yemKE7itwQ5k/95038FZcnSyhYqZ8TbnmOSeYGjsM5V0HeRu
         00tzNJ7bmesD+WFL+2hvr2TPTCz6IHUezrhpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=gq9Lzp0FU+n/fcYUGOFCJL4IcyLNlVqb8PBfzXjp6Y1x1YSsinv7kknpCfI4rlqUrd
         0iACGTyS3Q9OrA1AhbONaN+AO8s4L2H/3ksSFd/MkBPlOo6tQ3ffmD/XhOCs0Ene6qpV
         hatPlN2bhp9zmONklkCZZGJHpryF0mOjA2g4o=
Received: by 10.204.32.196 with SMTP id e4mr786107bkd.131.1270057955275;
        Wed, 31 Mar 2010 10:52:35 -0700 (PDT)
Received: from localhost.localdomain (abuz2.neoplus.adsl.tpnet.pl [83.8.197.2])
        by mx.google.com with ESMTPS id 15sm3758001bwz.8.2010.03.31.10.52.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 10:52:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2VHq5fM008773;
	Wed, 31 Mar 2010 19:52:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2VHpllV008768;
	Wed, 31 Mar 2010 19:51:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <18137.1270056387@relay.known.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143689>

layer <layer@known.net> writes:

> In git 1.6.6.1 & 1.6.3.3, "git branch -a" output is like this
> 
> * master
>   remotes/origin/foo
>   ...
> 
> instead of like this for 1.6.1.3
> 
> * master
>   origin/foo
>   ...
> 
> 
> Is this a feature or bug?  I searched the mailing list archives and
> announcements couldn't find any reference to this change.
> 
> This is important to me because I use the output of "git branch -a" in
> scripts.

Don't use git-branch output in scripts; git-branch is porcelain and
its output is meant for end user and is subject to change!  Use either
git-show-ref, or powerfull git-for-each-ref.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
