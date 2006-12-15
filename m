X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: git-fetching from a big repository is slow
Date: Fri, 15 Dec 2006 21:49:13 +0000 (UTC)
Message-ID: <loom.20061215T223909-156@post.gmane.org>
References: <20061214194636.GO1747@spearce.org> <200612142212.kBEMCVeu032626@laptop13.inf.utfsm.cl> <20061214223813.GC26202@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 15 Dec 2006 21:49:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.99.93 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34556>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvKvq-0005l0-C0 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965160AbWLOVt0 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006 16:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWLOVt0
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:49:26 -0500
Received: from main.gmane.org ([80.91.229.2]:46805 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S965160AbWLOVtZ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 16:49:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvKvh-0001V1-1w for git@vger.kernel.org; Fri, 15 Dec 2006 22:49:21 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 22:49:21 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 22:49:21 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce <at> spearce.org> writes:

> identical class file given the same input.  I've seen times where
> it doesn't thanks to the automatic serialVersionUID field being
> somewhat randomly generated.

Probably offline, but=E2=80=A6 serialVersionUID isn't randomly generate=
d. It's
calculated using the types of fields in the class, recursively. The act=
ual
algorithm is quite arbitrary, but not random. The automatically generat=
ed
serialVersionUID should change only if you add/remove class fields (eit=
her on
the class itself, or to the class of nested objects).

*sigh* Java chases me. 8+ hours of java work everyday, and when I final=
ly get
home=E2=80=A6 there it is, looking at me again. *sob*

-- Pazu
