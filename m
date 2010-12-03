From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 14:55:34 -0600
Message-ID: <20101203205534.GA15658@burratino>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
 <7v8w07rje3.fsf@alter.siamese.dyndns.org>
 <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
 <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
 <20101203175212.GA8267@sigill.intra.peff.net>
 <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
 <20101203202923.GB15517@burratino>
 <AANLkTin94XN8_+q8a1EdfY3ySqJpx_j9megQYsq8a8ux@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:55:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcfc-0000D8-GR
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab0LCUzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:55:51 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43335 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab0LCUzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:55:51 -0500
Received: by vws16 with SMTP id 16so1994625vws.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 12:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M6cyEzn06Lvj1Bb+ADTmZ0TwaRpi4r8OY27AAQdxNes=;
        b=s9pxFaCOJetHUbjYhRG4JR65bb6HQcIMLMCjmoYkRgtbtZo5KrFloPZ+iSeeC6PSLz
         aetCK3J1kuZE0QPtct+ZnkWfe252RLp6k/681OfBi+DfvQeEhUGlPQ4IJN4j96VubsHB
         W3NSMtA8hehvlYMMjlFXci2r94ilQWv9WeqqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c4oA3hqOl0LVF2TvN6icdijVkUEfBCMzOVxxGVfXPDruokOVrIjFyeqHLZsdodZ2to
         Eo1qgOhUz6iOUv8HI1Uk9bEvPLAcshxboSnSxLAx8N5CaImGPsdyIb/baBreuXiBbBVo
         2HyTS/srL2KDs5z1W68WJDjwTXWG2moV6Uh0U=
Received: by 10.220.179.199 with SMTP id br7mr506844vcb.195.1291409750177;
        Fri, 03 Dec 2010 12:55:50 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id j7sm404562vcr.39.2010.12.03.12.55.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 12:55:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTin94XN8_+q8a1EdfY3ySqJpx_j9megQYsq8a8ux@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162850>

Eugene Sajine wrote:

> ::SourceMode1 SourceMode2 resultMode Source1-SHA1 Source2-SHA1 resultingSHA1 MM path/to/file
[...]
> 1. a) Why this exact output is not provided in "git log --raw" or in
> "git whatchanged" for the merge commits? b) Can it be provided?

Sorry to be opaque.  "git log" et al accept -c too, of course. :)  I pointed
to diff-tree because it seems you are scripting, so its simplicity and
better guarantees about long-term compatibility might be appealing.

Cheers,
Jonathan
