From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] clone: disconnect transport after fetching
Date: Wed, 2 Sep 2009 09:09:19 +0200
Message-ID: <fabb9a1e0909020009r3ee28b1fo3cba095abafec9d4@mail.gmail.com>
References: <alpine.LNX.2.00.0909020159080.28290@iabervon.org> 
	<20090902063647.GA29559@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 09:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mik5B-000306-Ud
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 09:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755AbZIBHQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 03:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbZIBHQT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 03:16:19 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:59918 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbZIBHQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 03:16:17 -0400
Received: by ewy2 with SMTP id 2so514919ewy.17
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 00:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=zySrW1EuT3phl0T29QFWEZXIk5cJkTTd2SJCujV6bSc=;
        b=wM3CsxxX5QJdy2aH3Kd/6sXr9LebPVVwgdzH8ccAHJIkTZxoYqHWKsUtR5fWx4qOLc
         Jf79ZcC1+0zB6lf85jazJOdvau+Uc6R2U+NOHLyslLSnQAQJms7RA2tTgR1l8F5KX7Qz
         Qthr1nWijI8Dh86MGYeoYoN8aTLs1vC2knh68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sR1Hh5r3F3ZJ6XKEJrrTfkQy79Gu2/UBNzKyANI/wjI5CCWs8WPfxTOKdOwl5g5OrU
         Q9Zb7mYockNIwgpoSoAWBJLXfOYkdYGInn+CUeAmrTPu71DiiUS2zFcQ+1uvzdZhsenP
         0MJ6gZw1HpI3jJ52UOCg8Zn/Yyp3tM2CLOmCM=
Received: by 10.216.54.83 with SMTP id h61mr75633wec.69.1251875379353; Wed, 02 
	Sep 2009 00:09:39 -0700 (PDT)
In-Reply-To: <20090902063647.GA29559@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127589>

Heya,

On Wed, Sep 2, 2009 at 08:36, Jeff King<peff@peff.net> wrote:
> As you can see from the commit message, I did a little extra hunting to
> make sure we are not going to impact any other code paths, and I am
> pretty sure we are fine.

Thank you for fixing my mistake :).

-- 
Cheers,

Sverre Rabbelier
