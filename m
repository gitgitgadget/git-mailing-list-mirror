X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ignacio Arenaza <iarenuno@eteo.mondragon.edu>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method 
	HTTP/1.x  proxying
Date: Fri, 24 Nov 2006 09:43:49 +0100
Message-ID: <67r6vt6xq2.fsf@poseidon.eteo.mondragon.edu>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu><7v64
	d5keke.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 24 Nov 2006 08:44:06 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v64d5keke.fsf@assigned-by-dhcp.cox.net> (Junio C. 
	Hamano'smessage of "Thu, 23 Nov 2006 14:01:37 -0800")
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.4 (gnu/linux)
X-imss-version: 2.044
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32196>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWfA-0007A1-39 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 09:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934467AbWKXIn4 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006 03:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934499AbWKXInz
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 03:43:55 -0500
Received: from mx.eteo.mondragon.edu ([193.146.78.131]:10712 "EHLO
 mx.eteo.mondragon.edu") by vger.kernel.org with ESMTP id S934467AbWKXIny
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 03:43:54 -0500
Received: by mx.eteo.mondragon.edu (Postfix, from userid 1001) id 6A68BB6B5;
 Fri, 24 Nov 2006 09:43:53 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (poseidon.eteo.mondragon.edu
 [172.31.3.4]) by mx.eteo.mondragon.edu (Postfix) with ESMTP id 6FE0EB6B1;
 Fri, 24 Nov 2006 09:43:49 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (localhost [127.0.0.1]) by
 localhost.eteo.mondragon.edu (Postfix) with ESMTP id 4D7982FD65; Fri, 24 Nov
 2006 09:43:49 +0100 (CET)
Received: by poseidon.eteo.mondragon.edu (Postfix, from userid 1072)id 
 3B46A2FD15; Fri, 24 Nov 2006 09:43:49 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> The "I/O Operators" section talks about evaluating <$s> in a
> scalar context (i.e. "$rep =3D <$s>"), which we all know would
> return a single line, and in list context, which swallows
> everything up to EOF, an obvious disaster for this particular
> use.  I couldn't find how it is defined to behave in a void
> context.  By experiments I know this returns only one line, but
> it leaves me feeling somewhat uneasy.

This is scalar context, as we are using the implicit $_ variable as
the destination of the asignment. It seems it's not so obvious for
non-Perl speakers, so I'll use a clearer idiom :-)

Saludos. I=F1aki.

--=20
School of Management
Mondragon University
20560 O=F1ati - Spain
+34 943 718009 (ext. 225)

