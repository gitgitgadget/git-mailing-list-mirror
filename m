From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv3 1/2] Add a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 9 Jun 2011 16:03:10 +0200
Message-ID: <BANLkTikp6bGwVZqq7XAZ1bKVaMVLJ9XQiw@mail.gmail.com>
References: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?Q?Sylvain_Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 16:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUfq1-0006Sm-1y
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 16:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab1FIODw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 10:03:52 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42829 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757650Ab1FIODv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 10:03:51 -0400
Received: by qyg14 with SMTP id 14so841239qyg.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=I0ungtybDKlxQRiZbdl5/RnspKGKxNaN6sgimy81QfM=;
        b=hWdw4wi5TOMpzeaK4qnD0aDFvKhSudj+UGgFuPA+8JGz87R/ukj6VxRJjIiVnBX28x
         ZoA7UZRIJ/fjWtHRMBGRsDycsvqomV/mXDWV2H22WCwRUPAz1y3dzsEpmiVwFQfGJi1B
         j10asCfVNz0EmwCYtSiQHibxdnTcQoRcs+Z84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sygZ5eKrJom/UigdfeBxStKNu05oKnGgvhkCo5jxnUzuC4jF2Fm39EH0Ruvpsa+6Xg
         muLwBLYTRvQJL95dMSZPf8OEFmpyHIgdvXI7HKoddsZXxzGCG8z+w2FReuiEzHg312pH
         Nzbt981YX3cp9Z8f9GGPYBwLmExg2Wk7loyc4=
Received: by 10.229.135.12 with SMTP id l12mr609526qct.53.1307628230138; Thu,
 09 Jun 2011 07:03:50 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 07:03:10 -0700 (PDT)
In-Reply-To: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175526>

Heya,

On Thu, Jun 9, 2011 at 15:15, Jeremie Nikaes
<jeremie.nikaes@ensimag.imag.fr> wrote:
> +sub mw_capabilities {
> + =C2=A0 =C2=A0 =C2=A0 print STDOUT "push\n";

> +sub mw_push {
> + =C2=A0 =C2=A0 =C2=A0 print STDERR "Push not yet implemented\n";
> +}

If it's not supported then you shouldn't advertise it above. Is there
any particular reason you implemented it this way? E.g., did you
encounter a breakage in remote-helpers if push is not implemented?

--=20
Cheers,

Sverre Rabbelier
