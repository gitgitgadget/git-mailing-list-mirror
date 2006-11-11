X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT repository not clonable?
Date: Sat, 11 Nov 2006 13:36:34 +0100
Message-ID: <20061111123634.GD11224@diana.vm.bytemark.co.uk>
References: <200611110359.kAB3ul02013227@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 12:36:51 +0000 (UTC)
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611110359.kAB3ul02013227@laptop13.inf.utfsm.cl>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31221>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gis6F-0003Oj-9Z for gcvg-git@gmane.org; Sat, 11 Nov
 2006 13:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947198AbWKKMgk convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 07:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947199AbWKKMgj
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 07:36:39 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:63241 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1947198AbWKKMgj
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 07:36:39 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gis66-0003Qw-00; Sat, 11 Nov 2006 12:36:34 +0000
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

On 2006-11-11 00:56:47 -0300, Horst H. von Brand wrote:

> I'm trying to update my StGIT repo here, and get a crash from
> git-http-fetch (git 1.4.3.4). Trying to clone it anew gives:
>
> [vonbrand@laptop13 tmp]$ git-clone http://homepage.ntlworld.com/cmari=
nas/stgit.git
> error: Unable to start request
> error: Could not interpret heads/master as something to pull
>
> What am I doing wrong?

It works for me, with

  $ git --version
  git version 1.4.3.3.g8387

But it's horribly slow. Catalin, have you ever packed that repository?

--=20
Karl Hasselstr=F6m, kha@treskal.com
