From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Thu, 25 Jul 2013 23:23:23 -0700
Message-ID: <0A68F4A5-22B0-4629-8693-73258566E218@gmail.com>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79> <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79> <20130726043748.GA20286@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 08:23:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2bR5-0002ut-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 08:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab3GZGX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 02:23:27 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35774 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab3GZGX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 02:23:26 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so1287188pad.28
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=DTnPbMnLzTpzqsgAVL7ed58we9aQ3lakJ9xr/INwj9U=;
        b=paFvbCiWCaTX3e8leYaq8fu/HcSEiRxtsWg5Zg2hDKg0ScFEsw5cZCkWmGB0ExWl0z
         A3Xr1QY0IDClNSoSl0q9exBJSlLLuF60T8Ts7lGwXgNT6yvqT1H22YiCDWVXbz2TAFT4
         TCRVJaytmA9mur3EF3A1XFIsd79ZP3MzT0Bd6xFfWisTt2lK3XHM9COY/8jrFwNREXeW
         EHF5UmvOdGLTA1OqWC2oXEh0Nln1+Fsa5W5AbE0celuYkHwLldCL56Qdmnb/q60LPtQX
         Xi1MsCQBr/bdbbzwZ+BHkRxfXuqYK6O9oAyDtH775ZPGQvmDOmC7tv+1uqfXrz+oxF1F
         zmPA==
X-Received: by 10.66.234.106 with SMTP id ud10mr20087290pac.86.1374819806236;
        Thu, 25 Jul 2013 23:23:26 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id nm10sm58134126pbc.28.2013.07.25.23.23.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 23:23:25 -0700 (PDT)
In-Reply-To: <20130726043748.GA20286@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231168>

On Jul 25, 2013, at 21:37, Jeff King wrote:
> On Thu, Jul 25, 2013 at 03:39:13PM -0700, Kyle J. McKay wrote:
>
>> Overhaul the text of the http.<url>.* options documentation
>> providing a hopefully easier to understand itemized list of
>> matching behavior as suggested by and including text from
>> Jeff King.
>> ---
>
> Signed-off-by: Jeff King <peff@peff.net>

Thank you.  Added.

> You should add your S-O-B, too, for your bits.

Yes.  I wanted to make certain it didn't get applied just yet. :)

>> +--
>> +. Scheme (e.g., `https` in `https://example.com/`). This field
>> +  must match exactly between the config key and the URL.
>> +. Host/domain name (e.g., `example.com` in `https://example.com/`).
>> +  This field must match exactly between the config key and the URL.
>
> These look fine in the rendered manpage, but I think the source  
> might be
> a little easier to read with a blank line between items.

My ASCIIDOC is a bit weak.  I have added some blank lines.

>> +. Exact user name match (e.g., `user` in `https://user@example.com/repo.git 
>> `).
>> +  If the config key has a user name it must match the user name in  
>> the URL
>> +  exactly.
>> +. Any user name match.  If a config key does not have a user name,  
>> that config
>> +  key will match a URL with any user name (including none).
>
> IMHO, this would be more clear as a single item, like:
>
>  . User name (e.g., `user` in `https://user@example.com/repo.git`). If
>    the config key has a user name it must match the user name in the
>    URL exactly. If the config key does not have a user name, that
>    config key will match a URL with any user name (including none).

The only problem I have with a single item is what's the precedence?   
Does an exact user match have the same precedence as an any-user  
match?  That would seem to be implied by having them as the same item  
number.  Separating them would appear to make it clearer that an exact  
user match wins over an any user match, but if you have some alternate  
text as a suggestion for the single item that clears that up...  :)

>> +All URLs are normalized before attempting any matching (the  
>> password part,
>> +if embedded in the URL, is always ignored for matching purposes)  
>> so that
>> +equivalent urls that are simply spelled differently will match  
>> properly.
>
> And this nicely ties up the open questions I had after re-reading the
> list. Good.
>
> We could define "equivalent" here (the %-encoding thing is obvious, I
> think, but which components are case-sensitive and which are not is
> perhaps a bit subtle). I do not necessarily know that it is useful to
> the user, though, and is one more thing to confuse them.  And somebody
> who really cares can look at the appropriate RFCs.

I am considering this text to address that:

> All URLs are normalized (%-encodings are standardized, case- 
> insensitive
> parts are lowercased, `./` and `../` path components are resolved)  
> before
> attempting any matching (the password part, if embedded in the URL,

but I'm not sure the extra verbiage makes it better.  I think it may  
just complicate the explanation unnecessarily?
