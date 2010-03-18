From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 09:26:07 -0500
Message-ID: <b4087cc51003180726s4d5c679egf76f5179383459c5@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <9e4733911003180648w74f48194w1d75b0d58a309f1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 15:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsH2o-0003qY-2G
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 15:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab0CROtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 10:49:47 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:41448 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab0CROtq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 10:49:46 -0400
Received: by yxe12 with SMTP id 12so99737yxe.33
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=foQodn0DWog5aBSxO3sF9klL9orkEAmxHR0wol7emtM=;
        b=YL50I7HaeEERnilmWU1gaDOBcIr4QqWGfauuM3vAMe/1GzbZNeJueDb1L/kSxOoQDA
         oAuk46i5Bs1UTIbRY+oegjrbRnbFeypenng5/ziTBLFO2LpguQJ9wKx4wM0wwBKrzCAg
         8cdCxj4lJbFIFjpJr0cf7a5wN8V3pYgwdla1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=otazRZBSrvnPtPNYsRuYRq6MrO8nN8tnh1zs6r19tQtQDHOPJBujQEZQJ/cLAGMpbE
         blFvKM+efSNZHcPPMB294+CnuSGWAdPsToCIz5oobWOEZQJxChEOkByPeRsTGLgAvJyY
         iZ1FQlpLMRt4o5azwUismvI1JcRQpi7DV2n+8=
Received: by 10.239.190.65 with SMTP id w1mr1492072hbh.126.1268922387176; Thu, 
	18 Mar 2010 07:26:27 -0700 (PDT)
In-Reply-To: <9e4733911003180648w74f48194w1d75b0d58a309f1e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142473>

On Thu, Mar 18, 2010 at 08:48, Jon Smirl <jonsmirl@gmail.com> wrote:
> You can't go back and edit the history in git so a map of the aliases
> is needed. =C2=A0The easy fix is a .mailmap file. However, the .mailm=
ap
> entries need a mechanism to track which entries are correct and which
> have been fixed. Read this long and painful thread...
> http://lkml.org/lkml/2008/7/28/134

The addition of a uuid would not only likely decrease future trouble
tremendously, but also allow for a much more efficient remapping of
old (name,email) pairs.
