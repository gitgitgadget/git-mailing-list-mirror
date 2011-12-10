From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 11/13] strbuf: add strbuf_add*_urlencode
Date: Sat, 10 Dec 2011 03:57:59 -0800 (PST)
Message-ID: <m3iplohc6s.fsf@localhost.localdomain>
References: <20111210102827.GA16460@sigill.intra.peff.net>
	<20111210103420.GK16529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 12:58:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZLZB-0003tn-St
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 12:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889Ab1LJL6E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 06:58:04 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53613 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab1LJL6B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 06:58:01 -0500
Received: by eaak14 with SMTP id k14so2119303eaa.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 03:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=HJDXpJbWs5REwLvVF4ZTnO8nOgVjvcbdqSACarcjHqA=;
        b=ZVHjAAjPxZw5ivGDkFGTWe2lHahYwJloK0MN18bd73FzsFKMs0Objg++EqEZnrDMTh
         0m69sKoemAPT6pIMG2MqF7sTyAlQsBYzmojyOfKrwBud0PUvHrFMMHzdKa8vO9cyC1lR
         sR3m0LoNhZthpNn8kuvdkxfQpjYcBMtrjHlxQ=
Received: by 10.213.27.81 with SMTP id h17mr703940ebc.99.1323518279940;
        Sat, 10 Dec 2011 03:57:59 -0800 (PST)
Received: from localhost.localdomain (abwc156.neoplus.adsl.tpnet.pl. [83.8.226.156])
        by mx.google.com with ESMTPS id z43sm32482390eef.7.2011.12.10.03.57.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 03:57:59 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBABvKQK001599;
	Sat, 10 Dec 2011 12:57:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBABuxub001588;
	Sat, 10 Dec 2011 12:56:59 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20111210103420.GK16529@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186763>

Jeff King <peff@peff.net> writes:

> +void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t l=
en,
> +			  int reserved)
> +{
> +	strbuf_grow(sb, len);

What is this `reserved` flag for, and when should one use it?
It would be nice to have a short comment...

BTW. was it meant to be aligned like this?

> +void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t l=
en,
> +			     int reserved)


--=20
Jakub Nar=EAbski
