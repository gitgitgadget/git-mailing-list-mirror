From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Sun, 25 Apr 2010 17:09:55 -0500
Message-ID: <20100425220955.GA25620@progeny.tock>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
 <20100425194800.GB14736@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Cheng Renquan <crquan@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 26 00:09:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6A0t-0008WD-7A
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 00:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab0DYWJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 18:09:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45843 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab0DYWJL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 18:09:11 -0400
Received: by gwj19 with SMTP id 19so3625739gwj.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6/uZCwioclpL7OCqSoQcNQMFgapi0+tsNr1m3pAMn6s=;
        b=PxaQ6oOGgXY6NeZeJRMHyKs6xzNhxDHK10TUeUZiVTpK9mkjqZBWF+AoYAxCjeVBnZ
         ef1WGqudUWHZYTvlpOARS1xXx7NCHw1/SRsKmf8w3T9Ksr7o6d2YrY/Pic1JcvGTized
         E3oju38F1UFcp0OULZPaAQ1eNA+vq/bkC7kBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OqC3Qcu0BVgKlq8OmH5DQws5Yeq4PqGMrdHPENf4mlMpxvSvrk9kqVkHaN4mrjH60q
         WN9Ne6QvrRNNDMtFNrW9D/AAQJlk3Eh6uhzAIJUFHRf1yfxjskWEbm+KF3KVjlVSA8iU
         9IQB92pFzUhMZHT7dktWen72gD6mIGn3LojKU=
Received: by 10.101.139.6 with SMTP id r6mr3937523ann.14.1272233350240;
        Sun, 25 Apr 2010 15:09:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2543975iwn.14.2010.04.25.15.09.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 15:09:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100425194800.GB14736@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145773>

Jeff King wrote:

> The config variables format.* are traditionally about format-patch. I
> see we have format.pretty these days, too.

Yes, it as added in commit v1.5.5-rc0~57^2 (log/show/whatchanged:
introduce format.pretty configuration, 2008-03-02):

    When running log/show/whatchanged from the command line, the user m=
ay want
    to use a preferred format without having to pass --pretty=3D<fmt> o=
ption
    every time from the command line.  This teaches these three command=
s to
    honor a new configuration variable, format.pretty.

    The --pretty option given from the command line will override the=20
    configured format.

I use it to mess with line wrapping; that it=E2=80=99s possible is very=
 nice.
Thanks, Renquan.

Jonathan
