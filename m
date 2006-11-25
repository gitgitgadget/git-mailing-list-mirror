X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 11:52:48 +0100
Message-ID: <8c5c35580611250252r50539e4ere98bb38c7b8c9c9@mail.gmail.com>
References: <1164409429445-git-send-email-hjemli@gmail.com>
	 <20061125064901.GB4528@spearce.org> <ek9078$m2j$1@sea.gmane.org>
	 <20061125085731.GG4528@spearce.org>
	 <8c5c35580611250116h466e3649p2630ee6641b6e6f4@mail.gmail.com>
	 <7vd57b3jc2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 10:53:16 +0000 (UTC)
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rOMGe9+IwKO8Cj1FjDGY0QfXQwWDjOyXC0J+qyC56W3sCr5JToZxYwfxdjTd6d3Cq0Lk5t5wBLeVn7lQ+0Qet28NLS6aiUvmgIdt6rVRwD3GbuREVRw+D4FOPkq+f1+GLtzrtJdGaB6suSutWOE2nriC7qIeXFCe1r06U9vUAh4=
In-Reply-To: <7vd57b3jc2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32281>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnv9a-000176-Vf for gcvg-git@gmane.org; Sat, 25 Nov
 2006 11:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757862AbWKYKwz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 05:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757904AbWKYKwz
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 05:52:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:11233 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1757862AbWKYKwy
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 05:52:54 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1532393nfa for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 02:52:53 -0800 (PST)
Received: by 10.82.164.9 with SMTP id m9mr1709394bue.1164451973073; Sat, 25
 Nov 2006 02:52:53 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Sat, 25 Nov 2006 02:52:48 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/25/06, Junio C Hamano <junkio@cox.net> wrote:
> "Lars Hjemli" <lh@elementstorage.no> writes:
>
> > Is it ok to put
> >
> > static int log_ref_write(struct ref_lock *lock,
> >       const unsigned char *sha1, const char *msg)
> >
> > into refs.h?
>
> I think a cleaner implementation that does not have such a
> layering violation would involve defining rename_refs()
> interface in refs.c, next to the delete_ref() that exists there.

Yes, that looks a lot nicer. I'll give it a try.

-- 
