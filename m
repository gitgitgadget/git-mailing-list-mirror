From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: About git pretty
Date: Sat, 23 Aug 2008 21:57:03 +0300
Message-ID: <94a0d4530808231157y3d36fc23q4617787214a02ea1@mail.gmail.com>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
	 <20080823000336.GB14684@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephan Beyer" <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Aug 23 20:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWyJY-0007Qk-Un
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 20:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbYHWS5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 14:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbYHWS5I
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 14:57:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:54537 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbYHWS5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 14:57:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so997562rvb.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+xBcJ3wEGbnZwOtxhfhU88A5EOICuCplbaWuLUDDAY8=;
        b=oaIYC0yjIYh3XnoidYIqOdz1RleVw35iT/MDVr7AaMmPIpcdQ5iJ4eY3lZshomKmKg
         jtqdh2PlBM3s+yp0Il8SdepiTqr2qDp+5gftcBXZ3EmZ/6gW6x81ZapO0qMb1zvLdQug
         YZSg9IZoGaZ/MYRX1jlA5xWdiEmVXOMU7jVcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kKEU//zzN4OsjIezOkD40AqVnfgTBmjM9VYlaQWOGs6Scwk6knRJpo/YXZP9/PghDG
         Z8B6IabE34qbNe4s2j9Wekcclw6kT/h7kOGBlHPcUfUBKMIxzbUFWxoV7gpf8ll7uxYq
         i6AY2/1RP37FrcE33T3NGiYjBdD+oiU8hMW6M=
Received: by 10.141.74.18 with SMTP id b18mr1255833rvl.80.1219517823505;
        Sat, 23 Aug 2008 11:57:03 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sat, 23 Aug 2008 11:57:03 -0700 (PDT)
In-Reply-To: <20080823000336.GB14684@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93472>

On Sat, Aug 23, 2008 at 3:03 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> Felipe Contreras wrote:
>> Hi,
>>
>> Please read aloud the following commands:
>> git log --pretty=short
>> git log --pretty=full
>> git log --pretty=format:%s
>>
>> It is just me or 'pretty full' doesn't exactly convey the meaning of
>> the action to execute?
>
> But "pretty short" and "pretty format" is. :)
>
>> How about:
>> git log --format=short
>> git log --format=full
>> git log --format=custom:%s
>>
>> If you like the idea I can work on a patch.
>
> Because --pretty=<format> is an option taken by many git commands including
> git plumbing (e.g. rev-list), many scripts will rely on "--pretty" and they
> all would have to be changed. And --pretty exists since Jan 2005 (see
> 9d97aa64).

Well, it might be difficult, but that doesn't mean it should not be
done. Just like the 'git-*' removal, there could be a period for
transition.

> Also, --format is an option available to git-archive and git-for-each-ref
> with a different intention for each. --pretty exists for several git
> commands with the same intention for all (I think) -- pretty-printing
> commit objects.
>
> And, btw, I also do not think that your idea does really solve the
> "problem" that it always will make sense when you read it aloud.
>
> Thus it seems that --format has no benefit over --pretty at all. :-)

Heh, it was just one example. My point is that 'format' is more meaningful.

</snip>

-- 
Felipe Contreras
