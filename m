From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/8] gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
Date: Fri, 30 Mar 2012 14:34:34 +0100
Message-ID: <201203301534.35484.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <201203281756.42653.jnareb@gmail.com> <20120329193152.3d0f27e2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 15:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDbyV-0006G6-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 15:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933528Ab2C3Nek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 09:34:40 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60477 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511Ab2C3Nei (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 09:34:38 -0400
Received: by wgbdr13 with SMTP id dr13so608697wgb.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=sZB3K+EnzuIjWhBUZ0lMOMV6wmmJMs8gU3V8rd0cZU4=;
        b=hLvcAhsF6GV1nlXCn1MoYdGE6tUtwWFS+vreqIkxb6zdELRXjAh3T68VgeHol/H4I+
         3baAQgyzhoNNcZZkYLe19m/0g2JhBZqCITim1jskWDUZOlkE5TCklD0F+Mz5rNCMq8S4
         ctPtzush2eUt1/t9GAk8ZXa5fgBBfNkIvGm9mL6Gkfq+fp5bYZ+vBsCfxJx6mm5u5kR8
         8WodCIPfmXPKMIHu/21q/ZmE7DqCkjUwx2bGqCcDLH/ZyRL5YPY1Fko//PoivBSy+Ucp
         VA2zObYtJkQ9PMerZzcIYAai836MjdFj8vzLvFrXmx/5+RTc8+/K/5Z1WsplkPFPs9f/
         cLcg==
Received: by 10.180.107.132 with SMTP id hc4mr6453530wib.21.1333114477134;
        Fri, 30 Mar 2012 06:34:37 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id 6sm6427666wiz.1.2012.03.30.06.34.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 06:34:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120329193152.3d0f27e2@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194359>

On Thu, 29 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

> > BTW. I was wondering about binary files, but this commit wouldn't m=
ake
> > it worse anyway as we parse diff output assuming unified-like diff =
for
> > diff syntax highlighting... and binary diffs are shown as
> >=20
> >   "Binary files a/foo.png and b/foo.png differ"
> >=20
> > in extended diff header.
>=20
> Yeah, this is what I wrote in the cover letter:
>=20
> 	* Ensured that binary patches are not supported in HTML format,
> 	  thus this series canot break it :) (answering Jakub's questions)
>=20
> but maybe I wasn't clear enough.

Eh, sorry, this was more of reminder to myself, rather than questioning
you if you really checked that.  Sorry for that.=20

--=20
Jakub Narebski
Poland
