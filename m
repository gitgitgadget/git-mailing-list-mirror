From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Mon, 7 Jun 2010 21:55:32 +0200
Message-ID: <0F5B86DB-7E9E-4770-AF6F-244A0FC9168A@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost> <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com> <20100522222746.GA2694@localhost> <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com> <20100523115127.GA20443@localhost> <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com> <20100524094905.GA10811@localhost> <986EE696-5997-40AD-929C-D82D40D7242E@gmail.com> <20100524221128.GA29588@localhost> <246B0C3F-EBD3-41EC-B0FD-300BD1DBF43E@gmail.com> <4BFB89D4.5070308@youngman.org.uk>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anthony Youngman <anthony@youngman.org.uk>
X-From: git-owner@vger.kernel.org Mon Jun 07 21:55:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLiQE-0003s7-VB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 21:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279Ab0FGTzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 15:55:36 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:60814 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab0FGTzf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 15:55:35 -0400
Received: by ewy23 with SMTP id 23so62798ewy.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=CQvAmL0Vh721Qd5B8D1eC/KkFEVYWA0RJthj92y/QCQ=;
        b=jP3iH/0NhLQLeJtTtZ7vMTHHsicN5NnvGfqBWybEQ5dawmsDX8e1cL67eht/BKIgh4
         ABt94cU/cWHCbcxwCYd+LxrFc3BMyEbxULsLFwdjQnaVjsaXS45mFyoQGiyyHD54jwc7
         8uZt+lAIqAaAoFEnRqPmwmr0qrlORlZteFUxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=HZwSWgQwN3Nf959pwZ+ImaxxdkfRZA1iRq5ETWvl6w4zteJdCBPB+D93FHAj+w2S//
         wy5EBfPbiDqhRza6jPQncJk4uXViThWm/C0POZIuBxDfydDmepGEatNtASz1lNeKNvrp
         OvGsrp4WAbsohtwo+rxOlNNivcgJmI2rNQocY=
Received: by 10.213.22.201 with SMTP id o9mr1130501ebb.89.1275940534042;
        Mon, 07 Jun 2010 12:55:34 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm2887980ewy.14.2010.06.07.12.55.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 12:55:33 -0700 (PDT)
In-Reply-To: <4BFB89D4.5070308@youngman.org.uk>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148622>

Hi,

I'm sorry I've taken so long to respond.

On 25. mai 2010, at 10.27, Anthony Youngman wrote:

> Just a suggestion ...
> For core.autocrlf (or somewhere else more appropriate) could we add to
> false and true the option "force"?
> 
> Bearing in mind "force" is always considered "a bit dangerous", that
> merely means "I don't care if it has crlf in the repository, change all
> commits to lf" (and checkouts to crlf if appropriate).
> 
> Yep, things are likely to break, but I'm thinking this is the sort of
> situation where a lead dev could say to themselves "I know what I'm
> doing, we need to clean up, and if I set that as my options, then I know
> I can fix any resulting mess".

If I understand you correctly, putting "* text=auto" in .gitattributes would do what you want, with the added benefit that you document the decision to normalize inside the repository.  If you don't think that's a benefit, you can put "* text=auto" in .git/info/attributes for the same normalizing effect.
-- 
Eyvind
