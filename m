From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 3/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Fri, 30 Mar 2012 14:37:38 +0100
Message-ID: <201203301537.39429.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <201203281633.53916.jnareb@gmail.com> <20120329192557.4bd45322@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 15:37:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDc1S-00010K-7W
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 15:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933641Ab2C3Nhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 09:37:42 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40416 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511Ab2C3Nhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 09:37:41 -0400
Received: by wgbdr13 with SMTP id dr13so611031wgb.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=C6mZNhcrHkFw1Grc4dBItBX9wwhjlPZEayxL3CCpO+g=;
        b=iReYfnQ6C12jnf17RvnggC/g6kcz8nYNGMmdPY5ihOnXTq45U1tVoEzBWb6kkds3aX
         utxVqZf2lAXSwpY721cJBARe+uVvx/YyDmnI0uOBdU0yt9NjsRVf5BjkOt4SEqYa1zwd
         aTHgn/gRbYpP1dGSjPLjuqeEkKbDZxRjPprOUqc/6ivkw0/giwaxxbYbYEvXm2sFDBJP
         4fBprRA2hAiVvrFCwT1z9t8YSmesX1LdNd2wMgI5RoWwGvTwK6lG8GaeufhBeBUS6T6u
         8yxaY9ci4W20BniBj4MAyYGT1ALj6/p89w3jP7QP94C/7S2XJOblGVRWo1Ch28LoiV+l
         gBtQ==
Received: by 10.180.81.135 with SMTP id a7mr6542810wiy.16.1333114660417;
        Fri, 30 Mar 2012 06:37:40 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id ff9sm6436437wib.2.2012.03.30.06.37.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 06:37:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120329192557.4bd45322@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194361>

On Thu, 29 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> > > This is a preparation patch for diff refinement highlightning.  I=
t should
> > > not change the gitweb output, but it slightly changes its behavio=
r.
> > > Before this commit, context is printed on the class change. Now, =
it'it
> > > printed just before printing added and removed lines.
> >=20
> >                                                       , and at the =
end
> >   of chunk.

Please don't forget to add that information.  I was wondering about thi=
s,
and checked code that it works all right.

> > IMVHO such change is irrelevant.

This refers to "but it slightly changes its behavior", which might be
not clear from the position of this sentence.

> > Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>=20
> Thanks.

--=20
Jakub Narebski
Poland
