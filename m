From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/RelNotes-1.6.0.txt: Expand on the incompatible packfiles
Date: Thu, 17 Jul 2008 19:40:06 +0200
Message-ID: <200807171940.06288.jnareb@gmail.com>
References: <20080717170118.14083.87086.stgit@localhost> <g5nue6$3ek$1@ger.gmane.org> <20080717172051.GY32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 19:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJXTg-00070Z-9J
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903AbYGQRkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 13:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757183AbYGQRkM
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:40:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:5518 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903AbYGQRkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:40:11 -0400
Received: by fk-out-0910.google.com with SMTP id 18so18057fkq.5
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jdNTMNljG3NJ6waLzXF2y+5HfXGRNX6CQPPrf3fMUEw=;
        b=XjKAx1xM/5N7ab8+Lo8mLdoQBHX78G+v3FGlWlbvvryD3lBfvePiPetsHf3kt4yiS0
         7ZqCbJsvTj+v0irGLa83k+k4rjQaQIyHwJ8P/dxvUWb6f9VA6RolPXykwLhIA6nNMURe
         gzT3wG7kPS32lK23tLMnKzPbNLpPlKfDfVKP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=i2kXkC7nAKjiPK58Y6NoCutsDbAm71lf5ovb3l2oWNF7ttXDddx3oH7cke1Ux5DNMA
         OP2FUZkMwE2qQoQ9r2z53XZVqfAdoj8v4EYDUW5zCX0RyZKZ5qJXZ//pVmvD7tR5Lxnu
         HToNMY3zQyXvsOwQ1jC+fru0FJCL5hVALvH5A=
Received: by 10.187.191.19 with SMTP id t19mr1010320fap.87.1216316408681;
        Thu, 17 Jul 2008 10:40:08 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.254.74])
        by mx.google.com with ESMTPS id 8sm1629300hug.44.2008.07.17.10.40.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 10:40:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080717172051.GY32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88891>

Petr Baudis wrote:
> On Thu, Jul 17, 2008 at 07:10:32PM +0200, Jakub Narebski wrote:
> > Petr Baudis wrote:
> >=20
> > > +introduced in v1.5.2 and v1.4.4.5. =A0If you want to keep your r=
epositories
> > > +backwards compatible past these versions, set repack.useDeltaBas=
eOffset
> > > +to false or pack.indexVersion to 1, respectively.
> >=20
> > 'or'? Not 'and'?
> >=20
> > You shouldn't have, I think, this "respectively" here.  You need it=
 only
> > if you are writing "a, b, c, then a', b', c', respectively".
>=20
> The "respectively" means that the two options relate each to one of t=
he
> two new features.

Sorry, I have forgot that "respectively" might refer to the context
which I don't see in a patch.

> I'm unclear about the 'or'-'and' question, though.=20

If you want to be backwards compatibile with pre v1.4.4.5 clients,
do you have to set either option, or both options, or what?  The
same with pre v1.5.2 client...

--=20
Jakub Narebski
Poland
