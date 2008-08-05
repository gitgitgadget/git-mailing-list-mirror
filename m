From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Do not insert an empty line before the diffstat info
Date: Tue, 5 Aug 2008 22:09:19 +0100
Message-ID: <b0943d9e0808051409x1c9a9be3x68973c9ba5bdecc0@mail.gmail.com>
References: <20080731125010.894.84022.stgit@dawn.rfc1149.net>
	 <20080804142000.GC12232@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Samuel Tardieu" <sam@rfc1149.net>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 23:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQTnU-0007yF-6E
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 23:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764029AbYHEVJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 17:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763921AbYHEVJV
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 17:09:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:34321 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763721AbYHEVJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 17:09:20 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1898001waf.23
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TmLLQi1VyhktL5dioWswXtf40XvMyvjH7qmTup64JD0=;
        b=uGU76RxBeFVdFn/Gt7UrXQVHag4Q9j6fvdxficesvxmfAoH/qUg9G/y+4+qrDaFvjg
         BG8SEV3T/HSXypYvYE4Brt7kXnaCGYei4GIHD8iSHThcQCCueli4ESrPw59m3PAI52F8
         UIULwm1fhiGBbB2iXW1aj02OnFrYitkFfLjGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I0F2w6gnqht9J+EA+LnGp3xhGWJa8UwDdSkEfjLzclswSaLe5CBqIxH75U7w7DEEt6
         efqNAvGDQsfz1M9Y0WSBsMaXGSDYicplRLXqa+1DRV3utZtd3XWnS3uu0WX14fEj/4S0
         xvMTJq+rxA4t8pfuL31TSNEucQilgXfnc7xo0=
Received: by 10.114.191.12 with SMTP id o12mr198596waf.224.1217970559992;
        Tue, 05 Aug 2008 14:09:19 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Tue, 5 Aug 2008 14:09:19 -0700 (PDT)
In-Reply-To: <20080804142000.GC12232@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91463>

2008/8/4 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-31 14:50:10 +0200, Samuel Tardieu wrote:
>
>> To make the format of stg output closer to the plain git one, do not
>> insert an empty line between the "---" separator and the diffstat
>> information.
>
> Thanks, will apply. (IMO it's slightly uglier, but it's better to be
> consistent. And it does save some space.)

Without this change, I could easily spot people posting patches with
StGIT rather than Git :-). Anyway, I'm OK with this patch as well.
Thanks.

--=20
Catalin
