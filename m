From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Thu, 18 Oct 2007 11:24:08 +1000
Message-ID: <ee77f5c20710171824o33ea13aqe6a6c8aa096f56c7@mail.gmail.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
	 <471302D2.6010405@trolltech.com>
	 <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
	 <200710150902.52653.johan@herland.net>
	 <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
	 <ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
	 <0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com>
	 <85ve98gl57.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0710171553580.26902@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0710180045160.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Geert Bosch" <bosch@adacore.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Ren? Scharfe" <rene.scharfe@lsrfire.ath.cx>,
	"Junio Hamano" <junkio@cox.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 03:24:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiK7b-0006Rs-Oo
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 03:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760804AbXJRBYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 21:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbXJRBYL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 21:24:11 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:23084 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758880AbXJRBYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 21:24:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so12773rvb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 18:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QhKs+2gObtmyRg/njvwI8DkRZrPaQ959byFr2YBp+EA=;
        b=TAcca4Hp0VLxKkCMMluuihLJeosSGQalDUiqqyBxvwizg8zOegmKJ7bgSPBXeab4w4bzfom2PTTfAw93MT+wrUkkXQKxoJ64GmwU99dPnI9M2I7wzXajbNFoDkx4oOFXPUAjbzkF4fMtZmFEq54wQxjVf2sfl9WPhrSS5gO+j64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bIQzatsXkmS5Qz9P8GFznty/fVl9yWYQB9OVNHhqap3y2o5l4oWCwH3PnSi6dcoFT+KPHMPvsrPtznpAPa2jP/bSAuRO1eFB3zeyNKDRZgcoPhbxYc857ZGtpME0nZi62J8s8JrHVFji1x/GOP7c/OHTgiI7Uf7tDMcuhaTawSk=
Received: by 10.141.178.5 with SMTP id f5mr4629075rvp.1192670649607;
        Wed, 17 Oct 2007 18:24:09 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Wed, 17 Oct 2007 18:24:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710180045160.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61449>

On 18/10/2007, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 17 Oct 2007, Linus Torvalds wrote:
>
> > Well, this has been debated to death, but I actually think that "skip"
> > is a good choice, exactly because it's an action.
>
> Could we, _please_, first decide if the implementation has merits, and
> just apply it as is in that case?  We can rename it whatever anybody likes
> later, and we can paint the bikeshed brown if you want to.

I figured with something like this, it'd be a lot easier to get the
colour right first, since command UI is harder to repaint if it gets
widely adopted. Anyway, I think the patch itself is a very good
feature.


Dave.
