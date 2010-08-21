From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 19:47:12 +0200
Message-ID: <AANLkTik+NBvdVkN-TvC_F5MWGZrtgEZMPOXr=Tsr1eA_@mail.gmail.com>
References: <20100821092616.5e57135b@hyperion.delvare>
	<20100821111555.11879d02@hyperion.delvare>
	<AANLkTi=JHzQm4hm-nuTyZq2CL_2z785KtMvVcmaqtgyF@mail.gmail.com>
	<201008211921.22495.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jean Delvare <khali@linux-fr.org>,
	Git mailing list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 19:47:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmsA3-0003uF-Ko
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 19:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab0HURrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Aug 2010 13:47:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37036 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0HURrN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Aug 2010 13:47:13 -0400
Received: by fxm13 with SMTP id 13so2327742fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v/jBWGPE2DlppkxSU/NJVAlgq5rqm53MNvsmGCMtOgw=;
        b=NmU2JZUX2KPOm+Zx78foyxQwnEXxg5l6YGbJMTyjPR4ZvjSiakyLIMX/6KhPxBz8lY
         kZvP1O0Ovih8OgnTwmO7JAMe+li+xisnsnWxLBaMaqCWDVL3SY1hrR3EV/7hbTljvDUn
         YokWu+TP3vyc9FgNUy3FxihRzFTw18SABBKFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r/xA+GWGUtLIrFNM7W1ffOocM2BehfGMj9t9Fecu8rYbkyxhj8rg6cP85FV8d1mlhv
         z/KNSoJebQ4Ar1mMqblkIWT18uwcDfuPdpJ52+C/PUcirtLUSBwDFtTAT9NC+pj3v9qO
         7+CZflMstb+3RKJps3JSx4hvLj8Q8dr/hw1oc=
Received: by 10.239.160.205 with SMTP id e13mr812hbd.201.1282412832133; Sat,
 21 Aug 2010 10:47:12 -0700 (PDT)
Received: by 10.239.180.20 with HTTP; Sat, 21 Aug 2010 10:47:12 -0700 (PDT)
In-Reply-To: <201008211921.22495.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154147>

On Sat, Aug 21, 2010 at 19:21, Jakub Narebski <jnareb@gmail.com> wrote:
> Lars Hjemli wrote:
>> <shameless plug>
>> With cgit, you can answer such questions by combining path limiting
>> and range queries, e.g.
>> http://hjemli.net/git/cgit/log/scan-tree.c?qt=3Drange&q=3Dv0.8.2..v0=
=2E8.3
>> shows all commits affecting scan-tree.c between v0.8.2 and v0.8.3.
>> Maybe gitweb could implement something similar?
>> </shameless plug>
>
> Gitweb also supports range limiting in log-like views from some time,
> but currently there is no UI for that, and you have to handcraft the =
URL,
> e.g.:
>
> =C2=A0http://gitweb.example.com/repo.git?a=3Dhistory;f=3Dfoo.c;hpb=3D=
v0.8.2;hb=3Dv0.8.3
>
> or (in the path_info form)
>
> =C2=A0 =C2=A0http://gitweb.example.com/repo.git/history/v0.8.2..v0.8.=
3:/foo.c

Nice, I didn't know gitweb supported this - maybe it's all Jean needs?

--=20
larsh
