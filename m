From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Announce gitslave - manage a superproject with slave repositories
Date: Tue, 21 Sep 2010 14:47:44 -0700 (PDT)
Message-ID: <m3r5gmkbw0.fsf@localhost.localdomain>
References: <201009210139.o8L1d1iY026728@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 23:47:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyAgq-0001e7-OX
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 23:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab0IUVrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 17:47:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37130 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab0IUVrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 17:47:47 -0400
Received: by fxm3 with SMTP id 3so1810316fxm.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 14:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=4ATw5igsn8ZQCKTKU6SsQuDRGZrCEAnuu+5KsVSbrng=;
        b=a++ofv9V+gbAYWs3xTxUgZhpefuSgbFTMxxmECTWHthYlGNZPG65RraSqbEp6mZ0Ai
         mSNwYoExd6Rz3ELAkj/js09yx2w/+wnezY0cqevn3dt4qkBRrkjKWDR6MPHusZt8UMjU
         5pPB52SvdgH1Sq2aQ+MIFK9uiu0x+KopetzyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VDYSY9McRc2hoRyUsSoMybOzCFkwVtjfxMB5YW/b/pZgb1jBGhrSINIvFA0BTCrVGP
         Dh+9aQT+YyZvUctgmPPnXM6ApMbfpSf1RhZaJyDqgpsiIg4IKtf8woclpmumHS87LyPJ
         Ayjb51gr+LKqoWcRu/UV2j7Ws+RwnRXD2vyYs=
Received: by 10.223.107.130 with SMTP id b2mr6967399fap.27.1285105665967;
        Tue, 21 Sep 2010 14:47:45 -0700 (PDT)
Received: from localhost.localdomain (abvk112.neoplus.adsl.tpnet.pl [83.8.208.112])
        by mx.google.com with ESMTPS id t6sm3906278faa.3.2010.09.21.14.47.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 14:47:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8LLlC6P031850;
	Tue, 21 Sep 2010 23:47:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8LLktLo031846;
	Tue, 21 Sep 2010 23:46:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <201009210139.o8L1d1iY026728@no.baka.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156765>

Seth Robertson <in-gitvger@baka.org> writes:

> I'd like to announce the first public version of gitslave.
> 
> gitslave creates a group of related repositories all of which are
> concurrently developed on and on which all git operations should
> operate, so when you branch, each repository in the project is
> branched in turn.  Similarly when you commit, push, pull, merge,
> tag, checkout, status, log, etc; each git command will run on the
> superproject and all slave repositories in turn.  This sort of
> activity may be very familiar to CVS users and to a lesser extent
> subversion users where it was fairly normal to assemble a
> superproject in just this way.
[...]

> http://gitslave.sourceforge.net/
> 
> Current release as of 2010-09-20: 1.0.0
> http://sourceforge.net/projects/gitslave/files/gitslave-1.0.0.tar.gz/download

Could you please add information about this project to
InterfacesFrontendsAndTools page on Git Wiki:
  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

Somewhere in neighbourhood of 'repo' or 'git-subtree' could be good.

Thanks in advance.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
