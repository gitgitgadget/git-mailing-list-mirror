X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] git-branch: add options and tests for branch renaming
Date: Tue, 28 Nov 2006 17:10:30 +0100
Message-ID: <8c5c35580611280810g2214ec8cs7406653c319be6fc@mail.gmail.com>
References: <11647252603530-git-send-email-hjemli@gmail.com>
	 <456C4FCE.6090306@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 16:11:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iZbXFgc3uj0v+RR6VGnP/6VS9oz03zR8Tt51VbwOwHmEnAxiq7CDeDsKi5GJyGuJZ+l+ehrUqifBoK1V89ST1CNf+p4Nw5zTWBRmzZliyM01S7HXb5+HXbA7JiDz1usRqmzhOTsxCCWISKptWuL4BQkbshpetx0Zrz4WceQPPqo=
In-Reply-To: <456C4FCE.6090306@shadowen.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32544>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp5XY-0002Vh-48 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 17:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758700AbWK1QKd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 11:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758701AbWK1QKd
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 11:10:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:64140 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1758700AbWK1QKc
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 11:10:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2615159nfa for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 08:10:31 -0800 (PST)
Received: by 10.82.129.8 with SMTP id b8mr193777bud.1164730230698; Tue, 28
 Nov 2006 08:10:30 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Tue, 28 Nov 2006 08:10:30 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/28/06, Andy Whitcroft <apw@shadowen.org> wrote:
> Perhaps I want a rename to just put a rename from in the top
> of the new reflog and leave the old there.

That is what happens when you do

  git branch -l topic master

The first entry in reflog for 'topic' will say:

  Branch: created from master

--
