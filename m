From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
	case
Date: Fri, 4 Sep 2009 19:14:53 +0200
Message-ID: <fabb9a1e0909041014h3b2789d7i90115ac69368d442@mail.gmail.com>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org> 
	<fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com> 
	<alpine.LNX.2.00.0909041114440.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 19:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjcNh-0007l2-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 19:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933748AbZIDRPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 13:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933715AbZIDRPO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 13:15:14 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:42721 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933599AbZIDRPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 13:15:12 -0400
Received: by ewy2 with SMTP id 2so618723ewy.17
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=3hz6RETcJ16qU3fxBzJ2wh7n4816xuJmi5zfuJZxmVo=;
        b=usOL2TL7pCiWmIDVvuinYLCra4G9BiCGnrNLEbMh2oGCjZtNYF178TGn632ribakf0
         W08PwyumwtuvU9PVje0W5r9Mo86/ewNVpnSEa2lpyO05DgQcabKIsM/BWEuwRIvRxtyL
         l+aUYGJt0ddti+eoALjkXAICBWe4MBqhUgjGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=V6BRnBHGj/0yJbBxruIlc51n43R6/wk/xYUj/ISyRjvoahFN9BTcc/0BtwD0UP3gbc
         UMbLFX/Izs1byNTAUlEeoDDBlNsN0D75o10t6dDguEbQK25IwbhV5Kq5++A1o/M9u93P
         Qe/Hv+NdtlPQKLgWomYMk0bQB/CWizjyGjAG8=
Received: by 10.216.45.78 with SMTP id o56mr2203501web.152.1252084513096; Fri, 
	04 Sep 2009 10:15:13 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0909041114440.28290@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127749>

Heya,

On Fri, Sep 4, 2009 at 17:40, Daniel Barkalow<barkalow@iabervon.org> wrote:
> As of this version, the idea is that there will be three ways helpers get
> selected:

How does this interact with wanting to support
"hg://example.org/example" by adding 'git-remote-hg' to you path? Does
it make that harder, or is it just not part of this series? I really
do think we should support that, and only resort to "svn::" or such if
the url is ambiguous (e.g., with a 'https://' prefix, etc).

-- 
Cheers,

Sverre Rabbelier
