X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: index manipulation quickref
Date: Wed, 13 Dec 2006 04:32:15 +0700
Message-ID: <fcaeb9bf0612121332m51dea9day2f18c80b94ff4d5d@mail.gmail.com>
References: <fcaeb9bf0612120257p35dc9483ob65eea9ae21b5f7b@mail.gmail.com>
	 <7vac1tvuyr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 21:32:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GBkzHHgtZowrYXM2Ikc6LhbGcePk/0diwWyweRVrezq8CKjx2JZlITb+AK/Dm3aZurJxcLlatJMssiHlt5A2pcQJprCd525std+E94dE8WzRVZ1CjA+y/WqDFgACWfai4TqT+6t+ye7SFnUyisjXLb4+sS5sn3AMqW8oOB+v7L4=
In-Reply-To: <7vac1tvuyr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34146>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuFEc-0003uh-KN for gcvg-git@gmane.org; Tue, 12 Dec
 2006 22:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932443AbWLLVcT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 16:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWLLVcS
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 16:32:18 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:9539 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932402AbWLLVcS (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 16:32:18 -0500
Received: by an-out-0708.google.com with SMTP id b33so462674ana for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 13:32:16 -0800 (PST)
Received: by 10.78.81.20 with SMTP id e20mr19119hub.1165959135597; Tue, 12
 Dec 2006 13:32:15 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Tue, 12 Dec 2006 13:32:15 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/13/06, Junio C Hamano <junkio@cox.net> wrote:
> I think this goes in the wrong direction.  For "newbies" the
> Porcelain-ish set is supposed to be enough and if there is
> something missing that they need to do update-index command
> itself or a pipeline that involves update-index to achieve
> common tasks, we should enhance Porcelain-ish that captures the
> pattern.

It is supposed to be porcelain command only. I figure what operation a
user may need when manipulating index, then find the corresponding
porcelain command.

As you can see, we have porcelain commands for most of operations. The
missing piece is reset a file in index (and maybe "git cat-file
::file" -- it's too cryptic). Hopefully "git reset -- file" will be
implemented soon.
-- 
