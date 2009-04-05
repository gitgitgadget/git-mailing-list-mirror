From: Gregory Petrosyan <gregory.petrosyan@gmail.com>
Subject: Re: non-ascii filenames issue
Date: Sun, 5 Apr 2009 14:01:27 +0400
Message-ID: <20090405100127.GA12126@home>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Apr 05 12:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqPCP-0001m1-Lf
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 12:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758592AbZDEKBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 06:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758540AbZDEKBf
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 06:01:35 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:51787 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbZDEKBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 06:01:33 -0400
Received: by bwz17 with SMTP id 17so1484301bwz.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eHnC3H3tMzjjrRPPw9JWngA2crZ2mzfxePM8YkXAEnM=;
        b=QOs3ummKfsYU+UTnREW9YL05F3KQw+1VJktFqqgG6o5XDJ7xN/QpMF+Imi0Bhv2o5o
         oB3MI6gOe7n0MREtOEyd1SjpJ+oOnNSDugu/ti51X7pa0Au2k4l3VW9HlIEwe99WzdAA
         VFo+3b6xOdzIVFLGzauW0P0dxi6WET4gDy4MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=oqbRjO2SBzEkbflSjveHroyKvdGhxk9cDdJ3H1ExZaWerDCwlGWkEglEYznzTdzJSw
         KX0xhvX2GSYvoOVNVjNxd33iR4Fi3NKYYw0LsP14r2OyFniFsCmFeHkqTkukMTXhX6A9
         /vWzRl63Y0ZFZf3Saj2PvyJO+ZLqUawzjq4PA=
Received: by 10.103.171.6 with SMTP id y6mr1390888muo.110.1238925690812;
        Sun, 05 Apr 2009 03:01:30 -0700 (PDT)
Received: from home ([78.111.87.153])
        by mx.google.com with ESMTPS id e8sm5853833muf.48.2009.04.05.03.01.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 03:01:30 -0700 (PDT)
Mail-Followup-To: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87ab6v2zor.fsf@iki.fi>
User-Agent: Mutt/1.5.19 (2009-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115651>

On Sun, Apr 05, 2009 at 12:54:28PM +0300, Teemu Likonen wrote:
> On 2009-04-05 13:36 (+0400), Gregory Petrosyan wrote:
>=20
> > # Changes to be committed:
> > #   (use "git rm --cached <file>..." to unstage)
> > #
> > #  new file:   "\321\204\320\260\320\271\320\273"
> > #
> >                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >                  "=D1=84=D0=B0=D0=B9=D0=BB" should be here instead
>=20
> It can be fixed with command:
>=20
>     git config --global core.quotepath false

Thanks! That works. Does it make sence to set it to "false" by default?

	Gregory
