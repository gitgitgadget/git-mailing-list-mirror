From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 4 Mar 2011 11:19:06 +0700
Message-ID: <AANLkTikaD5oxx2bwx0R3x_1p1KnfBFqJJ2xtNiWW4-SC@mail.gmail.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com> <4D700469.7090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 05:19:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvMUQ-0007qB-L2
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 05:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621Ab1CDETi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 23:19:38 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40565 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758523Ab1CDETh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 23:19:37 -0500
Received: by wyg36 with SMTP id 36so1754743wyg.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 20:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=A8xl9EEEAZQ0yWWvxCb1vMoXugyqyJOjz/5ruka2XO0=;
        b=f1arzdV1ZTEkFElDCNpTCPBCXhLeeJ5z3owGnutqbqd4q5EgjQ7i64Lc8WKTe9kZ5V
         4hYpypPUBh4J83DUSSCr59EjLkPmje+48fglQsrnWUBTAcayZPwe13XmI2QQLzfcchbS
         KDCgyHlvyINEZ4yI1OkmRNLkXVh2ps3QMWwF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SZav2UnKZe5+A5pt4xD7himmxv2g5B4/Vndck7t5niShQnyeegrlfibrS/ngFEV31e
         SqmemV1umujnBaRR4VTuXW/DgJeOIx411jHAnSJ5VQuzdz/rF+3Lo1wNZeOzxGWvV22i
         ncRuWqv0AWdyAO1bumjc0u6C0jcZSAcG+ARqo=
Received: by 10.216.136.91 with SMTP id v69mr172079wei.16.1299212376250; Thu,
 03 Mar 2011 20:19:36 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Thu, 3 Mar 2011 20:19:06 -0800 (PST)
In-Reply-To: <4D700469.7090807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168425>

2011/3/4 Piotr Krukowiecki <piotr.krukowiecki@gmail.com>:
>> =C2=A0This makes '.git symbolic link' (what's its official name?) mo=
re
>> =C2=A0convenient to use. Previously whenever I need to create a .git=
 link,
>> =C2=A0I need to open docs to see its format. Now all I need to do is
>
> Took me a while to find documentation for .git file format. Probably =
my
> fault, missed the gitrepository-layout link.

Exactly why I wrote this patch. I do remember there is a prefix before
the path, but what is it? gitdir: or git-dir: or dir:? No I don't want
to look at the document every time I need to create a link. Trial and
error is not preferred either. Also manual manipulation on repos
should be avoided if possible.
--=20
Duy
