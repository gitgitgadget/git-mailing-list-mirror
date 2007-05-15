From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Do not use absolute font sizes
Date: Wed, 16 May 2007 01:59:55 +0200
Message-ID: <200705160159.55590.jnareb@gmail.com>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com> <87odkmgaj5.fsf@morpheus.local> <20070515150912.GA3653@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 16 02:00:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho6w4-0008Eq-6v
	for gcvg-git@gmane.org; Wed, 16 May 2007 02:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759216AbXEOX77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 19:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758944AbXEOX76
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 19:59:58 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:56305 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758391AbXEOX75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 19:59:57 -0400
Received: by nz-out-0506.google.com with SMTP id r28so365330nza
        for <git@vger.kernel.org>; Tue, 15 May 2007 16:59:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h0mTSX1GAVia0iZuz5Rd+ao+1SngNuet3GbC0DLLHkMqRDZp15cN86ACqjFPz7UvAx3iCUDa3aUhQm0CTLno/vb6j4xx6yoUqqZ6BGtqiTv5tKpCpP3pguau3q5ys4bvrciPxPIgdIlPiEAjRkVCH5LpvnG/g93PCwTehYyDHqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=J8oL5fAY+aYPgWYCaTEgh5SCMc69K0djBOeZEZBLXHfIOT3JFRSqGyISSkzMyyyjn+l0DJAdsORwUeBOOFt8eqiQ/dppyzVN/nvnqWbYSd14uD0nZtK0OY2D5WQtOxx+6oX13Ar/xfYzehTyaGMMjsBkGDu5I/bG1VBXNwOWF5U=
Received: by 10.65.160.7 with SMTP id m7mr1988871qbo.1179273596347;
        Tue, 15 May 2007 16:59:56 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id q15sm1276794qbq.2007.05.15.16.59.54;
        Tue, 15 May 2007 16:59:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070515150912.GA3653@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47394>

On Thu, 15 May 2007, Jan Hudec wrote:
> On Mon, May 14, 2007 at 18:06:54 -0700, David K=E5gedal wrote:

>> Unfortunately, the problem is that too many web sites explicitly
>> select extra small font sizes, which means that you have to select a
>> "standard" font size in your browser that is a bit larger than you'd
>> actually like.
>=20
> IMHO gitweb should explicitely request being somewhat smaller than no=
rmal,
> because it has good use for long lines. Normally I want to set font s=
o large,
> that more than ~120 characters won't fit on the screen, since otherwi=
se pages
> that don't use margins are simply unreadable. However gitweb presents=
 a table
> with several columns, so having wider line is OK for it. Therefore ex=
plicit
> 'font-size: small' would make sense.

And thanks to commit 63fcbe00 by Pasky
  "gitweb: Do not use absolute font sizes"
it has to be added in only one place:


diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index b57c8be..02623cb 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -1,5 +1,6 @@
 body {
 	font-family: sans-serif;
+	font-size: small;
 	border: solid #d9d8d1;
 	border-width: 1px;
 	margin: 10px;
