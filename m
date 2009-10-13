From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Tue, 13 Oct 2009 06:17:13 +0200
Message-ID: <1255407433.15646.12.camel@localhost>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
	 <1255383459.15646.10.camel@localhost>
	 <20091013014332.GB13737@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: sylvain@demarque.qc.ca, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 06:21:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxYtE-0005d6-Fv
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 06:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbZJMERw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 00:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbZJMERv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 00:17:51 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:47156 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZJMERv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 00:17:51 -0400
Received: by ewy4 with SMTP id 4so3031318ewy.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 21:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=MRWAhMv//KDt3FNCj1M5Dm0oI+Ko83SHqNu90KC3jmQ=;
        b=nCNYvP1idh+lw7IFXkiwDpjRUCsLFsKB6BA7wSgk7ZJYtAbevK17y1VvqKSxi4Qm2T
         2f/fNOZXqq7DqfQJOmm4w7PmU4abu5efK5wqTKx6Zh6hZ4HKyqgUC58V4SpDgri0xShT
         C8jtAaxisD1jneVdfxZtV1VEF/+LWXNxzoqMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=hS5N//M47pzKldT11Pz0dJBCPfDSNUKaX8b87Mn8EQbl4rOaa3FgyKVSqcqNRq4wYr
         tDlx/+FsbkA9jyfyVgHmzcL9/rgfy1VhgQqiZckjNa0cfEIT/cA36WyiNyTbDBKKTOPM
         rfFeuPBNSSi0PLr5uiMw2JDB9uD/mPfPdndoY=
Received: by 10.210.7.24 with SMTP id 24mr5016945ebg.53.1255407433938;
        Mon, 12 Oct 2009 21:17:13 -0700 (PDT)
Received: from ?192.168.1.2? (host185-1-dynamic.48-82-r.retail.telecomitalia.it [82.48.1.185])
        by mx.google.com with ESMTPS id 10sm2020286eyz.44.2009.10.12.21.17.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 21:17:12 -0700 (PDT)
In-Reply-To: <20091013014332.GB13737@coredump.intra.peff.net>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130124>

Il giorno lun, 12/10/2009 alle 21.43 -0400, Jeff King ha scritto:
> Take a look at:
> 
>   http://joey.kitenet.net/code/etckeeper/


thanks really interesting


> > can I have a git report of $HOME/.* (without . and ..)? (all user
> > setting)
> 
> This seems to work:
> 
>   $ cd ~
>   $ git init
>   $ echo '*' >.gitignore
>   $ echo '!.*' >.gitignore
> 
> > Or better: provide a list of directory under $HOME I want to track 
> 
> Same thing, but make your ! pattern more specific.

thanks again!

regards,
Daniele
