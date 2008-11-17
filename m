From: "Gennady Kushnir" <genkush@gmail.com>
Subject: Re: publish since current state?
Date: Mon, 17 Nov 2008 13:52:25 +0300
Message-ID: <23ae57c00811170252uba2cd22kb99a23134f026fc6@mail.gmail.com>
References: <96ed5eac0811161242o4c800e37u7c96872a9a4351ef@mail.gmail.com>
	 <49211B78.50204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21jj-0003E2-Ik
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbYKQKw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbYKQKw1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:52:27 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:63661 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYKQKw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:52:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2378325rvb.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 02:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=N0+YzELLkc6IkAd/qfRn/C72fANNAFCTXQGeZTmIEO4=;
        b=DIMVZBCzST70GImk8F7cWH+SIAMSgOWEdX30oAj/+9lCMrXsZ2YLnL908jiTrKDXPN
         1Pn1kmng3FCuAPhGf9riPlAU+QD1vF9GhiqELL5KgyouG+apIzdXwtvMsYC3AEIYy1iT
         8wxdjQiauL21fWBiJw+4/KsMrcjnc35J65NVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JQFUJnQvvYafphWojgit2JnHTGNvwuKYVoWTe2y2BPfG+rAA1n2Q/9jrVnfkg7ySJi
         WIWGCbJQzAOCqUbmh/9hMi4S9TmQrEA3AI2QuBL8BCNxy6nwNzrEnI519oL+7zI97tO/
         wqUKRZlCSmmiTX1WjJuDAvaROgfdCv8F2ejtI=
Received: by 10.141.48.10 with SMTP id a10mr2167780rvk.71.1226919145544;
        Mon, 17 Nov 2008 02:52:25 -0800 (PST)
Received: by 10.141.203.11 with HTTP; Mon, 17 Nov 2008 02:52:25 -0800 (PST)
In-Reply-To: <49211B78.50204@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101216>

Thank your for your reply.
But I could not find documentation for grafts... it is only mentioned
in glossary.
The only thing I found with google is 1-year-old a mail list post
http://marc.info/?l=git&m=119636089519572&w=2
could you point out some direct link to grafts documentation?

And also - what you mean by "copy the object database
from the old repository into the new one" ?
I'm not aware of such operation. What command does it?
And will not that copied database go online as dangling objects?

Gennady Kushnir

2008/11/17 Andreas Ericsson <ae@op5.se>:
> Gennady Kushnir wrote:
>>
>> Hello list.
>> I'm going to publish my work into online public repository.
>> I have several months of previous history in my local git repo. And I
>> don't want to make it all public.
>> Is it possible to publish just a shallow copy of my repository storing
>> my current tree?
>
> Yes. Look for 'grafts' in the documentation. You'll have to create a
> new repository containing only the most recent code first, and then
> create the grafts-file in that repository and copy the object database
> from the old repository into the new one.
>
>> I'd also like to keep my local history private but push new commits
>> from it into that online repo.
>>
>
> The grafts solution will work like that, assuming you don't publish
> your grafts-file.
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>
