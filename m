From: Scott Chacon <schacon@gmail.com>
Subject: Re: problems with http://git-scm.com/
Date: Tue, 3 Feb 2009 10:38:28 -0800
Message-ID: <d411cc4a0902031038h123c34ces45134e5455f37df0@mail.gmail.com>
References: <20090124173756.GU6683@cs-wsok.swansea.ac.uk>
	 <87skn8v906.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Oliver Kullmann <O.Kullmann@swansea.ac.uk>, git@vger.kernel.org,
	Adam Cooke <adam@atechmedia.com>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Feb 03 19:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUQBh-0007Sl-BS
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbZBCSia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZBCSia
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:38:30 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:54539 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbZBCSi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 13:38:29 -0500
Received: by qyk4 with SMTP id 4so2794089qyk.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FYg5ZEEikPDUiqyRarc7adTwPZ7d8ufBmx3utYeJ8Uc=;
        b=R207dcbP4C1egkRo5dts9aSOWp5aW/e4ZvzPy+6YRPaqehpTOCcCx/UHPNn41qFBKX
         1gMSH11ZbEmzqH7tOFxj1SB3oOnv7H8kcUJWHFMtr6rCdSPJd6qo2NzzYekQ0tbQ6j2A
         HTmCuuvSYM3x9vfxY4dCZopks71Tz7AzfVDhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TqEoweXP+3T/GOYmjiMD/SrTsIkW2HZLcGh9U7EQvWmr/TZRywiqwfDvpnMstpwc93
         +FQl1wBbvPDuJNyVZcStRMmV1aCvMzXpojxMbOQyHzsjgpa6MHKD5B84gNcxXnmqBcqc
         agoY09Vnj06YIj4FsCNzGj5EZqWBj6PTKAACA=
Received: by 10.214.113.1 with SMTP id l1mr4117603qac.259.1233686308115; Tue, 
	03 Feb 2009 10:38:28 -0800 (PST)
In-Reply-To: <87skn8v906.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108236>

Will push out this and a few more fixes soon.

Thanks,
Scott

On Sat, Jan 24, 2009 at 10:44 AM, Teemu Likonen <tlikonen@iki.fi> wrote:
> [Adding some CCs.]
>
>
> Oliver Kullmann (2009-01-24 17:37 +0000) wrote:
>
>> since a few docs my (somewhat rusty) Konqueror can't load
>> http://git-scm.com/
>> anymore.
>>
>> Now checking at
>> http://validator.w3.org/
>> we get one error:
>>
>>  Line 174, Column 14: there is no attribute "clear".
>>     <br clear="all"/>
>>
>> And that shouldn't be (since http://git-scm.com/ claims to be strict
>> xhtml). Don't know whether this is the problem, but that attribute
>> clearly should be removed anyway.
>
> It seems that the attribute has already been changed to
> style="clear:both;" in the web site's git repository[1]. It's the commit
> cea494929e (2009-01-08). But www.git-scm.com is still serving an old
> version.
>
> ---------------
>  1. git://github.com/schacon/gitscm.git
>
