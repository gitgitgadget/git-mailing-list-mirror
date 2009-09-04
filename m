From: "armencho@gmail.com" <armencho@gmail.com>
Subject: Re: .git and retrieving full source tree for own project(s)
Date: Fri, 4 Sep 2009 22:18:48 +0200
Message-ID: <981b72360909041318m686beea8x11f3076c74c2ee15@mail.gmail.com>
References: <981b72360909041252i29551a5chb8b3a2a5c6444ee3@mail.gmail.com> 
	<7viqfyfpdc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 22:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjfOy-0006SX-02
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 22:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934055AbZIDUTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 16:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934061AbZIDUTP
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 16:19:15 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:58318 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934074AbZIDUTL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 16:19:11 -0400
Received: by ewy2 with SMTP id 2so747800ewy.17
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3IZ1QlJoqgfalUTnzgw6UaJY0o0tX8oYdwPz8SmnOXY=;
        b=C3AKMRL/48xU4p5SZhl6bT/m7Iid3Rp0ew1woh8W8/Q0mBKptqqh2BuRiP2GQiwUcj
         j7Ph3TY5eJOYpOTR2vFhSyzAopc0jwuu2syBErZJ2mbwUFv04wqLUf1hzMQf3EBdSKdw
         kDTSqGRwa+nNoPkuJ6wuYccsTqhu4dFiABoew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H5SkLzbw5oKnsQhu2HjSsH4tddgEcSUr6oLfESJYzksEsxvfcCLYa03ymIZXalJ+jQ
         +sdhNlr0Fw/xC0ibcr+yrFjk0vsYBqZ1KgLj8h5a+jhWgsVH/8/49iDrT/sY/99obevx
         24K5Wx5gMDiELywSXSOLGUSlYf3ywLHwCnxjg=
Received: by 10.216.7.67 with SMTP id 45mr914614weo.95.1252095548260; Fri, 04 
	Sep 2009 13:19:08 -0700 (PDT)
In-Reply-To: <7viqfyfpdc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127767>

On Fri, Sep 4, 2009 at 22:04, Junio C Hamano<gitster@pobox.com> wrote:
> In this case, your "delete everything" is your local change, and git =
did
> its best to preserve it while switching branches.
>
> If you want to "copy this and that files and directories out of the
> commit at the tip of the current branch and deposit them in my work t=
ree
> and index", you would say
>
> =C2=A0 =C2=A0$ git checkout HEAD this that
>
> so a request for checking everything out would be a natural extension=
 of
> the above that would be:
>
> =C2=A0 =C2=A0$ git checkout HEAD .
>
> If you want to "copy this and that files and directories out of the i=
ndex
> and deposit them in my work tree", you would say
>
> =C2=A0 =C2=A0$ git checkout this that
>
>

This makes sense now. I have tested this and it all functions as you
said. Thanks for your help!
