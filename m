X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Cleaning up git user-interface warts
Date: Mon, 20 Nov 2006 16:44:12 -0300
Message-ID: <200611201944.kAKJiCAw014973@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
NNTP-Posting-Date: Mon, 20 Nov 2006 19:44:50 +0000 (UTC)
Cc: hanwen@xs4all.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Thu, 16 Nov 2006 03:47:31 -0800." <7vslgjaa0c.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 20 Nov 2006 16:44:13 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31929>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmF44-0007FS-U1 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 20:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966573AbWKTToU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966579AbWKTToU
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 14:44:20 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27093 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S966573AbWKTToT (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 14:44:19 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kAKJiDiO005674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Mon, 20
 Nov 2006 16:44:13 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kAKJiCAw014973; Mon, 20
 Nov 2006 16:44:12 -0300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> >
> >> [hanwen@haring y]$ git pull ../x
> >> fatal: Needed a single revision
> >> Pulling into a black hole?
> 
> Having said all that, I happen to think that this particular
> case of pulling into void could deserve to be special cased to
> pretend it is a fast forward (after all, nothingness is an
> ancestor of anything), if only to make new people's first
> experience more pleasant.

If you make pushing into an empty repository work also, you fix the case of
"create an empty repo for somebody, let them fill it up remotely later".

[...]

> So please consider that this is classified as a bug.

Thanks!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
