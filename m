X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] merge-recursive: make empty tree a known object
Date: Sun, 10 Dec 2006 14:54:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101454000.12500@woody.osdl.org>
References: <20061207101707.GA19139@spearce.org>
 <Pine.LNX.4.63.0612100055390.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612101030390.12500@woody.osdl.org> <7vpsar4fcu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612101326420.12500@woody.osdl.org> <7vlklf2xgd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 22:54:42 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vlklf2xgd.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33951>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXZ4-0004d4-5E for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762358AbWLJWyb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761825AbWLJWyb
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:54:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44321 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1761625AbWLJWya
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:54:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAMsMID028200
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 14:54:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAMsLW0005862; Sun, 10 Dec
 2006 14:54:21 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Junio C Hamano wrote:

> > In contrast, the empty tree clearly ends up being an interesting special 
> > case that actually gets used occasionally, ie here we had two independent 
> > uses for the same thing..
> 
> Two?

merge-recursive and "diff against root"

