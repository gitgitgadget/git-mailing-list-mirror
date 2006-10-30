X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Tue, 31 Oct 2006 00:32:09 +0100
Message-ID: <200610310032.09726.jnareb@gmail.com>
References: <92622.251.qm@web31812.mail.mud.yahoo.com> <200610301458.33634.jnareb@gmail.com> <7v7iyhv29o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 23:32:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JTZGwNnI7PcqmgAovTYRj2TI45CZCpo0Xhr0Jybdk2J1KT3SvdNCe2opAHvKsUuf6tFK3Kv63HYXJ6owM/jHuulFv5rk+WxqPzkCmrJAm8Ioqfgb5Ip4MT4APxX/5EppzKGfQ6HnGuQTTiVCKvKXu0HuHs+IRDyAAroqas1pdpE=
User-Agent: KMail/1.9.3
In-Reply-To: <7v7iyhv29o.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30554>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gegc3-0006Ae-U1 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 00:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422744AbWJ3XcM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 18:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWJ3XcM
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 18:32:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:47422 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1422751AbWJ3XcK
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 18:32:10 -0500
Received: by ug-out-1314.google.com with SMTP id z34so1124783ugc for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 15:32:07 -0800 (PST)
Received: by 10.66.220.17 with SMTP id s17mr5086304ugg; Mon, 30 Oct 2006
 15:32:07 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 5sm3527055ugc.2006.10.30.15.32.07; Mon, 30 Oct
 2006 15:32:07 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> I have realized that it is not as easy as it sounds, at least for the
>> git-diff-tree output...
> 
> I do not think so.a The output is designed to be machine
> parsable.  See Documentation/diff-format.txt and also please
> refer to 65a9289d:diff-helper.c for a sample code to see how to
> parse the output.

What I wanted to say is that the output is not easy to use in
"split first, parse later", with sometimes counting number of entries
in between. With current format you rather have to pass in one go,
for '-z' format reading filenames from the stream.

By the way, git-ls-tree -z uses TAB as a start of filename, while
git-diff-tree -z uses NUL as a start of (first) filename. Why?
-- 
Jakub Narebski
