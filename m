X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Add file addition/deletion indicator in diffstat
Date: Sun, 17 Dec 2006 07:12:58 +0700
Message-ID: <fcaeb9bf0612161612r36470c2fm3c0f19e56f6a16a@mail.gmail.com>
References: <20061111123331.GA23829@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 00:13:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GH1fTnXeOVPF1Pj1qeEdz6oC26R5zIgHt05PRd9J9UwacRfKCW1WZKjW8o0g/QxSN6MLVtGRUBk26qymdX92ZseMbH1Afa4G/oKxlabKPlWitYyjLWAAw+zkvU4ySQnV0VSG08jJ2SaRknlKLcHliAeE/+bU4TMmmBEKChrZRNo=
In-Reply-To: <20061111123331.GA23829@localhost>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34664>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjeL-0005GQ-MD for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422915AbWLQANB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422914AbWLQANB
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:13:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:39162 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1422916AbWLQANA (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 19:13:00 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1533028nfa for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 16:12:58 -0800 (PST)
Received: by 10.78.17.1 with SMTP id 1mr1603682huq.1166314378504; Sat, 16 Dec
 2006 16:12:58 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Sat, 16 Dec 2006 16:12:58 -0800 (PST)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi Junio,

I have used this patch for a while and found it actually useful,
especially while inspecting "git-log --stat". And if you prefer "git
diff --stat" over "git status", it may tell you which file you added
or deleted. So my only guess is that you missed it somehow. If it is
refused, may I know the reason? I can improve it on request :-)

On 11/11/06, pclouds@gmail.com <pclouds@gmail.com> wrote:
> For new files, " (new)" will be appended to filenames.
> For deleted files, " (deleted)" will be appended to filenames.
-- 
