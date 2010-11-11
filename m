From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 00/11] gitweb: remote_heads feature
Date: Thu, 11 Nov 2010 20:29:21 +0100
Message-ID: <201011112029.22373.jnareb@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 20:29:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcq0-0000aW-CH
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 20:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545Ab0KKT3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 14:29:32 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36210 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab0KKT3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 14:29:31 -0500
Received: by bwz15 with SMTP id 15so2274272bwz.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 11:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DAMgvQbLRDW2IeRJw3sFsoRg/byiQDQE80E4l5DLF8U=;
        b=emvz9KfhshgmIp5fho9yIkg1HicoXQaJfrLGbiup6lGIRoLZZBmj1UBWQEgBtBEOQb
         8UHtKtwC5kIOsCmOhg4xvA5Bhq5bCaYZScfh7VAqk/14aYXaj4ji6GMy89guZ1ObLNr/
         kJ5HPhwKewPauV5Q5HI+ti2I1dBxwO/D2ZMQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KJltd8dTrmwn88892+vjBAoKTjSaTRq4qBkqB53qXV9TVSNaJvxcYKXFuUuozM/lzw
         emVQKJ9QBL2g+tAeKStDhkmF+aJBsDmCNlVGt2uVQEjRdNzkdTVtXGRO5+ngo+pxkzW6
         Kr48hQZIAp/OxLPj7p1OVnwAYxg8p5a1lLyrM=
Received: by 10.204.122.144 with SMTP id l16mr1790336bkr.173.1289503770110;
        Thu, 11 Nov 2010 11:29:30 -0800 (PST)
Received: from [192.168.1.13] (abvw231.neoplus.adsl.tpnet.pl [83.8.220.231])
        by mx.google.com with ESMTPS id a25sm1136442bks.8.2010.11.11.11.29.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 11:29:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161297>

On Thu, 11 Nov 2010, Giuseppe Bilotta wrote:

> This 7th version of the remote heads feature for gitweb differs from the
> previous mostly my small tune-ups, renames of internal functions, some
> patch reordering and a final addition.
[...]

I like this version very much.

> Giuseppe Bilotta (11):
>   gitweb: use fullname as hash_base in heads link
>   gitweb: introduce remote_heads feature
>   gitweb: git_get_heads_list accepts an optional list of refs
>   gitweb: separate heads and remotes lists
>   gitweb: nagivation menu for tags, heads and remotes
>   gitweb: allow action specialization in page header
>   gitweb: remotes view for a single remote
>   gitweb: refactor repository URL printing
>   gitweb: provide a routine to display (sub)sections
>   gitweb: group remote heads by remote
>   git instaweb: enable remote_heads

With exception of next to last patch, which contains a few of outdated
comments (see my response for this commit), I don't see any problems.

So, for the whole series:

  Acked-by: Jakub Narebski <jnareb@gmail.com>


Thanks for working diligently on this series, Giuseppe!
-- 
Jakub Narebski
Poland
