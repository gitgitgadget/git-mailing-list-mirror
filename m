From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Where do I stick development documentation?
Date: Wed, 11 Aug 2010 21:39:22 -0500
Message-ID: <20100812023922.GB19174@burratino>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 04:40:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjNiz-0006Ky-Hj
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 04:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759415Ab0HLCkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 22:40:52 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52523 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759385Ab0HLCkv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 22:40:51 -0400
Received: by qwh6 with SMTP id 6so877222qwh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 19:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=52W4rjy3KFGJSkz9khdFgxofsmzcfEzDK9/ypILeU7g=;
        b=fgCd223SCyspmTEcI1KSkN03AZiy25hljg9u9fdUYif8Yyr+lFVqOxSav3mF1Lgtr6
         +5glAsugqSOkbmR+MAUIDcmItqG5FxipN/rJ0wiw+NdftO0TwylYSgzTJ+GdxYXr3fld
         MaFAm+Lv2dgWkcsEaaMlUbfpyUaiDr6HVM3s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=seXXks7ZUFD4L8CZW9VqtUjSkskKJ1BE4VvRxHJW2j4no/tCtSAvf2sKWk89BoKWsu
         GngeCZhip10ioYg/YtUbxgyt42eiy5ccsiTObxhNzNVXLsBhgkiZJ/44hEXoy3H7mXXb
         7UrikqhO42inrOXKYYxGDnaGlEW9AfzGuBOqs=
Received: by 10.220.157.139 with SMTP id b11mr12130938vcx.151.1281580850169;
        Wed, 11 Aug 2010 19:40:50 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i40sm466754vcr.32.2010.08.11.19.40.49
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 19:40:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153326>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> There's some documentation aimed at developing that I'd like to see /
> write in Git at some point.
>=20
> Developing:
>=20
>    * How to work with Gettext
>=20
>    * How to write portable code, i.e. constructs to avoid in C / shel=
l
>      script etc (these keep coming up).

Maybe:

 Documentation/technical/api-gettext.txt
 Documentation/CodingGuidelines
 Documentation/PlatformNotes

or some variations on the theme?

>    * How to deal with gettext / submit po files / keep them up to dat=
e
>      etc.

gittranslation.7?

>    * Core git concepts (that need to be translated), maybe I could
>      adopt the gitglossary to this task, but it'd need to be a bit
>      more structured, i.e. describe core data concepts first, then
>      some other terms.

That sounds good.  Once we develop infrastructure for translating
manpages, we could encourage translators to do gitglossary first
to standardize terminology.

>      Actually, on that point, do we have documentation that describes
>      git's data model in one place? I.e. everything from blobs to
>      trees, how raw commit objects etc. look. Something like "Git for
>      computer scientists".

Hopefully some pic wizard can convert that to nroff. :)

I think Tommi Virtanen should be easy to reach in case anyone wants to
try adapting the article somehow.

Hope that helps,
Jonathan
