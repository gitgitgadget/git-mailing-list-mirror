From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Wed, 22 Apr 2009 13:04:42 +0200
Message-ID: <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
	 <20090422082652.GA32698@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@poxbox.com, git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 13:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwaHz-0005Cc-Et
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 13:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbZDVLEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 07:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbZDVLEo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 07:04:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:53977 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbZDVLEn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 07:04:43 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1937048ywb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JzQUDigk9HcF8cj+pYmm+MZX/fkubEQEZk3rjK9VPLI=;
        b=JldBxvyHyyf8Kx9WrixENCGuq5tj5uem4joPnKW9GWhx4qk7F9odHcdptMfB6gfrzN
         wU7gOHhYcl5qWWd5DxXWIHiPri2IfW5ovCWT+TOLeZ6fp5B/ETJZYsQvaYU0gcyxycjL
         XkzfohUEAORJu9XHx1G4fxGQey1xZYkBYPsd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SHMxvfPp4qqLvo8REZC8OJtNXV4lPDfRC0EEGOnv6IPMpqPRlNcbxWeM857VV8tncF
         E3atV7HCP7a0w7EoFdFs4OlqvjqxXDM+ub8Y4riRdrTk7gLB6LGlGyjunnHM6nai4CPR
         rpitCiDGc4Aive30KVKJ/erfiHAodaGTjxBuQ=
Received: by 10.150.139.15 with SMTP id m15mr12598589ybd.22.1240398282692; 
	Wed, 22 Apr 2009 04:04:42 -0700 (PDT)
In-Reply-To: <20090422082652.GA32698@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117190>

2009/4/22 David Aguilar <davvid@gmail.com>:
> On =C2=A00, Alex Riesen <raa.lkml@gmail.com> wrote:

I wasn't born on 0th.

>
> For whatever it's worth,
>
> Acked-by: David Aguilar <davvid@gmail.com>

Yes, FWIW. I intentionally stopped signing off patches for
Windows, ActiveState Perl and Cygwin: they usually harm the
rest of the world, while just allowing Windows users limp along.
