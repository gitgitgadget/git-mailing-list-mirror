From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Binary files in a linear repository
Date: Mon, 2 Nov 2009 20:45:46 +0300
Message-ID: <20091102174546.GE27126@dpotapov.dyndns.org>
References: <S1754797AbZKBONX/20091102141323Z+268@vger.kernel.org> <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de> <20091102154831.GC27126@dpotapov.dyndns.org> <20091102160903.GA6197@atjola.homenet> <20091102165215.GD27126@dpotapov.dyndns.org> <20091102170106.GA8650@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 18:46:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N50xf-0003mt-SG
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 18:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbZKBRor convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 12:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755654AbZKBRor
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 12:44:47 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57330 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbZKBRor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 12:44:47 -0500
Received: by bwz27 with SMTP id 27so6574489bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 09:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sQMd5/VoIPDSldhTYPRncuv0YL0Oi3jKcZVau4worYY=;
        b=L9GIZENyiE2Ut18mob3Mkg67A7PRvC/RulSY4QXYnKta2+HB6H9NQABnRanJRes6Ni
         7AdvWoP2FkMa9e9ckcR7nGLVzcgk9uuaIlRAVv6W1c8XGikcTrjV3/KDJj8ld+Nymcs7
         TSNCzvoF9Ve4wWiBhckFUq3U3FvMrMu5bd6PU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kLVOzN6ppqAynnlT4zM2qyajHkdIpOw9OWDCHV9HEtE0+78xGn1fHgnuqpRXJWRmcT
         78qW94WopwG35o9B0juaj1PZysxWX+zTAZouuBoFQSTaEeCKQjraofbxaHCdsXDeykEC
         PJgGVIF/YpUZjc6JlDOUMKWVOZHqBcNR/SSzw=
Received: by 10.204.7.195 with SMTP id e3mr4208654bke.118.1257183890009;
        Mon, 02 Nov 2009 09:44:50 -0800 (PST)
Received: from localhost (ppp91-77-227-241.pppoe.mtu-net.ru [91.77.227.241])
        by mx.google.com with ESMTPS id 13sm962216bwz.10.2009.11.02.09.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 09:44:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091102170106.GA8650@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131930>

On Mon, Nov 02, 2009 at 06:01:06PM +0100, Bj=F6rn Steinbrink wrote:
>=20
> That would do, but:
> git checkout <commit>
> *make changes*
> git reset --soft master
> git checkout master
> git commit
>=20
> seems unnecessarily complicated, when you could as well do:
> git read-tree -u --reset <commit>
> *make changes*
> git commit

I thought Markus *already* had made changes on that commit, but
maybe I misread what he wrote...


Dmitry
