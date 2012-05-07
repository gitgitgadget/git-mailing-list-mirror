From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Mon, 7 May 2012 15:08:03 +0200
Message-ID: <20120507130803.GA6189@tgummerer>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <CABURp0rAjrhVACQEafrZRxtXBAmajpEqfp+EmB7s595dobqHQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 15:08:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRNfl-0001Fe-SO
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 15:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab2EGNIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 09:08:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50714 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab2EGNIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 09:08:12 -0400
Received: by obbtb18 with SMTP id tb18so8267726obb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PKW+NzxQFtw1LoKBBi+6fPzByWCIiCq8xJptygzf8+M=;
        b=IvwDLIifXH+zVCUowW1vh7P0ERomaAojoZLHhDvaPMupXFm0zwnR94IA2WeM3ohg2O
         LL/emZM9UUQe80fwVQaQdwC1TgK2JFczToVZ9BOVBfi0VlEKdD6RPYFsmOzUAJzjqEdE
         bbBtt8vA9XgbH6NC2Ut5r+2SphS1pHA79kqqEJ0SuUjTOpOVi1ROXB2GFPwi26X3MpAf
         CYw7WOjHeR8zlhcwXmshiRR2k4A8J1RIf9WiGVNKiNJA2dvl872LR9XyrRUpmfKcWpFW
         Z56dtZTR/htitgJpSYlwyHjPGO/dsFPmt8QskZHe+Ssfx3coIvtJ7xmi3VDxCLgsC5S4
         LOrw==
Received: by 10.182.5.132 with SMTP id s4mr5892892obs.65.1336396092241;
        Mon, 07 May 2012 06:08:12 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id r8sm14543498oer.6.2012.05.07.06.08.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 06:08:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABURp0rAjrhVACQEafrZRxtXBAmajpEqfp+EmB7s595dobqHQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197269>

> > =A0Path names (variable length) relative to top level directory (wi=
thout the
> > =A0 =A0leading slash). '/' is used as path separator. '.' indicates=
 the root
> > =A0 =A0directory. The special patch components ".." and ".git" (wit=
hout quotes)
> > =A0 =A0are disallowed. Trailing slash is also disallowed.
>=20
> typo: The special _path_ components ".." and ".git" ...

Thanks, I changed it.
