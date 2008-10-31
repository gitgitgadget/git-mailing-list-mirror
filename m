From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Fri, 31 Oct 2008 08:36:01 +0100
Message-ID: <200810310836.02908.jnareb@gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <gedhh6$urq$1@ger.gmane.org> <1225435899.20883.25.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 08:37:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvoZZ-0003Lh-9N
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 08:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbYJaHgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 03:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbYJaHgS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 03:36:18 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:49367 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbYJaHgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 03:36:16 -0400
Received: by ik-out-1112.google.com with SMTP id c29so113786ika.5
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GrgnhfTYlQZ7v0AneX94hKS2LCfS7WdzeHucP3biXKU=;
        b=X9DrJl3cnJlG4HwrSMq+zGlHxZoMWg78qFeJtNMBZM3aLSC9fUmRzLYBhrxIHN0ba0
         d06FJpvs4vtMJ1DjzHSebnApyZfJ+UQuPbJ0rTwwz1vuhHDDl7a0talBJFr/8SMsjyuL
         z4VcFGb+6hSCY0+x3LniUk9hbMAagTzwVQ5Eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UZWXKDxsJFC6PrD9+QJuKKgC0DyuYPpq5NAgN5IVBf517VENd8GOOdNAyLfSj3qneD
         fSVP4XR9G5wkywo9v2C7RY1rNoOa5Tt/Yo13QFpNJ/d3priFKQbNDeFpwwFP6SllWjik
         /7ynAm1MDjkvl1vh9SMTZuSnLCamvRhdd6VFM=
Received: by 10.210.89.4 with SMTP id m4mr8434911ebb.107.1225438575161;
        Fri, 31 Oct 2008 00:36:15 -0700 (PDT)
Received: from ?192.168.1.11? (abvo7.neoplus.adsl.tpnet.pl [83.8.212.7])
        by mx.google.com with ESMTPS id d2sm1932575nfc.20.2008.10.31.00.36.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 00:36:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1225435899.20883.25.camel@maia.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99557>

Dnia pi=B1tek 31. pa=BCdziernika 2008 07:51, Sam Vilain napisa=B3:
> On Fri, 2008-10-31 at 00:55 +0100, Jakub Narebski wrote:

> > > involves typing the branch name twice.  I end up writing things l=
ike:
> > >=20
> > >   git checkout -b {,origin/}wr34251-do-something
> >=20
> > Can't you use currently
> >=20
> >     git checkout --track origin/wr34251-do-something
>=20
> Ah, that's a new feature.  Still, I think it's poorly Huffman coded; =
far
> too verbose.

Well, either you have a little bit more verbose, or you have to have
some DWIM-mery, which (as usual with DWIM) can go wrong.

--=20
Jakub Narebski
Poland
