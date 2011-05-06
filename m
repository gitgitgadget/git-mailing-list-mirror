From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Thu, 5 May 2011 20:28:24 -0500
Message-ID: <20110506012823.GA9114@elie>
References: <20110505185907.GD1377@goldbirke>
 <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 03:28:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI9qb-00053w-2s
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 03:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab1EFB2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 21:28:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64824 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab1EFB2a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 21:28:30 -0400
Received: by iwn34 with SMTP id 34so2303054iwn.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4fIiGDDNvO/BthotmxkMYvtGnbQhLAFWh4YckEIFDjU=;
        b=h3W5nRIvUse/ZO7HDlOylZ82F7inD+gg0waWv2lR4C5Wo0981kSWB2jp0M22AZwYZd
         zk+3J36Nc1gj5qT4c4VcfEXq3chG9qUqGFFwx1pRts91v9zd4+sBlDH73HNeel9/iKrB
         S4YRlEU/r7+WGjdoULtKsQssl1NBuA4dWRxkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rc84i9MvybZm609iNMsnrPqVZpSJWhBdAoNJnd4tDeqvAsuPSzvs/lDXMWODv+mUF4
         Toj3HlXmvo/ck3rQMBU4s29iXRhDQg4dH5exGIWQaadj1TxC1L1Vto8OJdwhya1DCNIl
         kTv+8bBOR4Xt+HOk0fvX2wS0eaG07xpz5Rw+0=
Received: by 10.42.96.135 with SMTP id j7mr1914617icn.245.1304645309967;
        Thu, 05 May 2011 18:28:29 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id o3sm1114159ibd.61.2011.05.05.18.28.27
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 18:28:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172931>

Hi,

=46elipe Contreras wrote:

> Currently zsh is completely broken after commit da48616 (bash: get
> --pretty=3Dm<tab> completion to work with bash v4)

I forgot to say: thanks to you and G=C3=A1bor for working on this!  I'v=
e
been grumpy lately but that is not your fault.  I am very happy to
see someone using the zsh support and keeping an eye on bugs and code
cleanliness.
