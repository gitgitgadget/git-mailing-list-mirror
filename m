From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: test for --replace-all with one argument and fix 
	documentation.
Date: Tue, 17 Mar 2009 12:41:29 +0200
Message-ID: <94a0d4530903170341g27f215d4t8c3ad25e7f362590@mail.gmail.com>
References: <1237283197.10001.9.camel@equipo-loli>
	 <alpine.DEB.1.00.0903171123530.6393@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos Rica <jasampler@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWlC-0004Pi-JM
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760042AbZCQKld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 06:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759005AbZCQKld
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:41:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:8504 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988AbZCQKlc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 06:41:32 -0400
Received: by fg-out-1718.google.com with SMTP id 16so79254fgg.17
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pubhrkPkZOw26rJy9BQXV9kkkLiJDCqI9oY7nAHijyA=;
        b=YmvqF6Kw6sN66N07CRcCrBhh41VN2QnVgEOQKoNu4qcoMKbf/wxlMvOrjWgTA+NxFd
         qW0hqkDTNHEPTR1WRDezBlXYv2UOY62F9bKcdnwhmy+k2gpczo0g5sD8N4l0lMKrxyDe
         iils9qD9I+h7IKoQ4ScF/8R+5/nPXnEh9bBII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FQca3TJuQ5LfUGQxcK1Cg638eupOk1FqX6Q2aVE2lGnPkHhf7f3rQ4e1Wf8CDc8jg5
         RYZ5EPhtSc4CIoHBDKzearIRj5mZU5g+riZtME0PniRbvSSDUfbeTEcy06yWmuXzmgD3
         gzJ+vocE1SZw7Z8mI5GhrpESire5fszA/viKQ=
Received: by 10.86.77.5 with SMTP id z5mr3333355fga.34.1237286489947; Tue, 17 
	Mar 2009 03:41:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903171123530.6393@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113456>

On Tue, Mar 17, 2009 at 12:24 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 17 Mar 2009, Carlos Rica wrote:
>
>> Option --replace-all only allows at least two arguments, so
>> documentation was needing to be updated accordingly. A test showing
>> that the command fails with only one parameter is also provided.
>>
>> Signed-off-by: Carlos Rica <jasampler@gmail.com>
>
> Looks obviously correct to me. =C2=A0I am actually unsure if I can AC=
K this
> patch, as most of builtin-config.c does not look all that familiar to=
 me
> anymore ;-)

Hehe... interesting, my first possibility of ack'ing :D (I guess)

Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

--=20
=46elipe Contreras
