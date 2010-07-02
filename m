From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Print last time and committer a file was touched by for a
 whole repo
Date: Thu, 1 Jul 2010 22:37:10 -0500
Message-ID: <20100702033709.GA6818@burratino>
References: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com>
 <20100701200525.GA3686@burratino>
 <20100701214035.GA2969@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Eric Raible <raible@gmail.com>,
	Tim Visher <tim.visher@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 02 05:37:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUX4T-0008VA-S9
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 05:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab0GBDhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 23:37:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63996 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234Ab0GBDhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 23:37:39 -0400
Received: by iwn7 with SMTP id 7so2771169iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kvBtGDOlrGe72sOBxCVMgvgpLkQh0khYg3Me1nmiXac=;
        b=h3LC7naHo/vwPZ+8muqdX22FxHCUt7k/OqA3hwctTU5/L1qTVRIeBBXv+yhhiHMAlw
         DWZI+TIBafvxAG35Q56ezLwpSdEcz5UBVpRgOXDTLpBaO83EpHsFyF8GDNxY+xrYawvQ
         iAlgvbxfOFlf6gJeH/YBQGGHRtWdwbv5MqnGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SvlYxL/eOZIiaUb0IyjXIKWNHy4vbLaDNw/3xESVp7qkkNtbf+inDLd2+JE71I85Yq
         yQ1SN2Ie6ggtLzBi5grtDEE1F9xQsS2V46y/QtarY4GfCMpUqeFjpFIvvdRTSxL8ykI2
         tHicT11+dvB6rN/TO6U9N8xb+7PrOyY6kouYM=
Received: by 10.231.39.134 with SMTP id g6mr160833ibe.8.1278041858721;
        Thu, 01 Jul 2010 20:37:38 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x6sm847023ibb.23.2010.07.01.20.37.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 20:37:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100701214035.GA2969@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150103>

Eric Wong wrote:

> perhaps we should just include this in the
> contrib/ section of git.git...

Yes, I think so.

Thanks for writing it.  I have been thinking of adapting
the code for =E2=80=98git archive=E2=80=99 for a while now, to make it
easier to comply with the Debian policy on timestamps[1].

[1] http://www.debian.org/doc/debian-policy/ch-source.html#s-timestamps
