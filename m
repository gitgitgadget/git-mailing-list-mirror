From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: use "git sequencer--helper --reset-hard"
Date: Sun, 2 Aug 2009 21:58:22 -0700
Message-ID: <fabb9a1e0908022158g2578071ewd44bc8d730fb2b8b@mail.gmail.com>
References: <20090803024023.3794.6487.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 06:58:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXpdL-0000Zk-J9
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 06:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbZHCE6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 00:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbZHCE6n
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 00:58:43 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:64651 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZHCE6m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 00:58:42 -0400
Received: by ewy10 with SMTP id 10so2766116ewy.37
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 21:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SL25lOFPZxamFPMd/jBywlZC2oPX4Nj9DO2H7dquQ/8=;
        b=GppVFNbGReczZOgecEzCIMIMBIFXRqMOn92SOaaVLIDebuE3/+yIFLVI/8VvjHa8LE
         cpX5VduJlxP1OUXT09BSF62stef/nWk0xe1Di/z7xvN38JVw8+UPnn53XX56P7tkrApj
         lO674BNr7dpFTeTlZdiVGupY7w7me2xsIsss4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J1YJGAn/NnDF/JUbKzF/32cw4pwGPD2Lwr7QU+Fe/Jhy89gE+Z/znHc9iYFV2CdE49
         OWvCZzHvaZ6OrWW8Ih2c9Wug6zB944mZ8Chx5R3bTu/Kgz/kBRnrG1XnzJlCcOYKBzoJ
         xBOa66z6kJdnczrl1sYQBteOVoiA57skwH6Mc=
Received: by 10.216.90.74 with SMTP id d52mr1079931wef.51.1249275522105; Sun, 
	02 Aug 2009 21:58:42 -0700 (PDT)
In-Reply-To: <20090803024023.3794.6487.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124686>

Heya,

On Sun, Aug 2, 2009 at 19:40, Christian Couder<chriscool@tuxfamily.org> wrote:
> instead of "git reset --hard"

Hmmm, why though? The commit message (either this one or those earlier
in the series) don't really explain. What are the advantages of using
this new 'git reset --hard' alternative?

-- 
Cheers,

Sverre Rabbelier
