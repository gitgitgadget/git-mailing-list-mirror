From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Mon, 10 May 2010 18:03:21 +0400
Message-ID: <20100510140321.GF14069@dpotapov.dyndns.org>
References: <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
 <20100509070043.GB14069@dpotapov.dyndns.org>
 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
 <AANLkTikRJ6Hl_fRNRZbxeNNgwv9UTm2fPrOKv4GbT0qJ@mail.gmail.com>
 <E6434515-5357-4FF4-8049-5E4FCE8B29E4@gmail.com>
 <AANLkTikg7Tc6zJvfBELBQoeAxebFenNLivEs92j8c83D@mail.gmail.com>
 <91F47297-A1B5-4AE5-8835-E3A8E452FB8A@gmail.com>
 <AANLkTilDiP_5Q9HrssB0lyf-jsE8LAF2ULGwEMO4BzdQ@mail.gmail.com>
 <AANLkTikYUypxH5WhCOMby_zpHsnHEFyix5MGpD96FVWD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 16:03:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBTa7-0005Nh-UJ
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 16:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab0EJODa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 10:03:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62739 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303Ab0EJOD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 10:03:27 -0400
Received: by fxm7 with SMTP id 7so115911fxm.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HSDbi+TF6c0NWwN6jJHcF9cVZwkgABorTBLwWGMaNPk=;
        b=Lr82pVTjx2azj06V2TLUdy3+scehLe7abeKIx2g+wsALcQqUiZniBl92Dh+PpUSjSy
         0cGAGg7XSlgCpG4bz9JtCnn5zECa9de+PAd7mehaQkeT8dTqGZ5jO5dx2Hbb6tMteNe+
         w0IbXr/YoOF0djk5Gtj3IXi1qU2LSIaStdtxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mwNWyrzQzA0S5+7tiSYEsNw4CVq7jmuSFKmjt/35mBjk3mGAEivBUzSJPBBxFXeOSc
         oc5w8fhyvpsop7mVcvSGY2HsEfNw3HTbmuOVrjsfFf6CrkPnP3+NVbt2OuGQao4hXhJn
         vyefzpbdn/rPS/lRm97GM+rWXLhlH1cjpCu0M=
Received: by 10.223.27.151 with SMTP id i23mr4307334fac.104.1273500205109;
        Mon, 10 May 2010 07:03:25 -0700 (PDT)
Received: from localhost (ppp91-76-18-177.pppoe.mtu-net.ru [91.76.18.177])
        by mx.google.com with ESMTPS id j23sm21637248faa.14.2010.05.10.07.03.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 07:03:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikYUypxH5WhCOMby_zpHsnHEFyix5MGpD96FVWD@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146816>

On Mon, May 10, 2010 at 09:25:11AM -0400, Robert Buck wrote:
> Today I am writing up some documentation related to Git use at the
> company, and planning to check in all the data from Git vs Hg testing,
> and all on-boarding/first-day documentation related to Git use. So
> within the directory containing all these files I init-ed the
> repository and got this when I attempted to add multiple files. Mind
> you, this is on Linux!
> 
>   "warning: LF will be replaced by CRLF"

It looks like you set core.autocrlf to true on Linux.

The problem is core.autocrlf says two things -- whether you want to
enable automatic eol conversion for text files and whether you have CRLF
for text files. Only if the answer is "yes" to both then you should set
it to true. In other words, you should never set it to true on Linux.

You may want use core.autocrlf=input on Linux to avoid text files being
accidentally commit with a wrong encoding, when they were copied from
Windows directly.

> 
> This _really_ of scares me being that this was on Linux. Is this one
> of the problem spots that the topic of this thread attempts to
> resolve?

Yes, we want to have a separate setting, whihc will tell what is EOL on
your system, and it should have sensible default, i.e. LF on Linux and
CRLF on Windows.


Dmitry
