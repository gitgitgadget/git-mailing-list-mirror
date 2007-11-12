From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/5] A few small fixes
Date: Mon, 12 Nov 2007 11:02:54 +0000
Message-ID: <b0943d9e0711120302y385676a9o2d5ad50ee3ae2333@mail.gmail.com>
References: <20071111193545.18868.62490.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:03:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrX4R-0005P8-Nr
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 12:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474AbXKLLC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 06:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757255AbXKLLC4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 06:02:56 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:37895 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbXKLLCz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 06:02:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1139382rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 03:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gSUWnczYBT07TxAeOEmUHFQeiuHOEyq+FRckTyc4oyQ=;
        b=h8x5k6op9ksbduX5KmdDS0D6Kn/Mb5Q7uGT7pUPOG4dEa9iqtpvhndL+XTGFPaNEfGyXMP5N7R60kPugnj5fmYeM7Yf81ykSn8eyCwYvb7kIHQfj6jzRVUB9IWl/Q3IFhjaMePakAypA2e7Y5fLDVTo+Q3osXQEMHP7jmTX5ncw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=etAtXXxuKSQ9wSDCfcEC7lpNa7ovdhnFEn8P8OzmOprD+mqL2vP1fytQ4exwM4MIRzJ23NBjAEkAFXzf3S9DJ4f3eXrVIJt2KVYdonk+1KKsX8o8W1ZM8B9kk3GqmkeACafZrPcnvkDnhHJIka42mUtKOLdcDEmseN4OWzV7E70=
Received: by 10.141.37.8 with SMTP id p8mr2302876rvj.1194865374493;
        Mon, 12 Nov 2007 03:02:54 -0800 (PST)
Received: by 10.141.170.11 with HTTP; Mon, 12 Nov 2007 03:02:54 -0800 (PST)
In-Reply-To: <20071111193545.18868.62490.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64599>

On 11/11/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> These are available from
>
>   git://repo.or.cz/stgit/kha.git safe

Thanks. Merged.

>       Let some commands work with detached HEAD
[...]
>  stgit/commands/add.py         |    2

My plan after 0.14 is to remove the implementation of add/rm etc.
commands. I'd like to keep them as just synonyms to the equivalent git
commands which stgit would invoke (this is mainly for convenience as I
usually type "stg" rather than "git").

BTW, I'll review this week the bugs already logged and clean as many
as possible (help appreciated :-)) and try to release 0.14 in 1-2
weeks.

--=20
Catalin
