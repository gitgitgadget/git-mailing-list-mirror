From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: Distribution size
Date: Mon, 28 Sep 2009 14:48:08 +0200
Message-ID: <4AC0B088.9090101@gmail.com>
References: <1253962653-sup-1882@nixos> <alpine.DEB.1.00.0909261320370.4985@pacific.mpi-cbg.de> <4ABE3091.5040600@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marc Weber <marco-oweber@gmx.de>
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 14:48:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsFec-0003KY-FF
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 14:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbZI1MsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 08:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbZI1MsO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 08:48:14 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:50117 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbZI1MsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 08:48:13 -0400
Received: by ey-out-2122.google.com with SMTP id 4so68764eyf.19
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PenEw+k9Qb6yV3pXeqK2hX1QbBXSoVHFYB2j+FvIX+M=;
        b=DybVAau89GGqnaOcherTcZrnsIzI0m9P8SEfHMH/0g+hbz9sRy0SvvYKDPz0S0Mkp4
         GXPVLavLyfPn95mkk0vOxReM2m1DVzjM+PYXnMgl4KKzxE1dLq2tD5hKCUPBrrxiyB2m
         QbSQGKal5p/WLWjbEcBQofUNtWR/9xWrKSAsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QtDSPS8hgnD5DsMEVV/o06NZZZk5HGOKd2FcuChlvHV5XOwGhwWxzYCS7g1H+K+GHS
         jdPnWd6tkB4WQxFO2r2LwKTIQkCpXwU+zeG2XdMi1ov6F4ZfJbeTXdvhqyM/IC15SRoy
         onlr1i5d0lwVShcL++mY7BiP99ZWBjL2d5l0k=
Received: by 10.210.101.1 with SMTP id y1mr3657854ebb.67.1254142097042;
        Mon, 28 Sep 2009 05:48:17 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm562868eyd.37.2009.09.28.05.48.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 05:48:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4ABE3091.5040600@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129258>

Thomas Singer said the following on 26.09.2009 17:17:
>> Funny.  Git for Windows is less than 12MB [*1*].
> 
> Well, the portable Git bundle compressed with 7zip is approx. 11MB,
> the Git installer (maybe also using 7zip internally) is at approx.
> the same size. Unpacked/installed on disk they are at 138MB/131MB.
> If you try to compress it with zip, it will reduce to approx. 70MB
> which still is quite large.
> 
> We are interested, too, in having a small(er) bundle, because we
> want to distribute Git binaries with our Git GUI front-end,
> SmartGit, so the user will (have the option to) get an
> all-inclusive-bundle.

[Please, never ever top-post on the Git mailing list, thanks]

Most of the git-*.exe are identical duplicates, so most of that can be 
nuked. Also, you don't need everything in msysgit to distribute, only 
for development. You should be able to make a fairly small 
distribution for usage only.

--
.marius
