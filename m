From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 13:09:06 -0400
Message-ID: <4C7FDA32.5050009@gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <20100902155810.GB14508@sigill.intra.peff.net> <alpine.LFD.2.00.1009021233190.19366@xanadu.home>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 19:09:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrDHp-0007iD-Fq
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 19:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab0IBRJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 13:09:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51138 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab0IBRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 13:09:10 -0400
Received: by yxp4 with SMTP id 4so249362yxp.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MXaIJSsB94UtcIvddmdGHFRWituZxKWwP7ukm/tIEtI=;
        b=LS5z95iMj3MZsqbf4uM5VLsZZMl3B0KFjIDiC0Um794y312ZdwZxryOUop2g+JIcIF
         DqrfnGlzob/JvJ7SSRPuhDuN1XNPVqWSN9DXPWSvyhIy+1AIPFhegohpxEXXUoeP8FX+
         nsQu7TBLuH2+Gwa0oNmx9Kzdfi7XnnW9DUVqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=I9Y7xUo4bDRavpWkfZPrcaG+0izjgqJ4/MEvbJYZMITGUntVl7SS5zA7ssWL7tkb4U
         g81se2A7xEDLuKs+qFHYYIJIxlEbdwv9veHV6ynbGPCaciNrpxk/trb2NpFEZiAUcwB2
         mb9883rRavnxe+mbNJVTXJ0UBSxf5ce+98qX4=
Received: by 10.100.105.10 with SMTP id d10mr10529651anc.158.1283447348875;
        Thu, 02 Sep 2010 10:09:08 -0700 (PDT)
Received: from [10.0.1.130] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id x33sm1027809ana.13.2010.09.02.10.09.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 10:09:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <alpine.LFD.2.00.1009021233190.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155150>

On 09/02/2010 12:41 PM, Nicolas Pitre wrote:

[...]

> I would go as far as stating that this is never guaranteed by design.
> And I will oppose any attempt to introduce such restrictions as this
> will only prevent future enhancements to packing heuristics.
>
> For example, right now you already can't rely on having the exact same
> pack output even on the same machine using the same arguments and the
> same inputs simply by using threads.  As soon as you're using more than
> one thread (most people do these days) then your pack output becomes non
> deterministic.

Finally, the real pack expert weighs in!
