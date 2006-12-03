X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 10:19:13 +0100
Message-ID: <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de>
	 <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
	 <200612012306.41410.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
	 <4570AF8F.1000801@stephan-feder.de>
	 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
	 <4570BFA4.8070903@stephan-feder.de>
	 <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
	 <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 09:19:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gsyn0jtM0VRdwYagcvprgnIJbf19lEbnoqXv0TYbIMpACWUNK2NgYXYEQ4xC47sWiST7CwqueJQ8Ip14Jtn+zmfPpacR6pDY1wJKNh1rx9EEyrC1dZz6/7n70lqPH8m0PqSw+OFSvehDe/kQdQYy5kXX6fQ/OKzjwCYTmAql2eo=
In-Reply-To: <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33100>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqnVH-0007Nv-IB for gcvg-git@gmane.org; Sun, 03 Dec
 2006 10:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935708AbWLCJTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 04:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935710AbWLCJTQ
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 04:19:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:9047 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S935708AbWLCJTP
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 04:19:15 -0500
Received: by nf-out-0910.google.com with SMTP id o25so4049919nfa for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 01:19:14 -0800 (PST)
Received: by 10.49.10.17 with SMTP id n17mr11521678nfi.1165137554038; Sun, 03
 Dec 2006 01:19:14 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Sun, 3 Dec 2006 01:19:13 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>, sf-gmane@stephan-feder.de, sf
 <sf@b-i-t.de>, git@vger.kernel.org, "Martin Waitz" <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On 12/2/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> In other words, I don't think people expect or want something hugely more
> complicated than the CVS/modules kind of file.

What about the case when you want _everything_, do you then have to
know the names of all submodules, present and past?

If you have an old irrelevant submodule in the history that happens to
have the same name as one of them you are interested in, do you get
this as well?

During a debugging session it might be convenient to do a "all but X"
kind of fetch if you have a project dependent on several small modules
and one of them is the big black sheep.

For simple cases, I think it's sufficient to have the "everyone or
no-one" option. If git enforces sending submodules one by one and
requires the fetching side to specify links explicitly couldn't the
selection be left to the user to decide with "hooks" or plumbing?
Default hook could implement a simple white- or black-list.

