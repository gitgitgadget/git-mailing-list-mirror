From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/resend] Fix use of hardlinks in "make install"
Date: Sat, 30 Aug 2008 17:48:50 +0200
Message-ID: <81b0412b0808300848o7510bbc4u178f32f8d23723d@mail.gmail.com>
References: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com>
	 <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com>
	 <20080830002032.GA14522@steel.home>
	 <66B007DD-F970-43E5-BA38-6138E553C93A@googlemail.com>
	 <81b0412b0808300308m2d03b94ft8601f02b2fea494e@mail.gmail.com>
	 <60597530-B8AC-421E-84DF-BF241CB799C5@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "=?UTF-8?Q?Andreas_F=C3=A4rber?=" <planche2k@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 17:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZSiC-0003IC-OY
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 17:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbYH3Psw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 11:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbYH3Psw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 11:48:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:34831 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYH3Psv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 11:48:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1273423rvb.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=L55Jd8YW7RQrV6CHKEhDsDLPBfAKvfMr8BJU2Mi1JMQ=;
        b=AS/l2BgkDfgSq4Qh63rkklfcwMqHDIRmNO3fejJLTXNDg6rVZgJAPE4bhA3JEUVznv
         LhbZnLkT+pIampuXDASby+DKZTnE6ER64erU7eg/8egdwCIEUsOA4OHcqFWjfMnNZEiS
         L0WNWziyyS4rCtP9KCGT112jMLz6pX68ro9KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=D/ZcNhhimsGA34zFtTwGLv7reZbCGsGS6rSrcB4kC67BJlvPewZPi9WXiyOq8OTzEu
         EsylzUua/td8bhKMoRuoSs33HAW2VtKYRTXqEi7R6zf2dBXeJhDNPuKKQUc5zDdL07kJ
         5zbJFRFe4xT+Mf+OgoUw417pwEEEWFmK3vV0g=
Received: by 10.115.18.1 with SMTP id v1mr3809571wai.15.1220111330894;
        Sat, 30 Aug 2008 08:48:50 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Sat, 30 Aug 2008 08:48:50 -0700 (PDT)
In-Reply-To: <60597530-B8AC-421E-84DF-BF241CB799C5@googlemail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94383>

MjAwOC84LzMwIEFuZHJlYXMgRsOkcmJlciA8cGxhbmNoZTJrQGdvb2dsZW1haWwuY29tPjoKPgo+
IFNpbmNlIG5vIG9uZSBhcHBlYXJlZCB0byBoYXZlIHJlcGxpZWQgeWV0LCBJIGNvbmZpcm1lZCB0
aGF0IHlvdXIgV2luZG93cwo+IHBhdGNoIGRvZXMgbm90IGJyZWFrIHRoaW5ncyBoZXJlIGFuZCBs
b29rcyByZWFzb25hYmxlIHRvIG1lIGFzIGNvLWF1dGhvciBvZgo+IHRoZSBvZmZlbmRpbmcgY29t
bWl0LgoKT2sK
