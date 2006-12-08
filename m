X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git pull and merging.
Date: Fri, 8 Dec 2006 03:04:21 +0100
Message-ID: <8aa486160612071804t63a86b5ate6b17d8ddcf90a60@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <200612061744.31213.Josef.Weidendorfer@gmx.de>
	 <4577B8C0.3060200@gmail.com>
	 <200612071227.46194.Josef.Weidendorfer@gmx.de>
	 <7vhcw7ttj9.fsf@assigned-by-dhcp.cox.net>
	 <7vac1zqpa3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 02:04:30 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GVHZGDtJuy3J+5fIAs08dv+LI+cP34p4wwzDP9GdD0SXPFT3k5NfxZqHf8s5T/9b1Cq81vjjc6utHvfI0m+iP96dYFhReD2WWcVXqRk3PpEE0dWoUoAtecMJKVBQsV7WNuMSiJugIgvGpT3HGoaUuMwpBiEpxQil+4z9aEqLWVI=
In-Reply-To: <7vac1zqpa3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33652>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsV6A-0007sk-4x for gcvg-git@gmane.org; Fri, 08 Dec
 2006 03:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423850AbWLHCEW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 21:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423853AbWLHCEW
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 21:04:22 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:15437 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1423850AbWLHCEW (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 21:04:22 -0500
Received: by wx-out-0506.google.com with SMTP id h27so688546wxd for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 18:04:21 -0800 (PST)
Received: by 10.70.83.8 with SMTP id g8mr2075580wxb.1165543461422; Thu, 07
 Dec 2006 18:04:21 -0800 (PST)
Received: by 10.70.45.1 with HTTP; Thu, 7 Dec 2006 18:04:21 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/8/06, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
> > Once you place something like "branch.*.merge" in configuration
> > file (either $GIT_DIR/config, or a $GIT_DIR/remotes/* file), you
> > are talking about other repositories you regularly interact
> > with, so it might be probably Ok to require the user to use a
> > tracking branch if he wants the convenience of "branch.*.merge",
> > and make its value name the local tracking branch instead of the
> > remote branch.
>
> In other words, I am all for fixing this.
>
> Although it may not hurt too much if we just redefine the
> meaning of it to name the local tracking branch, using a
> different name "branch.*.defaultmerge" is safer and would not
> break existing repositories.

Or branch.*.localmerge?

