From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import.c: Silence build warning
Date: Mon, 31 Aug 2009 23:42:14 +0200
Message-ID: <fabb9a1e0908311442q2a56b1cft8ad7fe75bfde38c3@mail.gmail.com>
References: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com> 
	<fabb9a1e0908310529q4c601a73t671cc2813dfdb1a3@mail.gmail.com> 
	<81b0412b0908311427t5b4a24ffg1d7d272669476117@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Wookey <michaelwookey@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 23:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiEeD-0007c0-KK
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 23:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbZHaVmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 17:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbZHaVmg
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 17:42:36 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:43281 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbZHaVmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 17:42:35 -0400
Received: by ewy2 with SMTP id 2so714602ewy.17
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fqEklM7PGPUaBeNvRsRD7NAbkJIFjso0kEiQN/l5b2Y=;
        b=Zed5YPtabZOLji6qXSQsSFdz34b/Ry8qk5vWxuYDFtGRYTpH7XamYxYw2ZQWHRGBBZ
         uKhtWo3ONtOjfDePQZlIpG66vvNdcd49wfJvhkZryK8hkTOoRsLLrl42S+6VsE/7eoJ2
         7ssfVDwm0OkD5m5GDgQGqZoW7Jg4/4TiDLGSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KICIyTNcETQJoAwZnivxH2cVHjw3Jp+Tj6w8dGZESwnJRy6dZjy9AUcUGhst7ClQE7
         iMwidFWn3k9flNXcX7tYfZ/09LSWwZ0YZSbcGBgyDqlLrbjegC5k152525yK7XLy5b5w
         1O9CpRMF4YlYPBgRz4aokYTWfDomhnWGJvrBk=
Received: by 10.216.20.67 with SMTP id o45mr1351758weo.106.1251754954088; Mon, 
	31 Aug 2009 14:42:34 -0700 (PDT)
In-Reply-To: <81b0412b0908311427t5b4a24ffg1d7d272669476117@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127502>

Heya,

On Mon, Aug 31, 2009 at 23:27, Alex Riesen<raa.lkml@gmail.com> wrote:
> Why? It is endp (end of the parsed number) we're interested in.

Ah, my bad, I hadn't checked stroul's signature, sorry for the noise.

-- 
Cheers,

Sverre Rabbelier
