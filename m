From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 10/12] gitweb: git_repo_url() routine
Date: Mon, 27 Sep 2010 09:29:36 +0200
Message-ID: <AANLkTi=N-TRCHFRo5G8oXUDoe3H_Xv+BTpvc9PwjM6Pu@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1285344167-8518-11-git-send-email-giuseppe.bilotta@gmail.com> <201009270034.29603.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:30:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P089x-0007ZP-Tj
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775Ab0I0H35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 03:29:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50496 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758845Ab0I0H35 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 03:29:57 -0400
Received: by iwn5 with SMTP id 5so4554303iwn.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dDmluRkn7MvZWZD5A566OCO1dUhDv1sHOakIzlzRje0=;
        b=AOIiaROu2R5XyzugV3x/ybMjuKggkAIRZh7EyBzzSbhNXgGqUUXxYeOAPtFN8v5dlC
         k0lPCVGN6TF6rmIUmF2a/RFpfF4MuNiT+K2BzwA4ZFZOoevVaeWnaKOybRmeYNBMx4fM
         nKcty/3eqd/2k3sHiAv7ATMh3bdhh6Lgina+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ekNZnmsl7ylGwfMz1Z301OTWuRaJC+qihxKxsKJq/MI3pPTRzr9ZYPnOFX/bWj6Hos
         SbLcSvYNJp2Q6j6r69bGEKwCyWaFNBNNareD/51g08Q38Fi6zs9rc40WRgnb9wZ9nMBk
         2ZMP/01OQNY4QhEFMH88k7UkcmLJXXJNQDPfw=
Received: by 10.231.36.134 with SMTP id t6mr8332171ibd.128.1285572596205; Mon,
 27 Sep 2010 00:29:56 -0700 (PDT)
Received: by 10.231.166.145 with HTTP; Mon, 27 Sep 2010 00:29:36 -0700 (PDT)
In-Reply-To: <201009270034.29603.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157313>

2010/9/27 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>
>> The routine creates a table row with a name and a repository address=
,
>> like the one used at the top of summary view.
> [...]
>
>> +sub git_repo_url {
>> + =A0 =A0 my ($name, $url) =3D @_;
>> + =A0 =A0 return "<tr class=3D\"metadata_url\"><td>$name</td><td>$ur=
l</td></tr>\n";
>> +}
>
> It should be =A0*format_repo_url*, and not git_repo_url, isn't it?

Right.

> By the way, doesn't gitweb include code dealing with repository URL;
> why you don't _use_ this subroutine, then?

The only code for the display of a repo URL is inlined into summary
view, which in the next patch uses this function to do the display. I
can probably squash them together.

--=20
Giuseppe "Oblomov" Bilotta
