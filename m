From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/4] plumbing to help fix git-gui
Date: Mon, 12 Oct 2009 00:45:47 -0500
Message-ID: <20091012054546.GF11106@progeny.tock>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <20091012052536.GA11106@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDcb-00039A-2C
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbZJLFh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbZJLFh6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:37:58 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:37980 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbZJLFh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:37:57 -0400
Received: by ywh6 with SMTP id 6so7900248ywh.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 22:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZUupWiEsG2FmZWv+ntGdtTHK2LuTW4GeRMN2VnGK8W4=;
        b=sbcIhIBwCS4jh5fo1i5XkR8mbeDQQRYEcLhaMJvFPif1Wfffe9MgmBpbbmAbjAf2GC
         C2Blo3mLmKunSmzeMYPiLwH5b7ufHTQx1/sBHmvuhmSrFIgEeGJ2ZpFHP+xO6Vzaexq9
         aMPcuTIxtcyssURYWFadg5fHW7VKMc7KbaJwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NI9W4xCRZsuggElKTDUKLFMDBIK5uqXMdszL9Ue2LfsCUpEnXvrAQxoUSpAp9mmjYM
         Vw3xSpROs26U5kMHiN8OJ1lOGNd04xVHohAj1l0/LKuygw0Hj2RfGUdNaBQWt/kPbjsB
         pI/nZX4Vs/fZGXnPaCE9xH4FmKQFqlKp9Cy0g=
Received: by 10.151.16.2 with SMTP id t2mr9379381ybi.176.1255325841364;
        Sun, 11 Oct 2009 22:37:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm906269gxk.0.2009.10.11.22.37.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 22:37:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091012052536.GA11106@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129985>

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>> Perhaps an interface to give a cleaned-up version, e.g.
>> 
>>     $ git check-ref-format --print refs/heads//foo/bar
>>     refs/heads/foo/bar
>> 
>> is what you want in order to fix git-gui?  I dunno.
> 
> The following packages do exactly that.

s/packages/patches/

I better sleep...

Sorry for the confusion,
Jonathan
