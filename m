X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Use character or octal escape codes (and add span.cntrl) in esc_path
Date: Wed, 8 Nov 2006 19:56:19 +0100
Message-ID: <200611081956.20251.jnareb@gmail.com>
References: <200611081147.52952.jnareb@gmail.com> <200611081150.07469.jnareb@gmail.com> <7vmz71u787.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 18:56:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nQ1RuqJnGxx4wceGepIaRlMgSb1UqJQiceYMtUlNJQ+3tU1dWWIKlqS3XjuIZOgWaZ3vhhtoZAgrCxT/+yG+fK8dHLL3RoWJ3grRYIJWV9iOn5ge4Uk3+sw4OuGsAV8lzuh7Fbqx48awI/zs00PxTP7jQmDu8IpCytpcOXuhNZU=
User-Agent: KMail/1.9.3
In-Reply-To: <7vmz71u787.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31152>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhsaH-0007UL-5r for gcvg-git@gmane.org; Wed, 08 Nov
 2006 19:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161503AbWKHSze (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 13:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161522AbWKHSze
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 13:55:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:33657 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161503AbWKHSzd
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 13:55:33 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1609187ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 10:55:31 -0800 (PST)
Received: by 10.66.221.6 with SMTP id t6mr11456146ugg.1163012131396; Wed, 08
 Nov 2006 10:55:31 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 34sm7446444uga.2006.11.08.10.55.30; Wed, 08 Nov
 2006 10:55:31 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Instead of simply hiding control characters in esc_path by replacing
>> them with '?', use Character Escape Codes (CEC) i.e. alphabetic
>> backslash sequences like those found in C programming language and
>> many other languages influenced by it, such as Java and Perl.  If
>> control characted doesn't have corresponding character escape code,
>> use octal char sequence to escape it.
>>
>> Additionally use 'span' element with 'cntrl' attribute to mark escaped
>> control characters. Add style for span.cntrl in the CSS.
> 
> Would have preferred the 'span' thing to be part of [1/2]...

I've misunderstood you then. I'm sorry.

> Didn't I ask quot to be freestanding sub, not nested?  That
> would make UPR vs CEC experiments easier and more pleasant.

In what way having freestanding and not nested sub would "make
UPR vs CEC experiments easier and more pleasant"?

If it is important, I can send patch moving quot sub outside
esc_path (and perhaps also unq sub outside unquote), or send
corrected patch... or you can correct patch by hand...

-- 
Jakub Narebski
