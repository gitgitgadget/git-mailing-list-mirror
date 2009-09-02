From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] clone: disconnect transport after fetching
Date: Wed, 2 Sep 2009 09:37:40 +0200
Message-ID: <fabb9a1e0909020037m4ce6237ana6dec41088bba596@mail.gmail.com>
References: <alpine.LNX.2.00.0909020159080.28290@iabervon.org> 
	<20090902063647.GA29559@coredump.intra.peff.net> <fabb9a1e0909020009r3ee28b1fo3cba095abafec9d4@mail.gmail.com> 
	<20090902072638.GC31528@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 09:38:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MikQJ-0000Wz-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 09:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbZIBHh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 03:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZIBHh7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 03:37:59 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:45086 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZIBHh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 03:37:58 -0400
Received: by ewy2 with SMTP id 2so528524ewy.17
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=o27o2Oh+Ti2jh5nSzF5jCv71Icu03Z9QNm6fq6w9Aoo=;
        b=kNBNElUSfWfny6EqQfFJgWwFT2JkAsDjKYfo8G/0PBhJBT/6vZ6QvtbMLQtLvhn44K
         +OGAmLPnlLOEnbzwnLrXZdQxLg+ahRq7TtdlOCAwnOIFF6yVyup304sMZoAAXGzWZerm
         bGQUW7UbAOFR7qUqSIc1brQvXM6xRfNM9IQIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HjGCw4pzKQVWKke+63h5Hoa5p+HOsT7juQkyM7OQTISawTqN6RgIOFq9gOYV4TUK7B
         afRL69TNBfRWjeMyxuJi2VjE47b3I6z0rkwFsQBGOrF2ITN3KkdhypGSL7kIcJh6+7AZ
         eH2FPBSsEv2NwifZhp1+EkFztladxcuEz6SMU=
Received: by 10.216.47.201 with SMTP id t51mr95861web.198.1251877080133; Wed, 
	02 Sep 2009 00:38:00 -0700 (PDT)
In-Reply-To: <20090902072638.GC31528@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127591>

Heya,

On Wed, Sep 2, 2009 at 09:26, Jeff King<peff@peff.net> wrote:
> So think of it as you exposing a long-standing bug. ;)

Ah, well in that case, you're all welcome :P.


-- 
Cheers,

Sverre Rabbelier
