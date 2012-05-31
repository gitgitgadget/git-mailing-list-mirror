From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 12:37:13 +0200
Message-ID: <20120531103713.GA30500@paksenarrion.iveqy.com>
References: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
 <CACBZZX6fV5PpgV6GMhDMYgXeeP_QYK9jnP15tMn9Y-a-O6Pn3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, gitster@pobox.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 12:38:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa2lT-0002uf-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 12:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab2EaKhp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 06:37:45 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64025 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751518Ab2EaKho (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 06:37:44 -0400
Received: by lahd3 with SMTP id d3so588089lah.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JsWLcvUvSze2aE0Meq0Amw1ghhKFZ88zQ4ktoQw5APo=;
        b=DMA+b2I2XpOWjWQ/uf321B2Eu9gZwhSk9uYAYPaUnI0x55BSBR+LAI06j69hg8E1Nv
         uG0sz7+/rXoWb90KSDNxQMGnyAZ6r6Rnv9rHq7Dw7e7S6VVdICa0v1LoAdtdWY44pdxE
         A54k4iE4qmCKQmTVZZlGQMJ4XUh0f6DfQSKWCuuJEVsD4GINZhP0dvWEAFvDzkfXowP0
         oU5oQDSgz2LN6G5izc7bOWj1cEDPe5JVZp/RbWKDeS61KniBxocRkeDnyBeFf2usFraq
         7fa/ltkCAqtukopAklpdx7cTKjq//7xYUNGwHqSQv/IKhnaFL1bBsQe/0AawyGYnalr9
         EaoA==
Received: by 10.152.105.51 with SMTP id gj19mr19248778lab.38.1338460663088;
        Thu, 31 May 2012 03:37:43 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-184-249.a189.priv.bahnhof.se. [85.24.184.249])
        by mx.google.com with ESMTPS id h6sm1863772lbl.13.2012.05.31.03.37.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 03:37:42 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Sa2kj-00081A-DZ; Thu, 31 May 2012 12:37:13 +0200
Content-Disposition: inline
In-Reply-To: <CACBZZX6fV5PpgV6GMhDMYgXeeP_QYK9jnP15tMn9Y-a-O6Pn3A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198879>

On Thu, May 31, 2012 at 11:07:22AM +0200, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> On Thu, May 31, 2012 at 10:48 AM, Fredrik Gustafsson <iveqy@iveqy.com=
> wrote:
> > Rewrote a perl section in sh.
> >
> > The code may be a bit slower (doing grep on strings instead of usin=
g
> > perl-lists).
>=20
> May be? Did you test it, if so what's the difference?

I did not test it. I think that it can be easily judged by someone that
knows how perl implements its arrays. With an array implementation with
a hashmap-solution, it should be slower, of course depending on the
number of submodules.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
