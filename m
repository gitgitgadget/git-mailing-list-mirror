From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Check autoconf version (ASCIIDOC8)
Date: Tue, 11 Dec 2007 09:34:28 +0100
Message-ID: <200712110934.29746.jnareb@gmail.com>
References: <1197205059-16742-1-git-send-email-jnareb@gmail.com> <7vhciqhqnd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 09:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J20Zz-0003Gs-2n
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 09:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbXLKIem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 03:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbXLKIem
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 03:34:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:41052 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbXLKIel (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 03:34:41 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1222675nfb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 00:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=idUK7B2LIm3UswoRN4TypgiA11B5rv+R/yocNi4+18g=;
        b=djW8Pels28sDhn0uxv2x+KQckevLVx4qwiJA8xQQnfY2WUFkB6E6Z/IgedCfEinVYGxNGb3wG49Q+2ACdYikcvc/Ng9d6p+FvoaqH5PlXSwAdNrzP8m+8LiYhE9+G9egoOSwJozNniVSDISeoJPYHtWnFXC2kXg+84rFmA8/51s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TiSUKy1BQfFQ6vRWkgAn5tQX6evzgdEhQOKMJ9MhRz6MYvK994/ux0VAorh88FTuzmTw4IjvhbJZAgRG+5Vzculi8Bimx71ukhVXHdOM+7hJ+lU0RHuxq9leZpDdM43VzDv8C2rvrvw7T/Sanfu56EKKfxwXFZ/ODyBW5IZjFJc=
Received: by 10.86.33.10 with SMTP id g10mr6478728fgg.1197362079892;
        Tue, 11 Dec 2007 00:34:39 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.16])
        by mx.google.com with ESMTPS id 4sm2888822fgg.2007.12.11.00.34.37
        (version=SSLv3 cipher=OTHER);
        Tue, 11 Dec 2007 00:34:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vhciqhqnd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67825>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Subject: Re: [PATCH] autoconf: Check autoconf version (ASCIIDOC8)
> 
> That's "Check asciidoc version".

Yep. Sorry for mistake (autoconf <-> asciidoc).

> > Check for asciidoc, and if it exists check asciidoc version, setting
> > ASCIIDOC8 when needed.  Currently it just runs asciidoc in asciidoc7
> > compatibility mode (see: Documentation/Makefile).
> >
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > diff --git a/config.mak.in b/config.mak.in
> > index 7d5df9b..759470a 100644
> > --- a/config.mak.in
> > +++ b/config.mak.in
> > @@ -7,6 +7,7 @@ AR = @AR@
> >  TAR = @TAR@
> >  #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
> >  TCLTK_PATH = @TCLTK_PATH@
> > +ASCIIDOC=@ASCIIDOC@
> 
> And this is "ASCIIDOC8=@ASCIIDOC8@", I think.

Nope. ASCIIDOC8=@ASCIIDOC8@ is in chunk below, this is for [future]
detecting asciidoc binary (so you can drop this chunk).

-- 
Jakub Narebski
Poland
