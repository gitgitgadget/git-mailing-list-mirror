From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] gitk: Changes in Spanish translation after review by Wincent Colaiuta
Date: Mon, 24 Mar 2008 22:00:04 +0100
Message-ID: <1b46aba20803241400h643d4b56jd49835dc4f9cbc05@mail.gmail.com>
References: <1206316703-15481-1-git-send-email-sgala@apache.org>
	 <1206376672-7194-1-git-send-email-sgala@apache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Santiago Gala" <sgala@apache.org>,
	"Wincent Colaiuta" <win@wincent.com>
To: sgala@marlow.memojo.com
X-From: git-owner@vger.kernel.org Mon Mar 24 22:01:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdtmj-0004p3-VB
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 22:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbYCXVAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbYCXVAG
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 17:00:06 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:30609 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbYCXVAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 17:00:05 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1561416rvb.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gTfy0uAQRgxw+Ywxu6duBfzWTheUwg7JCl4muT2Vw6g=;
        b=uG5/h6PFZJp/VvT1uAa7cbw58/581OLQc82YB4TQvMQ29yst3Sn/VNX5dASBQaRQVIvtH00EnWug+8aUatZ0bZ7urz48S58RbH+SWdWvVdNdfJ1T0LCanIyDSMBYaUN6MMH5IpBm3Xn03HTszdnCQr3AqyToAAzaOIEsHHlTirM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=db3EoYpGG9kgVU+ry9Do+Lnp8HFf46MZSPM35q7iLfmqM4cw/vyuGLe87lpm2P704gPcESqnii11N8yqaRaRpkh1gitlgIVAJpfrj0p1UIx93nnkX3HCAZleLE6yvfeztSwCK5Pard7c3zjvgXGTa5FXYg2rj+Rk5vgQDEX5qbM=
Received: by 10.141.29.14 with SMTP id g14mr2597559rvj.241.1206392404084;
        Mon, 24 Mar 2008 14:00:04 -0700 (PDT)
Received: by 10.141.115.5 with HTTP; Mon, 24 Mar 2008 14:00:04 -0700 (PDT)
In-Reply-To: <1206376672-7194-1-git-send-email-sgala@apache.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78098>

Hi Santiago, this is my list of the missing things:

2008/3/24  <sgala@marlow.memojo.com>:
>   #: gitk:800 gitk:1778 gitk:1783 gitk:2431
>   msgid "touching paths:"
>  -msgstr "que modifican path:"
>  +msgstr "que modifica path:"

Also, this should be "ruta" instead of "path".

Below, you also wrote the message:
"Limita las diferencias a los path seleccionados",
that it will be better written as
"Limita las diferencias a las rutas seleccionadas".

>  @@ -244,7 +244,7 @@ msgstr "Activar esta rama"

I also think that this should be better "Cambiar a esta rama"
instead, a more intuitive translation for "Check out this branch".

>   #: gitk:1364
>   msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
>  -msgstr "<Shift-Up>\tBusca hacia atr=E1s (ariba, revisiones siguient=
es)"
>  +msgstr "<Shift-Up>\tBuscar hacia atr=E1s (ariba, revisiones siguien=
tes)"

Here you forgot to change also "ariba" with "arriba" (RR).

>   #: gitk:1374
>   msgid "/\t\tMove to next find hit, or redo find"
>  -msgstr "/\t\tBusca siguiente, o vuelve a buscar"
>  +msgstr "/\t\tBuscar siguiente, o volver a buscar"

This is mine: I think here you can write something more
to the point to avoid repetition, just something like
"...o volver a empezar" or "...o reiniciar la b=FAsqueda".

How about translating "To" with "Para" instead of "A"?

The option who says "Invertido" translating "Reverse",
used in the context menu option "Make patch",
should be better "Invertir".

You also forgot changing "Limita" writing "Limitar" instead.

>   #: gitk:8569
>   #, tcl-format
>   msgid "Cannot find the git directory \"%s\"."
>  -msgstr "No encuentro el directorio git \"%s\"."
>  +msgstr "No hay el directorio git \"%s\"."

Here you better can write "No existe el directorio" o
"No hay directorio" instead of "No hay el directorio".

Another important thing could be translating
the <keys> in the key bindings, that is, Replacing
<Return> with <Intro>, <Left> with <Izquierda>,
<PageUp> with <P=E1gArriba>, <Shift> with <May=FAs>,
<Delete> with <Suprimir> and so on...

I only reviewed about those issues referenced by Wincent,
but if nobody complains, I think that with those changes
this new translation is in shape to be committed.

Gracias! :)

--
Carlos
