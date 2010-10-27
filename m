From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Wed, 27 Oct 2010 10:07:44 +0200
Message-ID: <201010271007.45508.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <1287917136-26103-11-git-send-email-giuseppe.bilotta@gmail.com> <201010270232.37961.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 10:08:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB13I-0007vu-B0
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 10:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab0J0IIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 04:08:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49313 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab0J0IH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 04:07:59 -0400
Received: by bwz11 with SMTP id 11so288268bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OAN4uF7RQmQrDh/dmR+v1onmhPNeNQ5lvt08ftM/Btk=;
        b=ios4/ZKzHfyT4WKQE82cVuTRXZiyfMXlmyPfB2ZQUhBeLaMKmZNHLLF3fJHgPhjh6o
         bCho0NjScI+AD1vhnrv3zd9lo+hAcwML6lXgVUoj4AcUpLiNFfeuBY68HmdtTYEm9Tpm
         Z8Megx2xb/Uscsx3jkeYrPTlhYPRdnMo64kR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=M1IjxhNuOMYffd5h0OJKyolbHMCbxvQxRxx8u4CLQyoKmDJuHp9WEoNF298lzcSJAB
         Yj4ZZqngvglftfO5iANJE+DV+z6C10UXDD1Yt5+r/9kvhHvLDpS014hreaWlNhUiK3CT
         PK/4QuLnm6YPYlIXuqg04p6IRkC+a8JxtAi+k=
Received: by 10.204.127.94 with SMTP id f30mr7068758bks.1.1288166876366;
        Wed, 27 Oct 2010 01:07:56 -0700 (PDT)
Received: from [192.168.1.13] (abvr250.neoplus.adsl.tpnet.pl [83.8.215.250])
        by mx.google.com with ESMTPS id f21sm6346801bkf.12.2010.10.27.01.07.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 01:07:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201010270232.37961.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160026>

On Wed, 27 Oct 2010, Jakub Narebski wrote:
> On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:

> > +# It is possible to limit the retrieved remotes either by number
> > +# (specifying a -limit parameter) or by name (-wanted parameter).
> 
> I don't quite like limiting when generating, and would prefer do limiting
> on display, especially if not doing limiting would not affect performance
> much (git command invoked doesn't do limiting, like in case of 
> git_get_heads_list / git_get_tags_list or *most important* parse_commits).
> 
> Especially if it complicates code that much (see below).
> 
> Not doing limiting here, in git_get_remotes_list (or just git_get_remotes)
> would also make API simpler; the single optional argument would be name of
> remote we want to retrieve.

Note that you can see the changes I have mentioned here:

  git://repo.or.cz/git/jnareb-git.git  gitweb/allheads-jn

  http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/gitweb/allheads-jn
  http://github.com/jnareb/git/commits/gitweb%2Fallheads-jn
  

-- 
Jakub Narebski
Poland
