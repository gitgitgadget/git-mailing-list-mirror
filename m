From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] hash binary sha1 into patch id
Date: Sun, 15 Aug 2010 02:56:31 -0500
Message-ID: <20100815075631.GA25112@burratino>
References: <20100813094027.GA20906@localhost>
 <20100813200031.GD2003@burratino>
 <20100813212331.GA24127@localhost>
 <20100813213726.GB2516@burratino>
 <20100813215801.GA24534@localhost>
 <20100815072043.GA368@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marat Radchenko <marat@slonopotamus.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Aug 15 19:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okgjn-000339-5l
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 19:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab0HORK6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 13:10:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35228 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758501Ab0HORK5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 13:10:57 -0400
Received: by iwn7 with SMTP id 7so814372iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5D6uxuQOeNM5w1mC9xozKQEgIJCiefgyXV3nbhcY83c=;
        b=p4cwqbTv6kHEmEW0+daMi3DIE3mLy1JHjwsVritLAUWfVXllc1N1h/Nl8+nyXyocEx
         QHCbJAkfxWDncxOZ+m/xxvfL71+H/raTvoIzKAdYpII22Yb3+yPn8OxT/02WfT1RHF8Y
         HPYY73JZSdQChjt0yLP8TPhsx9Pppf8m+zmMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hILJpnWmmmsxRSTF/G7rw7273+oD6hg+jKxvUsqaX0GLlIbDAtqTDTJLdDrLOBqV4O
         YUutJVOQVBcs++vaOVgoyyzY+K4PYUsRh7dubPfYyYahzQhMfhi5Jhpj1mK0M0/25EF7
         SDvHzgRucYoOJ0o8IK0le+mdxkRlHlK+MOnhw=
Received: by 10.231.15.68 with SMTP id j4mr3732152iba.184.1281859090985;
        Sun, 15 Aug 2010 00:58:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm3186903ibb.14.2010.08.15.00.58.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 00:58:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100815072043.GA368@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153612>

Clemens Buchacher wrote:

> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Nice. :)

> I am again attaching the corresponding test script. Since it mostly
> tests performance, I am not sure how to incorporate it into the
> main test suite.

Maybe t3302-notes-index-expensive.sh would be a good example to
compare.

I haven=E2=80=99t looked carefully at your test script; is it possible
to extract a non-expensive test (i.e., just for correctness)
from it, too?

Jonathan
