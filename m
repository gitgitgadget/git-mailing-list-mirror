From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v7, resend] gitweb: ref markers link to named shortlogs
Date: Wed, 3 Sep 2008 01:16:12 +0200
Message-ID: <200809030116.13676.jnareb@gmail.com>
References: <1220384825-19824-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:18:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaf7k-0002sq-18
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYIBXQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbYIBXQQ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:16:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:14490 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbYIBXQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:16:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2217906fgg.17
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wW1a8G2V5BZLnakSbNKbDkSiD+yN0s5BlceNx6ea8hE=;
        b=NejKTGH0idu3o6B0QDMG+Nb2FCGgswjeNWCN9VT2CBTHXB0GTl7qoUjWpcD8dWKX1b
         ko/WkUf9f4Qk6R9PjET+IkrBaO8o++ZoHlnveE+3Ac7PnulhuMjfJcD/W4dz3qhIoiiV
         GkbXhlHhz+4LjoL5nK/BL0gw1lo8bgUdPgnMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NPmyhLmHVK/OU49VfGFC+4oVQ+vYsb9OLB+6cldDTWuPCSxRAcAFWY11iXmvLXsyLq
         YdNXKnUz8bvUqflfnbPEJD3jdq3BBjvqz3W8/0z6EhKeUveZeiVThDoh0jmk3r4ZnHVO
         4TTt3iWh9bjyG44b62o/tfGxXCQJblXTJtKUA=
Received: by 10.86.80.5 with SMTP id d5mr6101744fgb.19.1220397373068;
        Tue, 02 Sep 2008 16:16:13 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.222.100])
        by mx.google.com with ESMTPS id d4sm8959242fga.5.2008.09.02.16.16.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Sep 2008 16:16:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1220384825-19824-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94737>

On Tue, 2 Sep 2008, Giuseppe Bilotta wrote:

> This patch turns ref markers for tags and heads into links to
> appropriate views for the ref name, depending on current context.
> 
> For annotated tags, we link to the tag view, unless that's the current
> view, in which case we switch to shortlog. For other refs, we prefer the
> current view if it's history or (short)log, and default to shortlog
> otherwise.
> 
> Appropriate changes are made in the CSS to prevent ref markers from
> being annoyingly blue and underlined, unless hovered. A visual
> indication of the target view difference is also implemented by making
> annotated tags show up in italic.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

for what it is worth...
> ---
> 
> This is a resend of v7 of the refmark patch, since it seems to
> have falled again below the gitweb maintainers' radar, despite
> their interest in it ;)

Unfortunately there is not gitweb maintainer; nobody picked up
the mantle (although there are a few of unofficial gitweb "gurus").

-- 
Jakub Narebski
ShadeHawk on #git
Poland
