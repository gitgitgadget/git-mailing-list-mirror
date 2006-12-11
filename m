X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: doc bug?
Date: Mon, 11 Dec 2006 14:54:42 +0100
Message-ID: <457D6322.2020308@xs4all.nl>
References: <elc64k$t4i$1@sea.gmane.org> <7vslfodi7b.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 13:54:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vslfodi7b.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34005>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtlc7-0006E1-Pl for gcvg-git@gmane.org; Mon, 11 Dec
 2006 14:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932068AbWLKNyg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 08:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762918AbWLKNyg
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 08:54:36 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:4225 "EHLO
 smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1762919AbWLKNyg (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 08:54:36 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kBBDsVTU064241 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Mon, 11 Dec 2006 14:54:32 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
>> asciidoc -b docbook -d manpage -f ../Documentation/asciidoc.conf ../Documentation/git-tools.txt
>> ERROR: git-tools.txt: line 2: malformed manpage title
>> ERROR: git-tools.txt: line 6: first section must be named NAME
>> ERROR: git-tools.txt: line 9: malformed NAME section body
>> FAILED: /home/lilydev/vc/git/Documentation/git-tools.txt: line 9: unexpected error:
 
> So that means you may have found a bug in our Makefile, or your
> make (by the way I think we pretty much requires GNU make to
> build git), or perhaps both.

Hi,

it was my bad, caused by me tweaking the Makefiles.  I will be posting
the last version of my separate builddir patch separately, with
support for the documentation as well.  Can you have a look so I know
whether it's worth investing any more time in? 

Unfortunately, asciidoc doesn't seem to support a --include-path
option or similar, so I can't get the documentation support to work
completely.

-- 
