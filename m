From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] bash: not all 'git bisect' subcommands make sense
 when not bisecting
Date: Mon, 11 Oct 2010 00:14:55 +0200
Message-ID: <AANLkTikvSxcjgqmenFDsRuPxcgAse-tJij8R98Wof=JZ@mail.gmail.com>
References: <1286746774-7877-1-git-send-email-szeder@ira.uka.de>
 <1286746774-7877-2-git-send-email-szeder@ira.uka.de> <AANLkTi==oCKgw86fy6sPiPuKuownsbob3xXiY=hHhYrQ@mail.gmail.com>
 <20101010221232.GD12529@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Oct 11 00:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P54Au-0000nb-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 00:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab0JJWPR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 18:15:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51895 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0JJWPQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 18:15:16 -0400
Received: by yxm8 with SMTP id 8so8116yxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=o3gx3ONjY5NQOBq4Lvfy+DGUgfRIHwKM2wd46NiDQHY=;
        b=l6n7pgd0tNgQnBbc4YVaXsbAijkF3bxHtPhDtK2gzoiNJa0ARDSX0mmrRI/2PuxFBn
         S+WkqePaUcfjDbuDxfZAt0SrZy6H9nVkTiKi3GTXNAd2M5VydxDCQ1/pa2XkzNXNk8wA
         CjVPxJw9oqJXsbNkKNT0dKE/Wd7rSHw8iqyu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Vl4mJrWnblK6BVC4EY2SfyvRRYYfPmOpxwnpjRhuRM8kzK653Hn56DejE9MdQHaT64
         57gLMqEHcK2efFBQKhKKHJEqyzpbPNvGG5gakDqk/e5O5TEOzvPqtI34zf7DApXW2GUO
         hs8JMHMbfjOSrxoOPyychm9+4fQABIqmknr60=
Received: by 10.150.201.18 with SMTP id y18mr5732791ybf.329.1286748915131;
 Sun, 10 Oct 2010 15:15:15 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Sun, 10 Oct 2010 15:14:55 -0700 (PDT)
In-Reply-To: <20101010221232.GD12529@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158725>

Heya,

2010/10/11 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> Actually, my patch follows the same concept of 'git rebase', because
> that's exactly what the completion function for 'git rebase' does: it
> doesn't offer '--continue' (nor '--abort' and '--skip') if you're not
> rebasing.

Had you only mentioned that in the commit message... ;).

In that case, sounds good!

--=20
Cheers,

Sverre Rabbelier
