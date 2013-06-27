From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Thu, 27 Jun 2013 22:11:42 +0200
Message-ID: <20130627201142.GC27497@paksenarrion.iveqy.com>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
 <20130523102959.GP9448@inner.h.apk.li>
 <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 22:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsIY8-0005aC-AR
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 22:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab3F0UMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 16:12:07 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:49308 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab3F0UME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 16:12:04 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so1323939lab.5
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=St4sbMjtJE8uBdYsZ/90MWRk8VSvk9MduHDuewAZQ2I=;
        b=Dl3FRp6HODfQKkXFFkyKgkTK11AdsbgEe7YGZ6QyMo2HxBFkwLYfUZYbD0a3QGa22K
         oRbL2qM3Pi85PvM3X4YukvBL/NlqpvGwbB+HtTgPPscoVlMuBZBuQeWoxEbvcAp1r6f5
         XlqmLnM2d2tws2wrwhsA5oGxdL9cK/IB5IwUvnavd+qj2ZPeQhrVgQEGPqgnH7GQcpjV
         wiyN69fneTNVMaVjJ6xard5IiCbNVfLQpe7GStud8yvvnv/5LTkcUoNx1SvYsJpSt3kg
         4xOpeD7hlbGc8F0f7JFLhOCdfqPVNqEjntDjRjW6BErRpC42kxDlz/gWabm2jSjNcznl
         TfAg==
X-Received: by 10.152.25.135 with SMTP id c7mr4923628lag.39.1372363922313;
        Thu, 27 Jun 2013 13:12:02 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p7sm1632741lbi.15.2013.06.27.13.12.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 13:12:01 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UsIXe-0002qL-JM; Thu, 27 Jun 2013 22:11:42 +0200
Content-Disposition: inline
In-Reply-To: <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229152>

On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
<snip>
> +# See if we are configured to rebase by default.
> +# The value $rebase is, throughout the main part of the code:
> +#    (empty) - the user did not have any preference
> +#    true    - the user told us to integrate by rebasing
> +#    flase   - the user told us to integrate by merging

s/flase/false

And isn't all config settings documented somewhere?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
