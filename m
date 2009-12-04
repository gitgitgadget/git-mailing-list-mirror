From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH v2 6/8] Remove special casing of http, https and ftp
Date: Fri, 4 Dec 2009 17:05:41 +0100
Message-ID: <fabb9a1e0912040805w609bbf15p1e514716edaba9c0@mail.gmail.com>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<1259942168-24869-9-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 04 17:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGafX-00084B-8Z
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 17:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756913AbZLDQF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 11:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756898AbZLDQFz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 11:05:55 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:37097 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897AbZLDQFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 11:05:55 -0500
Received: by vws35 with SMTP id 35so1126045vws.4
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 08:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=yk2of3XaMLXEft2GLwQkcF9Tde6NktQ1KEa4+VDLKK0=;
        b=SNn1Ae9TLWCaXfNDSbSpanPNzrcS4EA+tUTCPN+FiLhazWse0/TGSMGGDDgzd6ejMC
         dCZN8PJRlsbPb5i/tKUiAb0x8O618CjSkQgCkwjcnp/1LgrSMnC9ES92f5l9Ap3VDoCG
         m7f4id4T3SQbq5RWvY4RMH48J5meqrihXSQEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hGhK6o/jpX1u7b8RJKXtfAQfPt3606nkhQALCmdoJJFVHQE1g5b2UMKUCyHylMEkAv
         E0OsxdZKYT8w8L/VyMki0KBP7b+8cMJAkHdxrxCc9VhyEB/hMY8pUQyW9xojekzLbi/t
         WOYeWCCuQsoRhACy+/SMTVWT4QEmPhjZgUUEY=
Received: by 10.220.122.90 with SMTP id k26mr4160274vcr.69.1259942761089; Fri, 
	04 Dec 2009 08:06:01 -0800 (PST)
In-Reply-To: <1259942168-24869-9-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134532>

Heya,

On Fri, Dec 4, 2009 at 16:56, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> HTTP, HTTPS and FTP are no longer special to transport code. Also
> add support for FTPS (curl supports it so it is easy).

As I said earlier, I like this idea, again, without having looked at
the patch itself so I cannot comment on the implementation :).

-- 
Cheers,

Sverre Rabbelier
