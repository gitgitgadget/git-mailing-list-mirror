X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 23:05:31 +0100
Message-ID: <200610292305.32088.jnareb@gmail.com>
References: <539418.62803.qm@web31807.mail.mud.yahoo.com> <200610292119.05626.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 22:05:58 +0000 (UTC)
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OUESsuDLzjRdofc8AeuCAXCd2UdFv29S2PeIoZ4awisBQUeCa+J0/x5auzDIXoWaVAJicHjXLAeatPbOECCATn6tUbGtrF4ftPXJbhF/Jr9f5JNhbknNU2efYURipHOmLUn6XBngEUqlSw9ThpYy+jWqzqDwhht4e3Gib1jmxxE=
User-Agent: KMail/1.9.3
In-Reply-To: <200610292119.05626.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30468>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeImr-0000vI-Ng for gcvg-git@gmane.org; Sun, 29 Oct
 2006 23:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030375AbWJ2WFf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 17:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWJ2WFf
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 17:05:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:55325 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030375AbWJ2WFd
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 17:05:33 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1017983ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 14:05:31 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr3124228ugm; Sun, 29 Oct 2006
 14:05:31 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 34sm2114068uga.2006.10.29.14.05.31; Sun, 29 Oct
 2006 14:05:31 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:

> The filenames which don't need quoting are not quoted. Only filenames
> which need quoting (which have LF ('\n'), TAB ('\t'), \ ('\\') and " (\"))
> are quoted and surronded in quotes to mark as quoted.

By the way, I think that unquote subroutine in gitweb is broken.
I think I'll try for new patchser view to work for ordinary filenames
(perhaps with metacharacters in them), and only then try to debug
for filenames which need quoting.
-- 
Jakub Narebski
