X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 09:50:29 +0100
Message-ID: <e7bda7770612160050j526c2b86gbabeae13f2ff114a@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612150007.44331.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
	 <200612152242.50472.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
	 <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
	 <Pine.LNX.4.64.0612151747470.3849@woody.osdl.org>
	 <Pine.LNX.4.64.0612151809510.3557@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 08:50:38 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"R. Steve McKown" <rsmckown@yahoo.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DjrVv2HtnF9Pv1b/JljK6mPk/O2oO1JJ9MpTXtkvaJfmVPrc2j6JbBttKB/6pNvwCQi6mH/aiwmtMHJV5//p6DQeEfNCriWgmxniQtsNu8kT27VLo7fGnOluo2fVola491Wx10TATNy8oZi1am6UpFVg5vy/90ATMpaHi/fFD8A=
In-Reply-To: <Pine.LNX.4.64.0612151809510.3557@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34595>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvVFa-00079n-PS for gcvg-git@gmane.org; Sat, 16 Dec
 2006 09:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030799AbWLPIub (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 03:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030802AbWLPIub
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 03:50:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:49390 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1030799AbWLPIua (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 03:50:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1363091nfa for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 00:50:29 -0800 (PST)
Received: by 10.49.64.18 with SMTP id r18mr1320381nfk.1166259029512; Sat, 16
 Dec 2006 00:50:29 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Sat, 16 Dec 2006 00:50:29 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/16/06, Linus Torvalds <torvalds@osdl.org> wrote:

> Side note: that's not to say that I would really see why you'd want to
> have both the tree and the commit SHA1's, and why you seemingly think that
> the links don't need a filename. Hmm?

I really want that file-name back - we can call it a mind short-circuit.

> If you require the tree objects to be in the database, you might as well
> require that the commit object be there. But you could make rules that say
> that subprojects don't need the whole commit history, for example (which
> is just a shallow clone in the subproject).

You have a very good point here, this would give us the history of the
