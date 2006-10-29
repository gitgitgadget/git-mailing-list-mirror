X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Sun, 29 Oct 2006 16:03:36 -0300
Message-ID: <200610291903.k9TJ3am7017976@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
NNTP-Posting-Date: Sun, 29 Oct 2006 19:05:52 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Sat, 28 Oct 2006 12:04:24 PDT." <7vmz7g8don.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 29 Oct 2006 16:03:40 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30439>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeFyK-0002Ns-17 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932429AbWJ2TFR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWJ2TFR
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:05:17 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:1414 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S932429AbWJ2TFQ (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:05:16 -0500
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net
 [200.83.245.232]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 k9TJ3cAQ025050 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Sun, 29 Oct 2006 16:03:39 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9TJ3am7017976; Sun, 29
 Oct 2006 16:03:36 -0300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:

[...]

> and here is what I have:
> 
>    asciidoc-7.0.2-3.fc6
>    xmlto-0.0.18-13.1
>    python-2.4.3-18.fc6
>    docbook-dtds-1.0-30.1
>    package docbook-xsl is not installed
>    flex-2.5.4a-41.fc6
>    libxslt-1.1.17-1.1
>    passivetex-1.25-5.1.1
>    util-linux-2.13-0.44.fc6
>    w3m-0.5.1-14.1

I've got:

asciidoc-7.0.2-3.fc6
xmlto-0.0.18-13.1
python-2.4.4-1.fc7
docbook-dtds-1.0-30.1
package docbook-xsl is not installed
flex-2.5.4a-41.fc6
libxslt-1.1.18-1
passivetex-1.25-5.1.1
util-linux-2.13-0.44.fc6
w3m-0.5.1-14.1

> "rpm -q --whatprovides docbook-xsl" says:
> 
>    docbook-style-xsl-1.69.1-5.1

docbook-style-xsl-1.69.1-5.1

Differences are (mine (Junio's)):

python-2.4.4-1.fc7 (python-2.4.3-18.fc6)
libxslt-1.1.18-1 (libxslt-1.1.17-1.1)

libxslt requires libxml2:

libxml2-2.6.27-1 (Fedora 6 has libxml2-2.6.26-2.1.1)

Getting the Fedora 6 libxslt (Junio's) and redoing git gives no errors.

Judging from the libxslt changelog <http://xmlsoft.org/XSLT/news.html> they
tightened up the processing, so I'd guess asciidoc is generating fishy XML
or xmlto is broken. I've no clue here... somebody knowledgeable who can
take a closer look or otherwise lend me a hand?

Thanks!

PS: I get similar errors with tig...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

