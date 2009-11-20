From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.15
Date: Fri, 20 Nov 2009 21:50:04 +0800
Message-ID: <20091120135004.GA3919@debian.b2j>
References: <20091120133117.GA26917@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 20 14:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBTsR-0000EX-Fx
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 14:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbZKTNuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 08:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbZKTNuG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 08:50:06 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:52289 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbZKTNuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 08:50:05 -0500
Received: by pzk1 with SMTP id 1so2410877pzk.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 05:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7VmsXya+OzRycVQ2yXNO3heOFY5l/EdZFQSh8SQNtDU=;
        b=SLFewRVqnVkG8M9IXAP4Fi4T4o9bjLD93yTonOMIsA7cfyug9bMpbMby/1ZOg5xDrL
         KZqDUmf5PWOpIRrCkg2ONsbftwfnry/rKoUQqDQAK1mt+4rcE4QdIBIp7lFUCYYU3+/j
         jwBk+nr+4csesbvjqvZqfUheKIvO1Ic8kLn+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L6LboxXn3hZv914gpizihVfxolgiEmD0ubMGaxk+jVTOjL52w2ls7Ttex8pImUDqKy
         gLT4ScKZ0WTupauKdBrVonK89Xvx1gqnSoBGP1Qse9akRREt52HqTY+z6+I7x7qs/381
         OqKUr+jPNVq0BhQIRWoOvWcUdxmB7g4pvgNac=
Received: by 10.114.18.4 with SMTP id 4mr2003424war.137.1258725011175;
        Fri, 20 Nov 2009 05:50:11 -0800 (PST)
Received: from localhost (n219077015140.netvigator.com [219.77.15.140])
        by mx.google.com with ESMTPS id 23sm971614pzk.12.2009.11.20.05.50.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 05:50:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091120133117.GA26917@diku.dk>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133345>

On Fri, 20 Nov 2009, Jonas Fonseca wrote:
>       Build with asciidoc-8.4.5
..
>       Update asciidoc table syntax to the one supported by version 8.4.4

sciidoc -aversion=0.15-dirty -asysconfdir=/usr/etc -b docbook -d manpage tigmanual.7.txt
FAILED: /home/bill/src/tig/manual.txt: line 314: illegal [paradef-default] options: header: header
make: *** [tigmanual.7.xml] Error 1

May be the asciidoc 8.2.7 in debian lenny is not new enough. make install-doc
failed with the above message.  Any workaround other than upgrading asciidoc ? 

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
