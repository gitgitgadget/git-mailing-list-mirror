X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Fri, 27 Oct 2006 20:12:50 -0300
Message-ID: <200610272312.k9RNCo2Q002623@laptop13.inf.utfsm.cl>
References: <seanlkml@sympatico.ca>
NNTP-Posting-Date: Sat, 28 Oct 2006 01:16:34 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Sean <seanlkml@sympatico.ca> 
   of "Fri, 27 Oct 2006 15:44:33 EDT." <BAYC1-PASMTP0795BBAE2A844A93124A67AE040@CEZ.ICE> <20061027154433.da9b29d7.seanlkml@sympatico.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 27 Oct 2006 22:10:42 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30354>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdckp-0006Yb-Vm for gcvg-git@gmane.org; Sat, 28 Oct
 2006 03:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751502AbWJ1BMw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 21:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWJ1BMw
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 21:12:52 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46234 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1751502AbWJ1BMv (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 21:12:51 -0400
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net
 [200.83.245.232]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 k9S1Adpi030605 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Fri, 27 Oct 2006 22:10:41 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9RNCo2Q002623; Fri, 27
 Oct 2006 20:12:50 -0300
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:

> On Fri, 27 Oct 2006 14:26:53 -0300
> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> 
> > I'm getting lots of these after today's pull:
> > 
> > asciidoc -b docbook -d manpage -f asciidoc.conf git-daemon.txt
> > xmlto -m callouts.xsl man git-daemon.xml
> > error : unterminated entity reference                
> > error : unterminated entity reference                
> > error : unterminated entity reference             ...
> > error : unterminated entity reference                
> > error : unterminated entity reference                
> > Writing git-daemon.1 for refentry
> 
> Can't reproduce this here on master or on next with:
>  asciidoc-7.1.2-0 and xmlto-0.0.18-13.1
> Maybe this is an Asciidoc 8 issue, are you using it?

Fedora rawhide i386, with:

  asciidoc-7.0.2-3.fc6
  xmlto-0.0.18-13.1

Perhaps too old, not too new...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
