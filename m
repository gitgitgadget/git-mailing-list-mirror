From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Thu, 16 Jun 2011 16:14:13 +0200
Message-ID: <201106161614.14656.jnareb@gmail.com>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com> <201106151735.07137.jnareb@gmail.com> <BANLkTimYsvHqZsxYA34o7s94c9V8vzkHbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 16 16:14:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXDL4-0000lG-Cm
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 16:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088Ab1FPOOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 10:14:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62468 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006Ab1FPOOY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 10:14:24 -0400
Received: by fxm17 with SMTP id 17so1135798fxm.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=s2S9STEZI228x+yTdITGqwSE40xXxZ+ZD3/CyOQPyt8=;
        b=Z6/oMqQyQ2Q3/Rm7zM2j+ddDbfTXYoue9D/UCZX4HvX+InETspbla/Qig40V/doQXU
         14xLpZ/DTH5YK5U4vrB48IGlXZiYM2sXlc7pTmJ3zisYPrFNFy9b05Y53AU/v9AyOgsZ
         cHLnoJj6+nDwBRH05XaDag35XDw9ll07I6gL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=yAyV2fi8f1ZeVr3pU7oQuAStyBN+hh0Eh3mqqZokkV+vQfIpCLfUNV7CAqa9SzE+NX
         sJD/G3KPagrCc9/IC0GRHjjlCk77sk9fS23T0vcT6I7bRyBA8MdhyO9NQrDxu6jYktYi
         JiGQdHq+C9/psxKuQ8BWdyi0ydCGNyI8ch6Ts=
Received: by 10.223.25.201 with SMTP id a9mr1126133fac.141.1308233663599;
        Thu, 16 Jun 2011 07:14:23 -0700 (PDT)
Received: from [192.168.1.15] (abve99.neoplus.adsl.tpnet.pl [83.8.202.99])
        by mx.google.com with ESMTPS id l26sm843882fam.21.2011.06.16.07.14.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 07:14:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTimYsvHqZsxYA34o7s94c9V8vzkHbw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175901>

On Thu, 16 Jun 2011, Geoff Russell wrote:
> 2011/6/16 Jakub Narebski <jnareb@gmail.com>
> >
> > Why did you set packSizeLimit at all?
> 
> Some time ago (31/8/2010) I had a problem which seemed to be caused by
> large packs (>4GB), you can find it in the git list with a subject of
> "Large pack causes git clone failures ... what to do?"

So why did you set packSizeLimit to such ridiculous low value, instead
of 2g (2 GB) or something?

-- 
Jakub Narebski
Poland
