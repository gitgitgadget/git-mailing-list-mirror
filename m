From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Permissions of objects within shared repo
Date: Fri, 1 May 2009 10:15:22 -0500
Message-ID: <799406d60905010815h634638f6hf5aa0f149f627607@mail.gmail.com>
References: <799406d60904301849t1e77e81bgc6d58ecd0e9d6b7d@mail.gmail.com> 
	<alpine.DEB.1.00.0905011500530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 01 17:16:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzuSu-0001Au-Tq
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 17:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349AbZEAPPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 11:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbZEAPPo
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 11:15:44 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:40693 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbZEAPPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 11:15:43 -0400
Received: by qyk34 with SMTP id 34so3445101qyk.33
        for <git@vger.kernel.org>; Fri, 01 May 2009 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=6+erYu3QgVlwacTzLsp/2D/2n9z8xyL87JKHEHiC+Yc=;
        b=b9RalQClRKvYkDe+J7UyaojYCXS+36ZsI5GK29Gkcp/OQSDcG4/hGRFB+0awyIdvL/
         HxGSkADZZksFlvyJu2V7dhk9tDyeCoMQVSiqgeXgIgH8z1Tb+a0F0troiEnZajKpTrqr
         FCo5ubjc+IdvMLjpmttTjPDkIYBgfgaegISfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=GnaM+4z66kr8U/Ej6ryn3HhC9jdQt7NGaWIR/TYZcxOazURLBCxQnaxmGxl5wA6VzR
         2FkGVwQJrhNc2oOdJhgPSuVHcecuE/I/CxYz22vRPZO33nww4E+OUaJHQyLqjhZ5m6gw
         /JBTQlbzSe1pCYjSzGAUGeOW516OVUBk8Ai2U=
Received: by 10.229.84.213 with SMTP id k21mr2121915qcl.19.1241190942104; Fri, 
	01 May 2009 08:15:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905011500530.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118081>

On Fri, May 1, 2009 at 08:01, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Objects are immutable. =A0So they do not need to be writable at all.

On Fri, May 1, 2009 at 08:58, Brandon Casey <casey@nrlssc.navy.mil> wro=
te:

> On POSIX filesystems it's the _directory_ permissions which control w=
hether
> or not the directory contents can be deleted.
>
> Do:
>
>   ls -ld /path/to/repo.git/objects/00/
>
> and you should see that the group has write permission to this direct=
ory
> which will allow group members to delete files residing in the direct=
ory.

Of course, thanks! Sorry for the noise.

Cheers

Adam
