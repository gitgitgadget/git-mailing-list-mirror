From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 19:36:51 +0800
Message-ID: <be6fef0d1001210336i56605a37tfbede92cab794d76@mail.gmail.com>
References: <20100121004756.GA18213@onerussian.com>
	 <20100121050850.GA18896@Knoppix>
	 <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
	 <20100121103500.GA19285@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Jan 21 12:36:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXvLN-0006g8-Fv
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 12:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab0AULgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 06:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620Ab0AULgx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 06:36:53 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:40098 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab0AULgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 06:36:51 -0500
Received: by iwn34 with SMTP id 34so4525233iwn.21
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 03:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=fm7MNu/W1PQJYshtwbrwORtDoAQvyuYrswkK5vX3l3o=;
        b=gUfPUbKpqsBef/p57f6izzf3KP48u3TrJLMLslK8V586Q0Z6O6Q6kj265n+EaP7J1/
         A7tGAe+3mwGdmsZp5M9gHEieCIHNv0NNZAwu16c+Sq54kZYy3CK+IkLTfmEDPL+9aD78
         6dzQC1d1TZ+8pGtyEv9VKSTYXi8tPXwTBWuUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Sx4aXbWB4ROffaRV8Ly0e9Ww49riUCjYpN+FifVMW/XmL9qNPRLCEE5r6I6VNM8ZlA
         qZxfy3CW/t2kRkhOeGXliEmxNW5QCvv3tG+MURzyprwd4mPH2C6b+AFrqrUBO3IarE+1
         hmPdU1+VDX5XVmv5kX5JAvhpvWMvycaTR5o0U=
Received: by 10.231.147.21 with SMTP id j21mr2070042ibv.80.1264073811214; Thu, 
	21 Jan 2010 03:36:51 -0800 (PST)
In-Reply-To: <20100121103500.GA19285@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137652>

Hi,

On Thu, Jan 21, 2010 at 6:35 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Thu, Jan 21, 2010 at 02:47:37PM +0800, Tay Ray Chuan wrote:
>> Hi,
>>
>> On Thu, Jan 21, 2010 at 1:08 PM, Ilari Liusvaara
>> >
>> > (i.e. webserver would ignore the query). This isn't true for git.debian.org.
>> > Requesting the latter works (and the data formatting looks sane), but the
>> > former is 404. This causes the fetch to fail.
>>
>> afaik, putting a "?var1=val1&var2=...." still makes it a normal GET
>> request, even if the url requested is just a plain file and not some
>> cgi handler that uses those variables/values.
>
> Yes, it is normal GET (POST would be something else). And wheither it is CGI
> doesn't come into play for request since client decides wheither to send GET
> or POST and wheither to include query or not.
>
> Query is just technical name for part between ? and # (or end of HTTP URL),
> and can be present in any type of request that accepts http:// URL.

yes, indeed, I misread your message. Your idea of the query string
affecting the server response didn't strike me then.

-- 
Cheers,
Ray Chuan
