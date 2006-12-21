X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Terje Sten Bjerkseth" <terje@bjerkseth.org>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Thu, 21 Dec 2006 01:54:06 +0100
Message-ID: <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	 <86irg6yzt1.fsf_-_@blue.stonehenge.com>
	 <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	 <86ejquyz4v.fsf@blue.stonehenge.com>
	 <86ac1iyyla.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	 <86wt4mximh.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	 <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	 <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 21 Dec 2006 00:54:18 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VzIlkOg1DvGsBPDQKH8Z2g12yNmT/0gf4GGlleiE+ivMZs+tcQD3lce95zcbPA30HnjD2USZ9s4DBS3clrj2g6wNAbmkfTLAaMh1xKd/+uIU3S/VCoBFkIbBJDbN3GZ7TYztdp/wKA0z3gS5K1JhCF6/lwVoOk3tm2sq9Hyz9tU=
In-Reply-To: <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 3bf5df198d09eee9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34992>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxCCK-0004E8-3V for gcvg-git@gmane.org; Thu, 21 Dec
 2006 01:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161098AbWLUAyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 19:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWLUAyJ
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 19:54:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:4365 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1161098AbWLUAyH (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 19:54:07 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1632776wra for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 16:54:06 -0800 (PST)
Received: by 10.90.78.1 with SMTP id a1mr8142692agb.1166662446397; Wed, 20
 Dec 2006 16:54:06 -0800 (PST)
Received: by 10.90.36.7 with HTTP; Wed, 20 Dec 2006 16:54:06 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/21/06, Junio C Hamano <junkio@cox.net> wrote:
> Thanks.  While this is in a better direction than randomly
> including the headers in the source, it is still sad.
>
> Does everybody use Apple CC on OSX?  Is the symbol defined even
> with GCC?  Or Gcc fixes headers well enough and makes this a
> non-issue?

I'm not sure about everybody, but at least the Apple CC *is* GCC:

~/src/git terjesb$ cc --version
i686-apple-darwin8-gcc-4.0.1 (GCC) 4.0.1 (Apple Computer, Inc. build 5367)
Copyright (C) 2005 Free Software Foundation, Inc.

so this is probably a non-issue for default setups. (Sorry about the
