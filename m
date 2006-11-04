X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-format-patch little gripe
Date: Sat, 4 Nov 2006 02:05:21 +0100
Message-ID: <200611040205.22305.jnareb@gmail.com>
References: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net> <eigjql$ql$2@sea.gmane.org> <Pine.LNX.4.64.0611031640140.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 4 Nov 2006 01:05:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T81Ir6K7pNXJQthyy+2Ctp1hG+6/+C4z1wy4f0c4evXmXbbCKKtihbeIUWtLXXR43Vm9Cwk7pe7z9SkLcbeZx/Ej9PGUXIRLKSFVZfB2xC1S27tTX6H2rr9go/0FnhXe+ee4hH8JjeGYOSMUzPT+Hvft9X/9iKsc6F+h97Cqn4A=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0611031640140.25218@g5.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30902>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg9y0-0004Xl-O1 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 02:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932554AbWKDBE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 20:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWKDBE5
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 20:04:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:51145 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932554AbWKDBE4
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 20:04:56 -0500
Received: by ug-out-1314.google.com with SMTP id m3so548065ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 17:04:55 -0800 (PST)
Received: by 10.67.121.18 with SMTP id y18mr3612191ugm.1162602294912; Fri, 03
 Nov 2006 17:04:54 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 32sm1675094ugf.2006.11.03.17.04.54; Fri, 03 Nov
 2006 17:04:54 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 4 Nov 2006, Jakub Narebski wrote:
>>
>> YAUO, Yet Another Undocumented Option. ::sigh::
> 
> The "--pretty=xxx" is certainly not new, and it's not even totally 
> undocumented. It's mentioned in several of the examples in various forms.
> 
> All the logging commands take the "pretty" argument.
> 
> Try
> 
> 	git log --pretty={oneline,short,medium,full,fuller,raw}
> 
> (and the same things work for "git whatchanged" and "git show" etc)

I meant git show --pretty=email option. Sorry for confusion.

-- 
Jakub Narebski
