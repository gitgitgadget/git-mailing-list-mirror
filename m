From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Thu, 21 Oct 2010 17:03:05 -0500
Message-ID: <20101021220305.GA13142@burratino>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
 <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 <7vbp6vduly.fsf@alter.siamese.dyndns.org>
 <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
 <20101018163134.GA6343@burratino>
 <AANLkTik3Di=dcC=CxW+Lou515E2wXq8_OaR99mghC+vF@mail.gmail.com>
 <AANLkTi=ydzrvy6_PbFLpA_qcHzF-8s3xbu3XvU5GnQ_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 00:07:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P93Hw-0001BT-0f
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 00:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932Ab0JUWG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 18:06:56 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49695 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926Ab0JUWGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 18:06:53 -0400
Received: by qwk3 with SMTP id 3so85879qwk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bt/pn0THDsRFKyK/UHB/U54X3EqLs1sif1pmnUze1EA=;
        b=l+y6ThpQSGeLKQW/tVhLIiCWLCXnjv1ICIAcyqS6C3DwsEuM6ABLjBZ9OrAQ37NLMq
         06Hxt6r++eKZKc96MzzuNra3xVYpRguQ7G4hKbfxSNacXKZOzTwwuX02Ywm8vn5gNo6g
         LCpvA/eXn5tBEDikwWjAMRDF9JRCQBR3zvxjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G2Y0SO6HU8NOZ27MHeCaKAnqjLnLtkhuac255mXVGw7sdNS4sXEA1Eyv7fk/NsjI4j
         p/c7KHI44Yikx+ita7PFknUS64x/8nPfWCbrDwQlEdRXzAjUJ2eBGwKlyd66HxzJGAKi
         iFv093LBe7wRIGqR8Gjdd2sr2TwCtzKmfmwOs=
Received: by 10.229.238.193 with SMTP id kt1mr1259557qcb.292.1287698812664;
        Thu, 21 Oct 2010 15:06:52 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm1884748qck.1.2010.10.21.15.06.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 15:06:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ydzrvy6_PbFLpA_qcHzF-8s3xbu3XvU5GnQ_k@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159579>

Hi Erik,

Erik Faye-Lund wrote:

> OK, I did another stab at this, and this is the best I could come up
> with right now, what do you think?

Much clearer; thanks.
