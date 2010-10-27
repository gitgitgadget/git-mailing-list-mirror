From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 27 Oct 2010 13:12:01 -0200
Message-ID: <AANLkTimX2NhXGdK0vVMaw-Fm6fpg4i5pbOZGA8Cc-+ui@mail.gmail.com>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
	<20100830023812.GA4010@burratino>
	<20100830024020.GB4010@burratino>
	<AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
	<7v1v9e803a.fsf@alter.siamese.dyndns.org>
	<AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
	<20100902043500.GF29713@burratino>
	<7vvd6o14zz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 17:12:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7fe-0002X5-CE
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab0J0PMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 11:12:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59584 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0J0PMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 11:12:03 -0400
Received: by bwz11 with SMTP id 11so670026bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=izac/NGjbBHZ2kymNMZdgvbh9+RG/h3jz2Zho5wD5S8=;
        b=qkOcNnIvatb8NfYjf0sxiZ3wNdeFIwHxuc0uJBXdCTt+C0ekTzrFX1bfOXwprB5uHf
         2JeBfe7zy8VAjZ7x3fvNPnTduwXrAy9x2Y7Xd3nXuI5/SSIrSqJNDmKiWIdvheDS2Nw2
         68oZzEPdD1eheaGgazjag9LEPCIOOi1gkVnXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VD3R/ypQH/z+Ja+KgWw46Vrkq7a3GdII/xQA/NO5JNmwkmnMnLIKmJ8IuO3auy+Lll
         b2iZV/RjtQVM63y4oYYs6BXnJTGmf5QiPogz9ojWAatHI3JSxjyVQpxmIwDVyP7OrRjs
         ICkZQ0cP7EasbfJYWurSKnvrAavQRl3JEcb1U=
Received: by 10.204.102.2 with SMTP id e2mr7268064bko.112.1288192321999; Wed,
 27 Oct 2010 08:12:01 -0700 (PDT)
Received: by 10.204.69.206 with HTTP; Wed, 27 Oct 2010 08:12:01 -0700 (PDT)
In-Reply-To: <7vvd6o14zz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160085>

What happened to this patch? I can't see it on any branch (master, pu, maint).
