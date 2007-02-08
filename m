From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 20:06:51 +0100
Message-ID: <e5bfff550702081106u1e02f371g3a91c7462ff5e442@mail.gmail.com>
References: <200702072138.36787.andyparkins@gmail.com>
	 <e5bfff550702080039l236b1f69o6765b8e2dff3e3c4@mail.gmail.com>
	 <200702081020.44202.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 20:06:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFEbg-0003Pi-Me
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423252AbXBHTGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423250AbXBHTGx
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:06:53 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:50788 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423254AbXBHTGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:06:52 -0500
Received: by wx-out-0506.google.com with SMTP id h31so574436wxd
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 11:06:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/onqXSC+zrj94Pt/vzSmcLAz7M37wd+ETmaOoAxiJUQK20VE5bE62skmIC5rwNYjUMzLv7Y7OcmFeoX4y4bIzBLT4bjtphNGI9B4OaDqyz+tg0LM6oFe2X+r+hWGy+eipMPgWoWpBVVDLUVnIVZGSqn9P68Z+ZGPXyAK4wk4Fw=
Received: by 10.114.169.2 with SMTP id r2mr4697351wae.1170961611165;
        Thu, 08 Feb 2007 11:06:51 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Thu, 8 Feb 2007 11:06:51 -0800 (PST)
In-Reply-To: <200702081020.44202.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39072>

On 2/8/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Thursday 2007 February 08 08:39, Marco Costalba wrote:
>
> > Regarding "Monospace" it should be changeable with Settings menu and
> > should apply _only_ to fixed space font viewers, in our case only
> > patch viewer and file content viewer.
>
> The log message was the one I changed.  Having the log message in variable
> width breaks any ascii-art in the message.
>
> I completely agree about pulling the setting from the config.  I'll see if I
> can find that and post a further patch.
>
> > If you see Monospace applied to list view or any other widget apart
> > from the above mentioned ones then it's a bug.
>
> True.  I used "Monospaced" as the font as that defaults to the system-wide
> monospaced font; however it's pretty poor form.  I raise my hand - shoot
> me :-)  As I say, I'll try and do better and send a new patch.
>
>

I have applied and pushed all your patches. BTW you are referring to
qgit4 at Pasky http://repo.or.cz/ site, not the stable qgit in
kernel.org repo!

I didn't got it unti I tried to apply the patches :-)

Hint: Regarding application 'fixed width' font please refer to
TYPE_WRITER_FONT variable defined in common.h in your new patch,  this
is where user choosen font is stored.

Not-fixed-width font is set with qtconfig tool.

Marco

P.S: Yes, I have noted this Qt::convertFromPlainText() misbehaviour,
but I don't know if are the spaces that are not escaped correctly by
the function or the QTextEdit rendering engine that eats the (escaped)
spaces anyway.

P.P.S: Give a try to Bitstream Vera Sans Mono as fixed width font,
it's muuuuuch better then Monospace IMHO ;-)
