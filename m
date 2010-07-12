From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 11
Date: Mon, 12 Jul 2010 20:12:33 +0200
Message-ID: <20100712181233.GC17630@debian>
References: <20100712143546.GA17630@debian>
 <4C3B2B48.4070408@drmicha.warpmail.net>
 <20100712152403.GH1931@jack.stsp.name>
 <1278949191.1611.5.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Sperling <stsp@elego.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Greg Stein <gstein@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Huijben <rhuijben@collab.net>,
	Sam Vilain <sam@vilain.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYNSx-0002iN-LB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334Ab0GLSKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 14:10:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43926 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab0GLSKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:10:49 -0400
Received: by eya25 with SMTP id 25so621220eya.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+s2RDM0Do8Fx+0aoKZYFOjYmOL1U7Vt25aCsju/KKW0=;
        b=SNfobHwfvxwOCHbbaXP9bEyC8N9k/eauC34hnQ15UzRI5FLu7CvvRj+a2yFt5Qzm9C
         Njn3/soGNfICoX4F0zqCePXRZ/yLmvALP3CzFORV7BM/fN6s7Gvcj8gFz+4Xr1BP41Sl
         sqQNdhh8dwjv7x7/r6vhR4GgslhKst6OvizMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=huvyoPrZUB/KuRvALtt+Fdkn8GvEJP7HKbsnCy4RxlNUfT99ioJhkKxDGD0lZkn+ME
         70bk1wRZ75mVZ3ESmmc9vcwEPW7vKppDTO/RWInYhEe5FrPFGNkjtESXlLo6aNd5MeEh
         5PBaxb57zl6S+mn7rjKFXVE45MvGsUzGB/ep4=
Received: by 10.213.31.70 with SMTP id x6mr10189843ebc.42.1278958247852;
        Mon, 12 Jul 2010 11:10:47 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id v8sm39187845eeh.2.2010.07.12.11.10.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 11:10:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278949191.1611.5.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150833>

Hi,

Will Palmer writes:
> This is all moot, because the whole point is that svndumpr compiles
> against libsvn, so you don't need the whole svn source-tree. All you
> need to get svndumpr working are some header files and a working libsvn.
> Everyone who currently uses git-svn already has a working libsvn, since
> perl's svn bindings wrap around libsvn anyway.

Yes, I meant that people will need the complete Subversion tree if I
DON'T get svnrdump merged somewhere in git.git (I'll attempt to get
the version that compiles against libsvn 1.6 merged). The instructions
to checkout the right branches and place it in the git tree can be
complicated: git-remote-svn relies on a chain of tools including
David's exporter and svnrdump to work.

-- Ram
