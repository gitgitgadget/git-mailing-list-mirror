From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 19:59:32 +0200
Message-ID: <BANLkTikZGX4A66r6ubUF6P60JNu_BMgMyw@mail.gmail.com>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com> <m3y61cdzmi.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:59:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUN2t-0000ie-9H
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab1FHR7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 13:59:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46287 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab1FHR7x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 13:59:53 -0400
Received: by pzk9 with SMTP id 9so359843pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=n/8/W0yU55ORslcpmcdnSMdH/+Og1hluIQkleuDoPaM=;
        b=rL7I8V7Gwb/f3b+eOJJLVTm5e/q/1Sc1CBNIYZvbgoN5SXSEBJ6H9hyBHh4tUIc1AH
         9w64vUyqc6xQzTfMoq3ChFBkvlum25fRwuMWZoGpv4ddbkiX17qyV1W9LYbiFW76hBRP
         GtbhlmQyCSW5K/miOB4LP9VQS554vpZz22sQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P3FAFYEXsrFYceXyhQWxgEODwiYLUmvVlXOghN+R1pn20JZI05bASr6EARoxpMKWVO
         vYBqQtWCxS/yMDr8UoMC6y+PylaiqgIcwj6DdK7kNbvV70ysQ3NHulMBZN3VL9wnexxp
         uIqKBgkiohRY2s2slZWAe7AY7F1tPtXZwuMCw=
Received: by 10.142.187.6 with SMTP id k6mr322298wff.300.1307555992147; Wed,
 08 Jun 2011 10:59:52 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Wed, 8 Jun 2011 10:59:32 -0700 (PDT)
In-Reply-To: <m3y61cdzmi.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175414>

2011/6/8 Jakub Narebski <jnareb@gmail.com>:

> =A0http://stackoverflow.com/questions/6162484/why-does-modern-perl-av=
oid-utf-8-by-default
>
> especially accepted answer.

Thanks for the link, do have some interesting things in here.

> =A0use encoding ':utf8';
>
> or
>
> =A0use encoding 'utf8';

That did it while keeping the use strict; intact.
Thanks a lot

--=20
J=E9r=E9mie Nikaes
