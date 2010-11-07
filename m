From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Yet another git archive all
Date: Sun, 07 Nov 2010 04:00:11 -0800 (PST)
Message-ID: <m3r5exfiop.fsf@localhost.localdomain>
References: <AANLkTim07Ku=ETtPEutZ_gWagXdg8kVTUMMDpZcs1kMm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 13:00:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF3v4-0004CE-Pr
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 13:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab0KGMAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 07:00:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64203 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0KGMAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 07:00:13 -0500
Received: by fxm16 with SMTP id 16so3424985fxm.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 04:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Kqr5ny5+SeVfIDDveXvijI59dxpe2O8R56C0RdnKepE=;
        b=UsW2kWYFM3NpTjvvLfFpDhNXmeX6ONxA0sTSXcTN+rSqgxeU1qwthrTG6skTN7TbzQ
         T1uDpwO+a32FsdDXLiBmMpktP2b5EgrmbIYI7egYVJmLndOfEFdIdIgxoSnm4W/Uz4ve
         ATqEj+mpD13PF3Pul+4Y99XqJjBLTr9VO5qtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HJXv+SnDZff+v2hEOXBvMnh3uMuLgB4HXO1JT/pmhf2bjnkB+5Z/jqnIKoIuBGTOLt
         KI4pxtQzoxPUoruSwNTOiGyJDS2IhSGe2O/ZDQI3jiWZaL6j0LeGZ3jm62N/hKq4BXlK
         xDRJ4kxB2+rqCNyhYVJrD8q6KoaGVkFWbGGI0=
Received: by 10.223.122.201 with SMTP id m9mr2697460far.79.1289131211934;
        Sun, 07 Nov 2010 04:00:11 -0800 (PST)
Received: from localhost.localdomain (abwh115.neoplus.adsl.tpnet.pl [83.8.231.115])
        by mx.google.com with ESMTPS id a25sm1592182fab.13.2010.11.07.04.00.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 04:00:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oA7BxijW022397;
	Sun, 7 Nov 2010 12:59:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oA7BxYcE022357;
	Sun, 7 Nov 2010 12:59:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTim07Ku=ETtPEutZ_gWagXdg8kVTUMMDpZcs1kMm@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160877>

fREW Schmidt <frioux@gmail.com> writes:

> I was trying to use this:
> https://github.com/meitar/git-archive-all.sh/blob/master/git-archive-all.sh
> 
> but I was having issues and am not really a bash programmer, so I
> wrote a new, much more minimal archive-all.
> 
> I haven't added *any* option support, it only exports as zip, and it
> does foo.zip as the file, but those things should
> be pretty easy to fix for someone who cares.  Anyway, here it is!
> 
> git ls-files --cached --full-name --no-empty-directory -z | xargs -0
> zip foo.zip > /dev/null
> git submodule --quiet foreach --recursive 'perl -e "print join qq(\0),
> map qq($path/\$_), split /\0/, qx(git ls-files -z --cached --full-name
> --no-empty-directory); print qq(\0)"' | xargs -0 zip foo.zip >
> /dev/null

If you feel it is ready for wide use, could you ad information about
this project to

  https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools

Thanks in advance.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
