X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Possible but in gitweb
Date: Sat, 18 Nov 2006 19:21:25 +0100
Message-ID: <200611181921.25873.jnareb@gmail.com>
References: <4d8e3fd30611180858xf28e958g8511f2eb68d53848@mail.gmail.com> <200611181901.31708.jnareb@gmail.com> <4d8e3fd30611181003o6374f01cy504c0c058f374f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 18:29:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:resent-from:resent-to:resent-date:resent-message-id:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dzYhsUVR2CJarDItm7PWmlSLjQUWY8C0VW5sshTXSfBVOUCgAPzJ6ulFz/ggThhoBC256QNJYzm9b1q61TJS+1M30a6Z8JhW9GhjPaNnMLQq+jYnWUGKEOYhNTngYVSRSUoIPIr/Azar+o6LWqhS50nSCk0rIBd8md9HUZwiIUE=
User-Agent: KMail/1.9.3
In-Reply-To: <4d8e3fd30611181003o6374f01cy504c0c058f374f1@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31784>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlUw2-0004Ud-7o for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756360AbWKRS25 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756363AbWKRS25
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:28:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:1215 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1756358AbWKRS24
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 13:28:56 -0500
Received: by ug-out-1314.google.com with SMTP id m3so934787ugc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 10:28:55 -0800 (PST)
Received: by 10.67.22.14 with SMTP id z14mr4342960ugi.1163874535231; Sat, 18
 Nov 2006 10:28:55 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 32sm5819466ugf.2006.11.18.10.28.54; Sat, 18 Nov
 2006 10:28:55 -0800 (PST)
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

Paolo Ciarrocchi wrote:
> On 11/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Paolo Ciarrocchi wrote:
>>> On 11/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> Paolo Ciarrocchi wrote:
>>>>>
>>>>> Browsing the repo I reach the following URL
>>>>> http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;hb=HEAD
>>>>> that is not accessible.
>>>>
>>>> Because HEAD is master, not html, and there us no such file in master branch?
>>>
>>> Fair enough but then there should be no link in the web interface.
>>> That sounds like a bug in the interface.
>>
>> Where did you find this link? On what page?
> 
> Here:
> http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;h=b5e39498997930cd14ecddfe120f62c577ce2e28;hb=html
> 
> try now to press "HEAD"

Ah, well. This could be considered a bug... but it can be not.
The link is clearly marked "HEAD", so you are requesting HEAD
version of the file... which does not exist.

We could check if the file has HEAD version, but that is another
call to git commands.

What you want is the link to the tip of branch ("head", "top" or "tip")...
you are welcome to add that (or replace "HEAD" link with that).
Tip: href(...,hash_base => $hash_base,...)

-- 
Jakub Narebski
