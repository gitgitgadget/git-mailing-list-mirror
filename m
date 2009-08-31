From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Tue, 1 Sep 2009 00:50:25 +0200
Message-ID: <fabb9a1e0908311550r1b549eb2k2df65c188a0ea6a0@mail.gmail.com>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net> 
	<vpqskf8z0rj.fsf@bauges.imag.fr> <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com> 
	<20090831164146.GA23245@coredump.intra.peff.net> <vpqocpvevzx.fsf@bauges.imag.fr> 
	<20090831191032.GB4876@sigill.intra.peff.net> <20090831201911.GA24989@atjola.homenet> 
	<20090831224749.GA24190@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 01 00:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiFiA-0008LG-0U
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 00:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbZHaWuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 18:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbZHaWuo
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 18:50:44 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:46450 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbZHaWuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 18:50:44 -0400
Received: by ewy2 with SMTP id 2so748476ewy.17
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=wp5uEvO3zz7vgx30xB5FR93t9Rcbp5M27TBpVd9+9EE=;
        b=StH6vR3tmmAW0AdNWx9qEbfgGoCeF6vjEd6JYHYj5kZX/yiIYrJpLVf+Q4xixDiLSY
         PQPHi79N/d3U+TwvJbSf1tIW2zTMWD8cwoU6MZi+mhXrGhQgDBPOdZTax8iQHW9H9H9c
         5k+ljGxbHPTJpDMXhohh6Dw6WU0xygMqRcocw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tKn0atw1uiygU8yvj1xwg1MEnPAQfNlVUQeho10AiOq4rRBejTOg2Zc6wK1gukXcX/
         DGihOh5h7ytyJMR4Bls4o6FsDGJlQNYMqLRpD5an2rJSth+Ot8lKUi+Wb2jZkTUF8QpV
         2pyI+vR5Eiak0X4qBXo6a+V689bLiKuUWkG8k=
Received: by 10.216.45.71 with SMTP id o49mr1329058web.57.1251759045072; Mon, 
	31 Aug 2009 15:50:45 -0700 (PDT)
In-Reply-To: <20090831224749.GA24190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127504>

Heya,

2009/9/1 Jeff King <peff@peff.net>:
> AFAICT, this problem goes back to v1.6.2, the first version which
> handled empty clones. So I blame Sverre. ;)

Eep :(. Any idea what is going on?

-- 
Cheers,

Sverre Rabbelier
