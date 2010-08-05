From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC] struct *_struct
Date: Thu, 5 Aug 2010 11:20:14 -0500
Message-ID: <AANLkTin_6gaYF++N2GBgDsedfo7mY7yG5H99=-DxCa5E@mail.gmail.com>
References: <20100804150843.GA2762@localhost.localdomain> <7vaap2fafm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 18:21:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh3Bh-0005YE-MC
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760158Ab0HEQUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:20:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39025 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707Ab0HEQUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:20:45 -0400
Received: by eya25 with SMTP id 25so2443904eya.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=s693Wjjra/cO7PxAEpNHFdN98VqAPzkdAaUji928Zfk=;
        b=oHjzMs0khW5aLF7YYTq+UHN5bwXdlWnuELOGW/rKZF6fUa/3er85EoNJzJfDoa0w0a
         0AX1SsQBLLIHN93d5Mop73Uyjpkhib1HkI5HI109vaDH5Cz4/CWISUONaVEes+X7XbUW
         YS26Ml418yuZGaBNH8NmpXV8qb8NVVhC0qrsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=b26hvLRfr+QCgqkDiS0VW2VTWqp77e2DnWOctEzZuTOnRG3wXANwGKBZKGj3ADMtVs
         bSic38HQwVMTZnYgYexV8aqqIHW3W7jEJnv/YV2kdkhkie9OP+4q+2ffrznL5eE4ueQg
         h9mKlcrldjdsLU1rwrzhPUphA4uXPa2vcjm4I=
Received: by 10.239.189.18 with SMTP id r18mr359678hbh.178.1281025244196; Thu, 
	05 Aug 2010 09:20:44 -0700 (PDT)
Received: by 10.239.157.68 with HTTP; Thu, 5 Aug 2010 09:20:14 -0700 (PDT)
In-Reply-To: <7vaap2fafm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152684>

On Wed, Aug 4, 2010 at 14:24, Junio C Hamano <gitster@pobox.com> wrote:
> I hate... "typedef foo struct foo"

How come?
