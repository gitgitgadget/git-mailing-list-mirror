X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Bahadir Balban" <bahadir.balban@gmail.com>
Subject: Re: Adding a new file as if it had existed
Date: Tue, 12 Dec 2006 11:32:28 +0000
Message-ID: <7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com>
References: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com>
	 <7vhcw1whfx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 11:32:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R3f9b0PX4wq39enhjsdNzhk/vCXps6vHbaGRxcyzTOx+Bng4OFZgTb/53UDGSVjJ8egDNqKhfKslK+xlQ6Qz9FhnOcVTz30AhHHFMIbYpZEdt/yThuw+nxAfVjsOc8NJHtPwPOmF1+T4gP2oOdWi5BUVniZ6xXNqxvM6zTcqXbQ=
In-Reply-To: <7vhcw1whfx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34083>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu5s9-0000yH-45 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 12:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751231AbWLLLca (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 06:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWLLLca
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 06:32:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:13422 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751231AbWLLLc3 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 06:32:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so212220nfa for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 03:32:28 -0800 (PST)
Received: by 10.82.169.4 with SMTP id r4mr1294824bue.1165923148114; Tue, 12
 Dec 2006 03:32:28 -0800 (PST)
Received: by 10.82.186.15 with HTTP; Tue, 12 Dec 2006 03:32:28 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 12/12/06, Junio C Hamano <junkio@cox.net> wrote:
> No.
>
> I do not understand why not adding all the files you care about
> eventually anyway in the initial commit is needed for
> "performance reasons", if you do not touch majority of them for
> a long time.  Care to explain?

If I don't know which files I may be touching in the future for
implementing some feature, then I am obliged to add all the files even
if they are irrelevant. I said "performance reasons" assuming all the
file hashes need checked for every commit -a to see if they're
changed, but I just tried on a PIII and it seems not so slow.

