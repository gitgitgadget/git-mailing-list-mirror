From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Gitweb: ignore build file
Date: Sun, 25 Apr 2010 22:19:04 +0200
Message-ID: <m2jfabb9a1e1004251319y180319b1nabe7de8765fc9668@mail.gmail.com>
References: <1272226625-22628-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>,
	Mark Rada <marada@uwaterloo.com>,
	Git List <git@vger.kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 25 22:19:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O68Id-0003uU-PC
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 22:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab0DYUT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 16:19:27 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:52643 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0DYUT0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 16:19:26 -0400
Received: by bwz19 with SMTP id 19so71255bwz.21
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=I2CFYTz0eM3EjcpaipdeMvhnv4YNwMhq7q1aeVklCqw=;
        b=Z6jHjesRfFQTI+pcTLOWWcj6pK61/vBnWzHtcH3ySXoj1la69X5bd38ihX2ykmVChd
         TFxm30Z2u6AcxqKQtMAPr2cXL6BuxF/cZDMLkAeQkQWSX+SZ3FgdfWrdlSFELjbpEdpU
         8jnm/+f/O5r409vvG+fQrstndQfmxTBOLPqpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=Bf21AKkVGQ/etqic3/eB9JfJv35iMQRtoCpwAVIleHobLMt4tiiurSqKJXHkXYsi5D
         Qn4u8Zq7BIUCfX7+wecvYhDfuYuQ0fJ+SSMaA3XCyX612iGomlqT/e6HYmRf/20/Qnk1
         KmEZuGKN1bw+q6701x/9LK7LxBtK967wbl2CA=
Received: by 10.103.37.28 with SMTP id p28mr1672253muj.86.1272226764144; Sun, 
	25 Apr 2010 13:19:24 -0700 (PDT)
Received: by 10.103.168.14 with HTTP; Sun, 25 Apr 2010 13:19:04 -0700 (PDT)
In-Reply-To: <1272226625-22628-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145765>

Heya

[fixed typo in address of Mark, sorry for the spam to everybody else,
please reply to this mail, or add the 'm' to uwaterloo.co in the
previous one]

On Sun, Apr 25, 2010 at 22:17, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
> =C2=A0Seems like this was forgotten in 8de096b6
> =C2=A0("gitweb: simplify gitweb.min.* generation and clean-up rules",=
 Thu Apr 15)
>
> =C2=A0.gitignore | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 83dd1e8..14e2b6b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -156,6 +156,7 @@
> =C2=A0/git-write-tree
> =C2=A0/git-core-*/?*
> =C2=A0/gitk-git/gitk-wish
> +/gitweb/GITWEB-BUILD-OPTIONS
> =C2=A0/gitweb/gitweb.cgi
> =C2=A0/gitweb/gitweb.min.*
> =C2=A0/test-chmtime
> --
> 1.7.1.6.ga2e26




--=20
Cheers,

Sverre Rabbelier
