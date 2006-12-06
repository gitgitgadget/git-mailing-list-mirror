X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 06 Dec 2006 17:56:58 +0100
Message-ID: <4576F65A.6010707@xs4all.nl>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061727.54058.jnareb@gmail.com> <4576F29B.6010105@xs4all.nl> <200612061752.39443.jnareb@gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:57:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200612061752.39443.jnareb@gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33490>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs04t-00019x-IZ for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936507AbWLFQ4v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936498AbWLFQ4v
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:56:51 -0500
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:3165 "EHLO
 smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S936507AbWLFQ4t (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 11:56:49 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kB6Gulpg063774 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 6 Dec 2006 17:56:48 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:
> I'm still not sure if this has place in git. Is it really common to
> support building outside source directory? If git didn't support this,
> so what?

lots of serious tools support it, as it this comes automatically
when using automake. Eg. emacs, gcc, make, pango, lilypond, etc etc. 

It's a quite standard feature ; you should be asking why git 
shouldn't support it.

Another option is to make a special solution based on makefiles, so 
make is run inside the srcdir, but output shunted output to a 
separate objects/ subdirectory.  However, it's more work, and less 
standardized.

-- 
