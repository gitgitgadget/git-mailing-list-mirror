From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/Notes: Remove 'footnote:' warning
Date: Sun, 17 Jul 2011 16:58:58 -0500
Message-ID: <20110717215858.GA9906@elie>
References: <1310855420-21183-1-git-send-email-pavan.sss1991@gmail.com>
 <1310908271.21563.17.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Jul 17 23:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiZMo-0004RO-H1
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 23:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab1GQV7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 17:59:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44237 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab1GQV7H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 17:59:07 -0400
Received: by iwn6 with SMTP id 6so2597841iwn.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=grhwxaMGlO2bOG0Aa1Hj3K+VQvtS99HCU1Jj0wmZutc=;
        b=d0wJThONMeXZgyFB4aTnXq5u/83/7mgR5gY9NBF8f5SdHTkNxjweGTWcXbjrqY78pI
         gRhNXxmnXoqcYmOeX6B6sY4exPPXuEh8V24HXxYTcIyZb1XNxfjhz70Jm4dUEjSzs2+W
         r4fW0ubEI1hUNnEe9bAY8MwReOY1eCbZA/nF8=
Received: by 10.42.117.200 with SMTP id u8mr6602054icq.470.1310939946725;
        Sun, 17 Jul 2011 14:59:06 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id s2sm4128424icw.17.2011.07.17.14.59.05
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 14:59:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310908271.21563.17.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177318>

Hi,

Drew Northup wrote:
> On Sun, 2011-07-17 at 04:00 +0530, Pavan Kumar Sunkara wrote:

>> Remove 'footnote:' from git-notes.txt which is responsible
>> for the warnings surfacing during the generation of git
>> documentation.
>
> What version of asciidoc are you using? Perhaps that works just fine
> with newer versions?

Good call.  This was fixed by Docbook XSL 1.76.0:

	Norman Walsh: block.xsl; endnotes.xsl

		Fix bug where simpara in footnote didn't work.

The symptoms are a warning and a little extra vertical space after the
numberal "1." in the output.  I don't know if it is worth working
around or not.
