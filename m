From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log -M -- filename is not working?
Date: Fri, 07 May 2010 13:28:07 -0700 (PDT)
Message-ID: <m3ocgre9ul.fsf@localhost.localdomain>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	<h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
	<z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
	<19428.24021.324557.517627@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Fri May 07 22:28:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAU9f-0007Af-QC
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab0EGU2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 16:28:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:59201 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab0EGU2J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 16:28:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so45556fgg.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NwUm79ZkV2iSiaVwNZ3ZeFnL588sx3gyLQ8TP9sD0t0=;
        b=ailJG4R7uDHeaLXQu/M15hk37vDr//XnxAbjBWdPB6t725YhShPgmGmcuokEYKZ/CB
         6n9UQmtXe9iR7JZd9yzqKr/LXZxRnlgZltBERTx3HcE+ZuApPvCu7hKeED38BNgK/3gW
         +fiwZgy2Z1HbNVYIL3m5AHaT3flt0079Fi1TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=J3NuFYDBo9bUz35AiKMBP6FUJOwAet/JzB7/UUJI7PPuZuJHFdBUVp9A4sos/H3T2h
         JHdxKGz3lxrOUNp/+2mjsrht+59eR7xFeweqQixIPF0Z+FSD7D1cb961TVKcn50wRkJx
         cSo1kLA2l/ioqlTAP3PgSr82zgt72goOINhFs=
Received: by 10.87.67.25 with SMTP id u25mr4674130fgk.32.1273264087842;
        Fri, 07 May 2010 13:28:07 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id e11sm106093fga.13.2010.05.07.13.28.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:28:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o47KRTAb012661;
	Fri, 7 May 2010 22:27:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o47KREQG012656;
	Fri, 7 May 2010 22:27:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <19428.24021.324557.517627@winooski.ccs.neu.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146589>

Eli Barzilay <eli@barzilay.org> writes:

> On May  7, Eugene Sajine wrote:
> > On Fri, May 7, 2010 at 2:10 PM, Jacob Helwig <jacob.helwig@gmail.com> wrote:
> > > You want the --follow flag, too.
> > 
> > Thanks! I missed this guy. By the way it seems that --follow flag
> > works without -M or -C.
> > 
> > Are those deprecated or I'm missing the difference between three of
> > them??
> 
> BTW, I've had at least 4 people now who got confused by this.  Is
> there any use for -M/-C without --follow?  In any case, it will be
> very helpful if the -M/-C descriptions said "see also --follow".

Yes, '-M/-C' is useful with "git diff" _without_ pathspec, including
e.g. "git show -C".

The problem with "git log -M -- <filename>" is that history simplification,
which is required for good performance, happens before diff mechanism has a
chance to perform rename detection.  Before there was '--follow' option to
git-log (which supports only the case of single file, and doesn't work that
well with more complicated history), you were forced to do

  $ git log -M -- <filename> <oldname> <oldername>...

> 
> Also, is there a way to set this as the default for `git log'?

I don't think so.  Note also that '--follow' works only with single file,
and does not work for example (currently) with directory pathspec.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
