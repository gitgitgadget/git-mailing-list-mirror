X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 22:50:06 +0100
Message-ID: <200610302250.06733.jnareb@gmail.com>
References: <850923.44762.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 21:57:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GUT/DrZ1hP8/U2Z4oBE18V38VCZ4dzN418fxcbbQFtx+Mzkn90pHKZDxxVu3agqpL7oaTXaxSIWW6BXHzp+j/RlYanKZeYTfoO/CQPckonh8LtbYeUH1R0MMZlf6nhAWtDStA2kD+Zl52y4qTGkrSFGWUMfMPmdu0LG/yVfd3wo=
User-Agent: KMail/1.9.3
In-Reply-To: <850923.44762.qm@web31812.mail.mud.yahoo.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30531>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gef1G-00006L-U8 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161531AbWJ3VuG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161528AbWJ3VuG
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:50:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:717 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161531AbWJ3VuE
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:50:04 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1273422ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 13:50:00 -0800 (PST)
Received: by 10.67.119.13 with SMTP id w13mr4950075ugm; Mon, 30 Oct 2006
 13:49:59 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 39sm3386939ugb.2006.10.30.13.49.59; Mon, 30 Oct
 2006 13:49:59 -0800 (PST)
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>>> Wouldn't this be confusing with the other fine lines?
>>> I personally don't like this chunk separation.  Chunk separation
>>> already exists as is and we view it all the time elsewhere.
>> 
>> But not always the program displaying diff can display such line
>> separating chunks, for example on text terminal it can't.
> 
> What I meant is that since I stare at diffs exactly on text terminals,
> my eyes have found other ways to discern chunk blocks.

I'm just saying that with HTML diffs, presented via gitweb in graphical
web browser, you have more possibilities, more formatting to use.
Why not make use of it?

>> But if you think that the dotted 1px #ffbbff line is too intrusive,
>> we can remove it (and perhaps increase vertical space a few pixels).
>> I'd like to have more opinions first.
> 
> No, I just think that it should be as close as possible to what
> we see now and what we see on text terminals -- no extra vertical
> space please.  Between the two evils, I'd prefer the thin "dotted" line.

Well, I'll make it nearly invisible in the "take 3". BTW. some people
liked this line, some were indifferent.

>> BTW. you can easily override it in your CSS file.
> 
> Why should we allow something to go into gitweb and disrupt the current
> default behavior only so that people have to change their own css file
> to keep current default behaviour.  Please don't shove this down our
> throats.  Please?

That was just to note that if you don't agree with default, you can change
it very easily. It is probably the time where people would disagree (for
example infamous "redundant links" debate) on the gitweb UI; the possibility
to tailor it easily to your own UI concepts and ideas is in my opinion
very important (and very nice).

-- 
Jakub Narebski
