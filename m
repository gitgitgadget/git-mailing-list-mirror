X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Tue, 7 Nov 2006 01:02:15 +0100
Message-ID: <200611070102.15662.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <eiofmt$8nc$1@sea.gmane.org> <7vwt68b0f3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 00:01:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rvHCxPZuAlmhqviXbM2dO5l/nX9wOSbIQssrV8+lrpmpea3QlmWMw8b62JY5b7n2mcadprINaQKtNBS30C4z4+XgPV/nlwFE5W8HPhcvzsW3UiwliBLgDftnbp0dFwt+/8wrvwQA6Xe7OA8m1yGfGOe0hfcPIff3V4QwhX2NwlU=
User-Agent: KMail/1.9.3
In-Reply-To: <7vwt68b0f3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31034>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhEPQ-0000pS-T4 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 01:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753328AbWKGABk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753775AbWKGABk
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 19:01:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27874 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753328AbWKGABk
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 19:01:40 -0500
Received: by ug-out-1314.google.com with SMTP id u2so1249137uge for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 16:01:39 -0800 (PST)
Received: by 10.67.96.14 with SMTP id y14mr8251829ugl.1162857698384; Mon, 06
 Nov 2006 16:01:38 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 59sm5675177ugf.2006.11.06.16.01.37; Mon, 06 Nov
 2006 16:01:38 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>> 
>>>> Here is example code for this:
>>> 
>>> Ok.  The issues I raised in the previous round seem to have been
>>> addressed.  Maybe you would want not to use nested 'sub' and it
>>> is good to go, I think.
>>  
>> Nested sub makes it easy to change gitweb quoting from Character Escape
>> Codes (CEC) to e.g. Unicode Printable Representation (PR).
> 
> Yes, sub makes it easy, it is not needed to be nested.

Well, this sub is of no use (I think) ourside esc_path subroutine.
Similarly for unq sub nested in unescape in PATCH 1/10.

-- 
Jakub Narebski
