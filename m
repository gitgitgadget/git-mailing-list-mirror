From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 15:08:50 +0200
Message-ID: <AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 15:08:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz81I-0007f6-LF
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 15:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab0IXNIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 09:08:52 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51324 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab0IXNIv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 09:08:51 -0400
Received: by qyk33 with SMTP id 33so3974707qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=vl0AtFpr1jyHBhl4T1nWfRkhANnoCbRmd3MRzJd3Ph0=;
        b=Wh7olfPKh6dxgPBUTtTgkxBEzCFQNYPAWaiXMio40atkYH8UksX2FFFEeiRmx4v5IS
         AyCn0RfmeEWI+DKCKGAN8TYgoOqSleMaWEa+c4xUZadW5+SypjOSMRUn9rUBAflv8E6G
         KgacFy7IVr4nard1F9Cx3zhUWHsmAxBCsXBFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=jsbeQNzO5NCPpiWxbzoCYIxgg7yg8ZKULhj6aZJo+G4rXACrU77l7BNRyaI2j5kNMA
         ht1IjUr9tLbtmAL9BK5qqWlFcrUfOCQtt/LWANX46RMY7z7AD2pNActT6C8hgKnRel5A
         whoHjKIaclLSTecl0O+uujD4lHcasn1DMoc2Q=
Received: by 10.224.54.134 with SMTP id q6mr2386315qag.349.1285333730363; Fri,
 24 Sep 2010 06:08:50 -0700 (PDT)
Received: by 10.229.62.98 with HTTP; Fri, 24 Sep 2010 06:08:50 -0700 (PDT)
In-Reply-To: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
X-Google-Sender-Auth: 9u4zb3XjVpShdLNS0U1aTw5_TTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156985>

On Fri, Sep 24, 2010 at 14:56, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gm=
ail.com> wrote:

> However, I'd like to shift the discussion a bit: Do we want to suppor=
t
> the 5.6 line *at all* anymore? I don't think so. As you point out
> yourself you can just compile 5.8 or later on these machines.

5.8 as minimum is probably for the best. It's not that just you can
compile a newer version (5.8), more importantly, Perl 5.8 is available
as a package from those semi-official 3party repositories for most
systems (at least the *nix systems I have access to), except for those
like Irix 6.2 where it's hopeless anyway (perl 5.0). But I only have
access to irix/aix/solaris/tru64 in addition to Linux.

-Tor
