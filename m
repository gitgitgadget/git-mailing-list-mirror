From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add case insensitive support in matching pathspec
Date: Sat, 5 Feb 2011 14:44:54 +0700
Message-ID: <AANLkTi=F3KYEJK6UuvUvqmwEx7kiyd_WP20rUvir2K=b@mail.gmail.com>
References: <1296751106-15316-1-git-send-email-pclouds@gmail.com> <7vwrlgzryj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 08:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plcpn-00044E-CH
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 08:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970Ab1BEHp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 02:45:26 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43012 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1BEHp0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Feb 2011 02:45:26 -0500
Received: by wwa36 with SMTP id 36so3147710wwa.1
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 23:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=cYSAHXrF0PYYvv0cE/p/ofvZGNubcijSAiddxTfoyTY=;
        b=haatTanVFUw8tQIuc2bYPWOE3/hQuvS6eQWPM8Mi027NELzkhpTuKTyezRfHwWjodN
         MNSZTGDIlzvOHMceqaWhvbGzhR7E0FM+mm1ef0tsSlXsE4MU1+DISQhVv0tD2dRj36vw
         y9SHEcP01u94IP5jaQlYA/IATIKNnI5los7Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VQX+qQSo/I37W1AYQZUvmQd3n8FgTf/NAojmZRdff7Tym5zM1Arl1aw6ZbFSVCFk1f
         6SXyUUZBFkstEabZ0q5La4XNP+vez8h9kdBARowj7bYK1IwXob3bROZLW6LjEEVAsRKt
         tM037ODFSNB31+l4k7NUK5qB3+3iTz08k26cI=
Received: by 10.216.186.144 with SMTP id w16mr12027037wem.13.1296891924524;
 Fri, 04 Feb 2011 23:45:24 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Fri, 4 Feb 2011 23:44:54 -0800 (PST)
In-Reply-To: <7vwrlgzryj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166079>

2011/2/4 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> =C2=A0On top of nd/struct-pathspec, but requires jj/icase-directory.=
 I can
>> =C2=A0rebase the series on top of master if it causes too many confl=
icts.
>
> I am in the middle of rewinding 'next' and have already rebased the t=
opic;
> I will queue the result in 'pu' so could you check the result when it=
 is
> pushed out later?

Checked. Looks good to me.
--=20
Duy
