From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 0/5] *** SUBJECT HERE ***
Date: Mon, 13 Oct 2008 13:42:22 +0200
Message-ID: <cb7bb73a0810130442v2d3f6c86h99ef9a9d3205a65b@mail.gmail.com>
References: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810131300.35309.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 13:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpLpn-0005aC-UN
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 13:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbYJMLmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 07:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbYJMLmY
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 07:42:24 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58007 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822AbYJMLmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 07:42:23 -0400
Received: by gxk9 with SMTP id 9so3432702gxk.13
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5vyYV6pXub88lNP/z5qJgZPu+yeFkDFjVNvotBy0hUg=;
        b=d3nqW/Nu/3Je1eyNikmF8uyKWNbL19vuDqDYZ9zWpxUR4E2bj7odfluWK2uKVOj6bZ
         ZupraNvPSG9iQS42WMiJ3lR4jd9QV0aaP1KC59pDIS66LnxK9VisIACRpfBxnWh+V28d
         f/5Zg/GSIr8Ppdn3L/WaVfkG+V8whqtAQxo7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ggkMKreN2POyBTWTCXCMdIJ2fp0vp//qBkJw9DKp41aSh4N4H0o5VVT2GHKngokTXL
         ORHLBKPb3OWCZ8VEsF5Cd+YbTgZWb39LoEJ/1CehmpCHiBGA11ZQUW7AyiXB9lRlR5Lg
         h3xDwIfmxMkm+a6YzQK+zG/Sp88JMwg0QOXyw=
Received: by 10.150.12.3 with SMTP id 3mr7990685ybl.18.1223898142474;
        Mon, 13 Oct 2008 04:42:22 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Mon, 13 Oct 2008 04:42:22 -0700 (PDT)
In-Reply-To: <200810131300.35309.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98110>

On Mon, Oct 13, 2008 at 1:00 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Err... "*** SUBJECT HERE ***"? Not that it matters...

Yeah, I realized that as soon as I sent the thing 8-(

> I like it, and with the exception of the last patch (which looks like
> it doesn't check if $file_name contains '..', even as it checks if
> $file_parent contains '..', and which probably should not esc_url)

Oopsie. I'll get to fix that.

-- 
Giuseppe "Oblomov" Bilotta
