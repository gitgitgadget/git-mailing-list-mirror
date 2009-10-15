From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] gitweb: linkify author/committer names with search
Date: Thu, 15 Oct 2009 11:30:35 -0700
Message-ID: <4AD76A4B.5000302@gmail.com>
References: <1255486344-11891-1-git-send-email-bebarino@gmail.com> <200910151341.36520.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 20:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyV72-0000ik-T0
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 20:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934998AbZJOSbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 14:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933396AbZJOSbV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 14:31:21 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:46308 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351AbZJOSbV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 14:31:21 -0400
Received: by fxm28 with SMTP id 28so1371268fxm.18
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=END9U9dHd27yyj2pSTZq0GLGDsIT53DBeJ4qsDyr3F4=;
        b=bw/dpLXR8kny2KwMvCHArw23P/QvME4HO28hFXaILzTAlQfYruC2XSN4byFNCorNNT
         KJT66kU9TfLGbz0SvkYAk4+lEjNys27p1QiitPOGT3gSaa4h08RW5hwW9GMFKyol2mtQ
         czf08fqQ6EUmwk+6yyazb2XFAxjw1/hPVs2J4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=WIE8fG3qUKZEtfGxwSC9uHsLV6QObitgs9tK1qEIt8dMv5+iVJXLbMB6DhrM6OBwf5
         sLfuJp124W6IybxzHjAENLXRK2sNjzbee9xFl3/MBGOc0Txs1HrtsungGSUNgQ9NoBXy
         GEh+cz5N0n+unqsD2j3FHJ8F76TwDUTMTnroI=
Received: by 10.103.126.33 with SMTP id d33mr165999mun.109.1255631444252;
        Thu, 15 Oct 2009 11:30:44 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id s11sm323137mue.11.2009.10.15.11.30.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 11:30:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <200910151341.36520.jnareb@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130410>

Jakub Narebski wrote:
>
> I see that it can be useful.  But is this discoverable, and does this
> do expected thing?  Most of links in gitweb lead to some view (page)
> that is specific to link; other lead to anchor on same page.  Leading
> to search results can be unexpected.
>
> Perhaps title explaining what does such link does would help?  Or making
> style of this link distinct from other (dashed underline, dashed 
> underline on mouseover, double underline, different mouse cursor on
> mouseover, etc.)?

A title sounds good. Something like "List commits by $author"? I'll try
to write something up by tonight.
