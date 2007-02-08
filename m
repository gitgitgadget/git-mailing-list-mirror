From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 19:12:56 +0000
Message-ID: <200702081913.09952.andyparkins@gmail.com>
References: <200702072138.36787.andyparkins@gmail.com> <200702081020.44202.andyparkins@gmail.com> <e5bfff550702081106u1e02f371g3a91c7462ff5e442@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 20:16:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFEkg-0007tx-QC
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423256AbXBHTQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423257AbXBHTQI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:16:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:4112 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423256AbXBHTQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:16:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so552172uga
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 11:16:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JCAkzuZ7owidTAzc8FWXSVzZM4WQUn9ap/HTgVn1PxFnEW2dpkPiMGH91GKdGF/LkHTAK63HU9Fiyu0G8AUuUwypHVAwboDFK0ycKgvOZ+mUzY2dCdhumftS5Zqf0xH9BSBNbiXNsew7l6Y+iarXXaGdInUPORynuC7BMknaslg=
Received: by 10.67.20.3 with SMTP id x3mr10572453ugi.1170962165910;
        Thu, 08 Feb 2007 11:16:05 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id o30sm3637918ugd.2007.02.08.11.16.01;
        Thu, 08 Feb 2007 11:16:01 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550702081106u1e02f371g3a91c7462ff5e442@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39074>

On Thursday 2007, February 08 19:06, Marco Costalba wrote:

> I have applied and pushed all your patches. BTW you are referring to
> qgit4 at Pasky http://repo.or.cz/ site, not the stable qgit in
> kernel.org repo!

My apologies - that was the first one I found when I typed qgit4 
repository.

> Hint: Regarding application 'fixed width' font please refer to
> TYPE_WRITER_FONT variable defined in common.h in your new patch, 
> this is where user choosen font is stored.

Excellent; I'll use that then.  More patches coming soon.  I hope the 
git list is the right place for these patches.

> P.S: Yes, I have noted this Qt::convertFromPlainText() misbehaviour,
> but I don't know if are the spaces that are not escaped correctly by
> the function or the QTextEdit rendering engine that eats the
> (escaped) spaces anyway.

I definitely think this is a bug in Qt; QTextBrowser will show the 
spaces in HTML mode if <pre> is used, so I don't think it's a fault in 
QTextBrowser.

> P.P.S: Give a try to Bitstream Vera Sans Mono as fixed width font,
> it's muuuuuch better then Monospace IMHO ;-)

No need to persuade me; that's what I already use.  Monospace isn't a 
font on most systems - it's an alias to the default monospaced font - 
and for me it's aliased to Bitstream Mono :-)

It seems to be done by the following in /etc/fonts/

    <alias>
        <family>Bitstream Vera Sans Mono</family>
        <family>DejaVu Sans Mono</family>
        <family>Courier</family>
        <family>Courier New</family>
        <family>Andale Mono</family>
        <family>Luxi Mono</family>
        <family>Cumberland AMT</family>
        <family>Nimbus Mono L</family>
        <family>NSimSun</family>
        <family>FreeMono</family>
        <default><family>monospace</family></default>
    </alias>

In case that helps you.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
