From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] Documentation/Notes: Remove 'footnote:' warning
Date: Mon, 18 Jul 2011 11:12:11 +0530
Message-ID: <CAK9CXBVSq_j7naHzVLMj=bW8WMKq_WfkDQP4zspkK_QizC26=g@mail.gmail.com>
References: <1310855420-21183-1-git-send-email-pavan.sss1991@gmail.com>
 <1310908271.21563.17.camel@drew-northup.unet.maine.edu> <20110717215858.GA9906@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 07:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QigbG-0001il-QV
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 07:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab1GRFmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 01:42:33 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:46594 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab1GRFmd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 01:42:33 -0400
X-Greylist: delayed 57325 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jul 2011 01:42:32 EDT
Received: by eye22 with SMTP id 22so1082658eye.2
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 22:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fhS7w5OViT6eL+kkZ+xQNoVGoiFQ1VlnqCCs+OYjGjk=;
        b=ACccVvMiD371BTGlEr2ZMi/tGrYxHOLhh++LVZn/9sLF9Npz3fxOjzaeTYT9J99MnD
         rEZJlTTh9h1CiHUBktV8XVp5EtOSmwSoiDuaHl0m1jFH09ybR1wGv4fbPG27BAhpWeRk
         /mNscI4MivPL20gOvNXLW2xK5JkKLBtr8cY7s=
Received: by 10.14.9.30 with SMTP id 30mr2037301ees.135.1310967751744; Sun, 17
 Jul 2011 22:42:31 -0700 (PDT)
Received: by 10.14.53.70 with HTTP; Sun, 17 Jul 2011 22:42:11 -0700 (PDT)
In-Reply-To: <20110717215858.GA9906@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177338>

On Mon, Jul 18, 2011 at 3:28 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Drew Northup wrote:
>> On Sun, 2011-07-17 at 04:00 +0530, Pavan Kumar Sunkara wrote:
>
>>> Remove 'footnote:' from git-notes.txt which is responsible
>>> for the warnings surfacing during the generation of git
>>> documentation.
>>
>> What version of asciidoc are you using? Perhaps that works just fine
>> with newer versions?
>
> Good call. =A0This was fixed by Docbook XSL 1.76.0:
>
> =A0 =A0 =A0 =A0Norman Walsh: block.xsl; endnotes.xsl
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Fix bug where simpara in footnote didn=
't work.
>
> The symptoms are a warning and a little extra vertical space after th=
e
> numberal "1." in the output. =A0I don't know if it is worth working
> around or not.
>

So, using newest version will not give us a warning?


--=20
- Pavan Kumar Sunkara
