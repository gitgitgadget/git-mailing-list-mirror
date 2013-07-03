From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v5] [submodule] Add --depth to submodule update/add
Date: Wed, 3 Jul 2013 10:38:00 +0200
Message-ID: <20130703083800.GB22216@paksenarrion.iveqy.com>
References: <51D342BB.8080907@web.de>
 <1372801376-32673-1-git-send-email-iveqy@iveqy.com>
 <51D3D20A.5000700@web.de>
 <7v4ncchxif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>, hvoigt@hvoigt.net,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:38:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIZb-0003bX-PO
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191Ab3GCIhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 04:37:55 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:52866 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab3GCIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 04:37:53 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so4065914lbh.37
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 01:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U8CAllKIh0HkoXDqoQ7kEz7jluOlwTu1W5kn6hrc1vk=;
        b=o7ncWtbOp3+jn1jqhZIqjoetzaspC+P0ZwKmYa2x3grm+fZLChyAwHdskQ/ylxxHsX
         pG9wuCAg5qlZWabTlWOeDS6CWJWlTIvf09c0kzxXevRoyvtN99t8K+v3B3ybsl2/XWYy
         jr+wzcNlx+Y9tUTkeUemL0nZyxCY33ETGNYpLEWvo7kdd+dHaxG+QQtJRs0phxb9AciL
         7Jy/6cy2croErjm5IYMSnA4kPatYlgoIwHHpW9Bmt4tkUsvNivOfobzZzEcjQ/X3H8oZ
         adevyK2OLGhGyu2Jx68T3XAZF2MFss4DF29dVx5XI55rOa2qBDjkPFLRJ1wbREVFedEV
         Mplw==
X-Received: by 10.112.52.97 with SMTP id s1mr729864lbo.8.1372840671306;
        Wed, 03 Jul 2013 01:37:51 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p10sm10417867lap.8.2013.07.03.01.37.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 01:37:50 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UuIZd-00047R-04; Wed, 03 Jul 2013 10:38:01 +0200
Content-Disposition: inline
In-Reply-To: <7v4ncchxif.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229467>

On Wed, Jul 03, 2013 at 01:13:12AM -0700, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> > The only minor problem is that this patch still does not apply clea=
nly
> > to master, next or pu (I wonder what you based this on ;-).
>=20
> Thanks; will replace what I queued on 'pu'.

I based it on master, but have forgott to rebase since v2. This is base=
d
on 3e7a5b489e45ae8a3a0b222893d58b172d883136.

The merge conflict is pretty clean, would you (Junio) stil like a
rebased update of this patch?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
