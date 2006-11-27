X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ignacio Arenaza <iarenuno@eteo.mondragon.edu>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method   
	HTTP/1.x  proxying
Date: Mon, 27 Nov 2006 17:27:01 +0100
Message-ID: <67bqmsn9d6.fsf@poseidon.eteo.mondragon.edu>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu><7v64
	d5keke.fsf@assigned-by-dhcp.cox.net><67mz6h6xmb.fsf@poseidon.eteo.mond 
	ragon.edu><7vfyc9cjci.fsf@assigned-by-dhcp.cox.net> 
	<67hcwp6wpp.fsf@poseidon.eteo.mondragon.edu> 
	<7vhcwpawvg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 27 Nov 2006 16:27:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vhcwpawvg.fsf@assigned-by-dhcp.cox.net> (Junio C. 
	Hamano'smessage of "Fri, 24 Nov 2006 03:48:35 -0800")
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.4 (gnu/linux)
X-imss-version: 2.044
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32426>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GojK6-0006NM-3i for gcvg-git@gmane.org; Mon, 27 Nov
 2006 17:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757150AbWK0Q1K convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006 11:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758364AbWK0Q1K
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 11:27:10 -0500
Received: from mx.eteo.mondragon.edu ([193.146.78.131]:29158 "EHLO
 mx.eteo.mondragon.edu") by vger.kernel.org with ESMTP id S1757150AbWK0Q1J
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 11:27:09 -0500
Received: by mx.eteo.mondragon.edu (Postfix, from userid 1001) id 0A609B6B7;
 Mon, 27 Nov 2006 17:27:05 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (poseidon.eteo.mondragon.edu
 [172.31.3.4]) by mx.eteo.mondragon.edu (Postfix) with ESMTP id B585BB6B6;
 Mon, 27 Nov 2006 17:27:01 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (localhost [127.0.0.1]) by
 localhost.eteo.mondragon.edu (Postfix) with ESMTP id 904CC2FD6D; Mon, 27 Nov
 2006 17:27:01 +0100 (CET)
Received: by poseidon.eteo.mondragon.edu (Postfix, from userid 1072)id 
 6BE832FD06; Mon, 27 Nov 2006 17:27:01 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> I deliberately left out the style changes to avoid cluttering
> the patch; as I said in my first response, that should come as a
> separate patch that does not change anything else.

Ok, I've had a look at git-cvsimport.perl and I can't come up with a
consistent style for the 'if () {' sentence. According to grep there
are 50 instances of 'if(...)' and 39 instances of 'if (...)', so I
don't know which is the preferred one. And I can't find a CodingStyle
document either.

Which way should I fix them? And should I fix the whole file, or just
the ones in my original patch?

Saludos. I=F1aki.

--=20
School of Management
Mondragon University
20560 O=F1ati - Spain
+34 943 718009 (ext. 225)

