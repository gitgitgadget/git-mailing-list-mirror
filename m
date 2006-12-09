X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: doc bug?
Date: Sat, 9 Dec 2006 18:30:08 +0100
Message-ID: <2c6b72b30612090930o7b856223ub87746181f958b7c@mail.gmail.com>
References: <elc64k$t4i$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 17:30:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CunGehD0TSrfOUTTf2WMZntOCqyNi9HADtKVNPUS/CqmGBYbSiKxqZGMbeC5O8mA07/AvhFKl60bBCrCQC30+SJCkklNzzTpGy0uWj/CdkyuU638P2fdsZPkrmWC77nWs9Ztl31TlyGbvrrwF76iNxVsxEivfcAyQ2xgjhheYo4=
In-Reply-To: <elc64k$t4i$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33822>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt61d-0006X3-L3 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 18:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758483AbWLIRaK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 12:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759005AbWLIRaK
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 12:30:10 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:48913 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758483AbWLIRaJ (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 12:30:09 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1110083wxd for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 09:30:08 -0800 (PST)
Received: by 10.90.31.19 with SMTP id e19mr5442244age.1165685408244; Sat, 09
 Dec 2006 09:30:08 -0800 (PST)
Received: by 10.90.68.10 with HTTP; Sat, 9 Dec 2006 09:30:08 -0800 (PST)
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

On 12/8/06, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> Hi,

Hello,

> while messing with GIT's build system, I got
>
> **
> asciidoc -b docbook -d manpage -f ../Documentation/asciidoc.conf ../Documentation/git-tools.txt
> ERROR: git-tools.txt: line 2: malformed manpage title
> ERROR: git-tools.txt: line 6: first section must be named NAME
> ERROR: git-tools.txt: line 9: malformed NAME section body
> FAILED: /home/lilydev/vc/git/Documentation/git-tools.txt: line 9: unexpected error:
> [traceback]
> **
>
> is this a new problem?  I'm on FC6, with  asciidoc 7.0.2

The git-tools.txt document is not intended to be a man page
(there is no git-tools command) so it cannot be converted into
a man page. You should be able to make a HTML document
out of it, although the AsciiDoc formatting is not "optimal".

-- 
