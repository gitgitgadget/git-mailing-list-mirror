From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 5/8] gitweb: gravatar url cache
Date: Sat, 27 Jun 2009 01:53:51 +0200
Message-ID: <200906270153.52512.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <200906270111.26640.jnareb@gmail.com> <cb7bb73a0906261627i1a32bef1h3833d1c12a12e759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 01:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKLF5-0000fg-Cw
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 01:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZFZXxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 19:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbZFZXxw
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 19:53:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:24079 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZFZXxw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 19:53:52 -0400
Received: by fg-out-1718.google.com with SMTP id e21so575830fga.17
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 16:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9pMAoTMEpQC6C6t+4+Q3lW2oNj1uyzaHCfe+T76B7PA=;
        b=msEU2IBBhPlaL87uOs+eJ3/8tOtkeRkaI9PYbzEh89w1iPDuKzuVRUKCkvqridH9js
         KhBdhhsqVVDaX6Y3qlspghgydcZN8RIxTbwN5q2zYerlATlWoXjRnZ8+uOtP3XvU2VZj
         LzIzm2Tyu2KrGBGTvFseQixkb0b9WVIwcC8d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bMcVYxjNQwMvlNLC6ihQpxC+YL/X4z4BWbUmrC70gjOCxu2kkD74JtXWEXe1CKjzO4
         8LlFjS6C8JwcGnfJhLFTNxEq7J/604wn/lFuGwCIJJCoUjXfo44OBZHXmw8AdVt8T1OJ
         BJkuoJmul9KinkakrE/GKbQOIAOuu7MkQu/PA=
Received: by 10.86.86.10 with SMTP id j10mr4157180fgb.37.1246060431529;
        Fri, 26 Jun 2009 16:53:51 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id e20sm1405568fga.0.2009.06.26.16.53.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 16:53:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0906261627i1a32bef1h3833d1c12a12e759@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122337>

On Sat, 27 Jun 2009, Giuseppe Bilotta wrote:
> 2009/6/27 Jakub Narebski <jnareb@gmail.com>:

> > BTW. http://www.gravatar.com/site/implement/url recommends
> > http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802 rather than
> > http://www.gravatar.com/avatar.php?gravatar_id=3b3be63a4c2a439b013787725dfce802
> > you use, following http://www.gravatar.com/site/implement/perl
> 
> I think the perl code there is just obsolete (the /avatar/ thing is
> more recent). I'll update to the new one because it's more compact.

I think that Gravatar::URL module on CPAN[1] (which we cannot use in
gitweb because it is extra nonstandard non-core not needed dependency)
also uses newer path_info form.

[1] http://p3rl.org/Gravatar::URL

-- 
Jakub Narebski
Poland
