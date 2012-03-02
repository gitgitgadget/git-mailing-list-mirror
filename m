From: Luke Diamand <luke@diamand.org>
Subject: Re: Re*: Tilde spec - befuzzled
Date: Fri, 02 Mar 2012 09:25:49 +0000
Message-ID: <4F50921D.8050109@diamand.org>
References: <4F4C995D.9000504@diamand.org> <4F4CA354.2070503@op5.se> <87zkc38a3v.fsf@thomas.inf.ethz.ch> <7vaa42zrw8.fsf@alter.siamese.dyndns.org> <4F4DF096.9050905@op5.se> <7v8vjltpv1.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:25:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3OkI-0006Mj-8L
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 10:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584Ab2CBJZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 04:25:46 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45944 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570Ab2CBJZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 04:25:42 -0500
Received: by wibhm2 with SMTP id hm2so472354wib.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 01:25:41 -0800 (PST)
Received-SPF: pass (google.com: domain of luke@diamand.org designates 10.216.133.93 as permitted sender) client-ip=10.216.133.93;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of luke@diamand.org designates 10.216.133.93 as permitted sender) smtp.mail=luke@diamand.org
Received: from mr.google.com ([10.216.133.93])
        by 10.216.133.93 with SMTP id p71mr849598wei.10.1330680341842 (num_hops = 1);
        Fri, 02 Mar 2012 01:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=vsatKBQUqNNbvHNMjgG+kP6gP04mhxCFUxOW9O8WCfk=;
        b=lXBIzawKYtQgzX8PNO9MzkayJCjh6XcksVasdXo/1dhs22KCZyt7IoBpWt8OFmnEAY
         BmEvslgdDF6ExHqL5roPVgdAkbl8/6cR6RM/cXfHXvx8N9F23O5TPmqHRfrEivtCnqrN
         m4FlgWjsmHtYGD+7erUcElEWkifVScZP5gUrPqNBZTfe4Dkd9CMeIPHrVIt5gw3sYypA
         nfLbo0cf/3XIG05p+shbxXXcfgRiSabgAonJvHlqqPKR0jNV1ql+vBqWE4JquQZeqlvT
         /LW3XRg4WzT3ddSB0qLqWwnEQbg5PuMz4cRwu6orj0PDQktvdecmOC5/tqkoI8dVeRJq
         Wlhw==
Received: by 10.216.133.93 with SMTP id p71mr678186wei.10.1330680341768;
        Fri, 02 Mar 2012 01:25:41 -0800 (PST)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id v4sm6985036wiy.9.2012.03.02.01.25.40
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 01:25:40 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
In-Reply-To: <7v8vjltpv1.fsf_-_@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmE0O3T4+09VDt6CAbCwKLtnxz+r+fHEXIVtKbP+8wOlI5VVkQkYlh04Dyw4dqgRXCtwpc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192016>

On 29/02/12 19:13, Junio C Hamano wrote:
> Andreas Ericsson<ae@op5.se>  writes:
>
>> On 02/28/2012 08:20 PM, Junio C Hamano wrote:
>>> Thomas Rast<trast@inf.ethz.ch>   writes:
>>>
>>>>>> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>>>>>> A suffix '{tilde}<n>' to a revision parameter means the commit
>>>>>> object that is the<n>th generation grand-parent of the named
>>>>>> commit object, following only the first parents.
>>>>>>
>>>>>> Hang on, *grand*-parents?
>>>>>> ...
>>>>
>>>> Perhaps we should reword it as "n-th first-parent ancestor"?  Barring
>>>> confusion about the position of the dashes, that leaves little room for
>>>> error.
>>>
>>> I think we could either go "easier to read but not precise"
>>>
>>> 	... that is the<n>th generation (grand-)parent of ...
>>
>> (grand-)parent and ancestor are interchangeable while the parentheses
>> remain, although the former looks a bit clumsier in text.
>
> Ok, then something like this...

This change works for me. Ack.

Thanks,
Luke


>
> -- >8 --
> Subject: Documentation: do not assume that n>  1 in<rev>~$n
>
> We explained<rev>~<n>  as<n>th generation grand-parent, but a reader got
> confused by the "grand-" part when<n>  is 1.
>
> Reword it with "ancestor"; with the "generation" and "following only the
> first parents" around there, what we try to describe should be clear
> enough now.
>
> Noticed-by: Luke Diamand<luke@diamand.org>
> Helped-by: Thomas Rast<trast@inf.ethz.ch>
> Helped-by: Andreas Ericsson<ae@op5.se>
> Signed-off-by: Junio C Hamano<gitster@pobox.com>
> ---
>   Documentation/revisions.txt |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index b290b61..1725661 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -101,7 +101,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
>
>   '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>     A suffix '{tilde}<n>' to a revision parameter means the commit
> -  object that is the<n>th generation grand-parent of the named
> +  object that is the<n>th generation ancestor of the named
>     commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
>     equivalent to '<rev>{caret}{caret}{caret}' which is equivalent to
>     '<rev>{caret}1{caret}1{caret}1'.  See below for an illustration of
