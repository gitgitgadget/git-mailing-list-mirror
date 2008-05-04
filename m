From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: convert "glossary" and "core-tutorial" to man pages
Date: Sun, 4 May 2008 13:13:01 +0200
Message-ID: <200805041313.03499.jnareb@gmail.com>
References: <20080504122157.ca98c75d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 04 13:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JscAL-00083C-9o
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 13:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbYEDLNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbYEDLNL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 07:13:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:33849 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbYEDLNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 07:13:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1566349fgg.17
        for <git@vger.kernel.org>; Sun, 04 May 2008 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Ckyr2BHWob/8W/APgRBP1fq5seAUBihdOYC1AKpitaM=;
        b=GS//ODht2PZ8SmroRJF0Maj5qPgr4lP1+Gt+P/1KH9blPRAzvNW8deGJUIzGgi2C2OxK8gx0teYX3CY1CWF43eQhMDN3mYP00p98EO82rRMVHndEPE19lKTWCv5aE32xsPzC6WaqCjmNOMSg9RbyW16KI1l8rBMAD2u5kTSO8lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y7rx/zTuBkcZS6D5yg34rxjjLVxcNSu3gyBS7SXekc4TZPp3dmauysgG3/SY9AS0hbL5HeWFJVpgcVvXYNw2DsNygSg/Lnum0QkYJIzdXF3q/Flnr5czmlgQG4Ug8cJjvOm3CI0OK9Hcue3XJ10Kg03S8yykrdH3ZwLwk+zmzI0=
Received: by 10.86.77.5 with SMTP id z5mr7354326fga.35.1209899589285;
        Sun, 04 May 2008 04:13:09 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.224.254])
        by mx.google.com with ESMTPS id j12sm8643121fkf.0.2008.05.04.04.13.05
        (version=SSLv3 cipher=OTHER);
        Sun, 04 May 2008 04:13:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080504122157.ca98c75d.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81169>

On Sun, 4. May 2008, Christian Couder wrote:

> This patch renames the following documents and at the same time conve=
rts
> them to the man format:
>=20
> core-tutorial.txt -> gitcore-tutorial.txt
> glossary.txt =A0 =A0 =A0-> gitglossary.txt

I like this, although I think that perhaps git-core-tutorial.txt would
be a better filename.

> But as the glossary is included in the user manual and as the new
> gitglossary man page cannot be included as a whole in the user manual=
,
> the actual glossary content is now in its own "glossary-content.txt"
> new file. And this file is included by both the user manual and the
> gitglossary man page.

Another solution would be to use conditionals.  I'm not sure which
one is better; I guess the include one...

--=20
Jakub Narebski
Poland
