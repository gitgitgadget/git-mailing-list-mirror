From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of commit 
	header in $GIT_EDITOR
Date: Sun, 11 Jul 2010 00:35:04 +0800
Message-ID: <AANLkTima-RPBCtoxo8ybli4mBCR12qIjbmBmTQd80B46@mail.gmail.com>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
	<1278764821-32647-2-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sat Jul 10 18:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXd1J-00044t-8R
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 18:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab0GJQfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 12:35:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60811 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab0GJQfI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 12:35:08 -0400
Received: by wwb24 with SMTP id 24so5887672wwb.1
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RMvq/TmCOx9yoCYIM257sDhjVbRrTV2Va7/D4Kyz49c=;
        b=ksEhXC07YM3BpRQb1InWCEHroI0mD7HrtSxX6diEg3yKp8btTgzsXIQf251snIOT+A
         9bVpsJA0rdr+Fw16VJF7v5WQqJdM68Nt+e4lj51Q/aR0kyx7Kvpp+lk/nTfTE25R0t6S
         UfY2xQwCSOc0yLCQ36d9nyS9CkJ4y7f3/XDOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t+XMccIbtpOh5iRHPsYazoog3+3AzkJOSuiufpyE/rFQqrG6dekZ/mV9XI9FyZ+xT9
         2mJviM5h/oTJ8qV+BoW7zrPnC6AAe4U0G3XPr5i8tHoaL20RtijcV7utp/Ho6by3kxix
         5ebAEiT0fiu4weVomQOgFacnZkEl01yqNpGbc=
Received: by 10.216.231.26 with SMTP id k26mr1362553weq.3.1278779705170; Sat, 
	10 Jul 2010 09:35:05 -0700 (PDT)
Received: by 10.216.163.142 with HTTP; Sat, 10 Jul 2010 09:35:04 -0700 (PDT)
In-Reply-To: <1278764821-32647-2-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150725>

On Sat, Jul 10, 2010 at 8:27 PM, Nazri Ramliy <ayiehere@gmail.com> wrot=
e:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "p=
ick $shortsha1 $rest" >> "$TODO"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git log=
 -1 --abbrev-commit --abbrev=3D7 --format=3D"pick %h %s" $sha1 > "$TODO=
"
[snip]
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 echo "pick $shortsha1 $rest" >> "$TODO"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 git log -1 --abbrev-commit --abbrev=3D7 --format=3D"pick %h %s=
" $sha1 > "$TODO"

Notice the change from ">>" to ">"? I'm stupid :)

Please drop this patch. I'll resend the corrected one.

nazri.
