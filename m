X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ignacio Arenaza <iarenuno@eteo.mondragon.edu>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method 
	HTTP/1.x proxying
Date: Sat, 25 Nov 2006 13:43:19 +0100
Message-ID: <67d57b7l3s.fsf@poseidon.eteo.mondragon.edu>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu> 
	<7v64d5keke.fsf@assigned-by-dhcp.cox.net><45661C36.9010101@catalyst.net.nz>
	<7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net><46a038f90611231552x3e33eec4w7863c
	e6a1d a5781b@mail.gmail.com><7v7ixlhesv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 25 Nov 2006 12:43:48 +0000 (UTC)
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v7ixlhesv.fsf@assigned-by-dhcp.cox.net> (Junio C. 
	Hamano'smessage of "Thu, 23 Nov 2006 16:24:48 -0800")
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.4 (gnu/linux)
X-imss-version: 2.044
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32285>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnwse-0002TR-VT for gcvg-git@gmane.org; Sat, 25 Nov
 2006 13:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966535AbWKYMn2 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006 07:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966537AbWKYMn2
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 07:43:28 -0500
Received: from mx.eteo.mondragon.edu ([193.146.78.131]:13518 "EHLO
 mx.eteo.mondragon.edu") by vger.kernel.org with ESMTP id S966535AbWKYMn1
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 07:43:27 -0500
Received: by mx.eteo.mondragon.edu (Postfix, from userid 1001) id B8E36B6AF;
 Sat, 25 Nov 2006 13:43:23 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (poseidon.eteo.mondragon.edu
 [172.31.3.4]) by mx.eteo.mondragon.edu (Postfix) with ESMTP id 0260CB6AE;
 Sat, 25 Nov 2006 13:43:19 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (localhost [127.0.0.1]) by
 localhost.eteo.mondragon.edu (Postfix) with ESMTP id CC5082FDB2; Sat, 25 Nov
 2006 13:43:19 +0100 (CET)
Received: by poseidon.eteo.mondragon.edu (Postfix, from userid 1072)id 
 B2DA62FD06; Sat, 25 Nov 2006 13:43:19 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>>> It is more about HTTP proxying and it is my understanding that
>>> response to CONNECT method request has that empty line after the
>>> successful (2xx) response line and zero or more response
>>> headers.  The code is still wrong; it does not have a loop to
>>> discard the potential response headers that come before the
>>> empty line the code we are discussing discards.

I don't have the original message from Junio where he asks where the
proxy behaviour is officially specified (as the draft has expired long
ago), so I'll answer it here.

There is a comment in the code that says the relevant RFC is 2817,
sections 5.2 and 5.3.

Saludos. I=F1aki.

--=20
School of Management
Mondragon University
20560 O=F1ati - Spain
+34 943 718009 (ext. 225)

