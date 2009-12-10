From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Fri, 11 Dec 2009 00:54:04 +0100
Message-ID: <fabb9a1e0912101554r5a8df316w19203894c9962c94@mail.gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> 
	<1260488743-25855-2-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:54:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsq5-00086n-5Y
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564AbZLJXyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757343AbZLJXyS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:54:18 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:33984 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287AbZLJXyR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 18:54:17 -0500
Received: by vws35 with SMTP id 35so96720vws.4
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 15:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XEtauFBa1Xb23ywXNuP2in9VjvwWPblthd0Bz9xo0Po=;
        b=XpYHUXvkBDmZZfNLYG+2jqmPnS47v0KvcXNhXDzLCSfy2D67ZpoLKhvCZuL0jnPLji
         cZcgBNbtEgA6ANqQEtsy8CaPYP6O0l99+lK6kuMvxGVd2j8fzcAWHEqzv9Kfv07OOaKd
         qY3jYsVtquWWlbRcJW7NxT2OeiccbEiqqfRPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bOMsVc9QjEDzqFMS39pBx2yCo1FL2OtdLgFVW3ya+gSL/kOU+ew/X8Rn1E6cdjANKk
         iNlhuMwMF7HceK1ERhkvdShzpR4OA1w2YAGMQtOrOwbYt3API15qqXTM6ELveE8XnzW9
         bm0ZaGl43ByY49f9GNRsO6fNvaLXHxO4C2ISI=
Received: by 10.220.65.200 with SMTP id k8mr69140vci.116.1260489264053; Thu, 
	10 Dec 2009 15:54:24 -0800 (PST)
In-Reply-To: <1260488743-25855-2-git-send-email-warthog9@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135058>

Heya,

On Fri, Dec 11, 2009 at 00:45, John 'Warthog9' Hawley
<warthog9@kernel.org> wrote:
> =A0gitweb/gitweb.perl | =A0 24 ++++++++++++++++++++++++
> =A01 files changed, 24 insertions(+), 0 deletions(-)
>
>

Also, what happened to including patches inline for ease of review?

--=20
Cheers,

Sverre Rabbelier
