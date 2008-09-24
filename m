From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] kha/{safe,experimental} updated
Date: Wed, 24 Sep 2008 23:48:08 +0100
Message-ID: <b0943d9e0809241548t32e8ac24n3ec88698fb907764@mail.gmail.com>
References: <20080921153757.GA9098@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Daniel White" <daniel@whitehouse.id.au>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 00:49:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KidAi-0001pw-27
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbYIXWsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 18:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbYIXWsK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:48:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:43169 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbYIXWsJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Sep 2008 18:48:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so138535rvb.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=v1cevNnSU0PSrnMFh0Mp9UBmVPOIyxpKjP4YdZsGbgQ=;
        b=Le/HALyG6zKHUarljldh/YghD9YIIzpzEJa1Oa436RVzdoofkF0qIbS8R/K50qRxYy
         z3YMMqS8khN+jkslNvxuoPsdM3Ian13zvrOQIIKqJa/jVQYy/VhhHko8n1Iqnz+YS1cW
         sTZHIkYeniiC06cloPAr2pP5K5zC53ntiWBFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YEV2m4FrAQAZIteS83uq49aWMaoeG0UlMPe7dJ/h1xEGZyYrlSupnC76YxhWF43vFv
         E5VFQ3gUDNuoR0u+ml089zuuLXHrZA4iAyJ7fs1WjoH2M6gRXSzYK8juWGJZP+mRyxf3
         KZw5dtQXIjcxfkM//pwJTXcGFuXOBqzpLhxQs=
Received: by 10.141.197.14 with SMTP id z14mr3755402rvp.283.1222296488831;
        Wed, 24 Sep 2008 15:48:08 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Wed, 24 Sep 2008 15:48:08 -0700 (PDT)
In-Reply-To: <20080921153757.GA9098@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96706>

2008/9/21 Karl Hasselstr=F6m <kha@treskal.com>:
> Just pushed out the stack log stuff to kha/safe. It really should be
> ready for wider use at this point, and it was getting tiresome to kee=
p
> rebasing it.

Great work, I merged (most of) it. Many thanks.

> One patch is still in experimental -- it depends on a new git feature
> that isn't in any release yet.
[...]
>      Read several objects at once with git cat-file --batch

I skipped this one for now. I'm using Ubuntu (Hardy) and the git
version is 1.5.4.3. I would wait until we get at least a stable git
release with this feature.

I haven't looked in detail but can we have a way to drop back to the
old implementation if the option isn't available?

--=20
Catalin
