X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT repository not clonable?
Date: Sat, 11 Nov 2006 23:34:28 +0100
Message-ID: <20061111223428.GB20192@diana.vm.bytemark.co.uk>
References: <200611110359.kAB3ul02013227@laptop13.inf.utfsm.cl> <20061111123634.GD11224@diana.vm.bytemark.co.uk> <b0943d9e0611111359t994d688w9bc6aae8e9183fd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 22:34:43 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611111359t994d688w9bc6aae8e9183fd3@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31244>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj1Qo-0000Lt-3G for gcvg-git@gmane.org; Sat, 11 Nov
 2006 23:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754883AbWKKWeb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 17:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754884AbWKKWeb
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 17:34:31 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:39182 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1754883AbWKKWea
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 17:34:30 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gj1Qi-0005HD-00; Sat, 11 Nov 2006 22:34:28 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-11 21:59:32 +0000, Catalin Marinas wrote:

> I've never packed it. IIRC, there was some advise in some GIT
> document or e-mail saying that you shouldn't pack if the export is
> over a dumb protocol. That's good for people pulling regularly but
> bad for cloning.

It's _extremely_ bad when cloning. There's a separate HTTP request for
each object in the repository, which means lots of time and lots of
web server load. It's just about doable to clone the StGIT repository
now because it's so small.

--=20
Karl Hasselstr=F6m, kha@treskal.com
