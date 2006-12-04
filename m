X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 4 Dec 2006 21:26:09 +0100
Message-ID: <e7bda7770612041226j4d4a5584m279afa9a2d7dfe74@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612012306.41410.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
	 <4570AF8F.1000801@stephan-feder.de>
	 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
	 <4570BFA4.8070903@stephan-feder.de>
	 <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
	 <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
	 <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com>
	 <Pine.LNX.4.64.0612030946150.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 20:26:30 +0000 (UTC)
Cc: sf-gmane@stephan-feder.de, sf <sf@b-i-t.de>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sPfpixxjZGHjT0KaNHVaiZ942PaBA+egAsJbOAdyfsmk1cfLQbvnu5Y8g8VXDEArGhFJVb65mWyPjjK+Hi1MSKQpuOlsVMYsJ8a4EFz7x3O7dOi/oDr9V9QnZirLiEKwX3B4XzsBiryNjYMzxXHZIKvyGZ7Q5BHNtYbdqGu+Dcw=
In-Reply-To: <Pine.LNX.4.64.0612030946150.3476@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33240>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKOJ-0007PG-56 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937374AbWLDU0P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937373AbWLDU0P
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:26:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:23063 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937370AbWLDU0N (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 15:26:13 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3157nfa for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 12:26:10 -0800 (PST)
Received: by 10.49.68.6 with SMTP id v6mr21084181nfk.1165263969969; Mon, 04
 Dec 2006 12:26:09 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Mon, 4 Dec 2006 12:26:09 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/3/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> > If you have an old irrelevant submodule in the history that happens to
> > have the same name as one of them you are interested in, do you get
> > this as well?
>
> It could be "solved" by simply having the requirement that all modules
> need to be named differently (notice that "module name" is _not_ the same
> thing as "the directory name where the module shows up".

Okay, missed that part.  I wasn't familiar with contents of the CVS
modules files and misinterpreted your suggestion.

MODULE [OPTIONS] [&OTHERMODULE...] [DIR] [FILES]

So all this is UI only and the "normal" operations on the supermodule
