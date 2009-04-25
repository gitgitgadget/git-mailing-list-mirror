From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 19:19:50 -0500
Message-ID: <b4087cc50904241719w64bc6074xe5b8d341ef9f51ed@mail.gmail.com>
References: <200904240051.46233.johan@herland.net>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <20090424231436.GA15058@coredump.intra.peff.net>
	 <b4087cc50904241631t8913c47ke3b2027b466ee1e9@mail.gmail.com>
	 <20090424233509.GA15341@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 02:21:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxVe7-0003wg-3p
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 02:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbZDYATx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 20:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbZDYATw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 20:19:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:22159 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZDYATv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 20:19:51 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1159654qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 17:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZuOcv/Oakp6hqbCJqi+WnW7u3vm5tvWNC5YvhUraQdA=;
        b=EaI16LxgLbWK1NPpDCilasFuTEjwppCKKaOqzVhfLa1fOyiz1sUB3HTadoGx3EDZ6y
         xrXTUHUGwkfq41igM7n4JFO2CWzM86lYb7+h7nmFfpC3U9DMq3d1ZgCOTxVNfamx4L43
         6QsuPf0vOdSQAKAj9sA6zLYotrj/XAntO6y2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j6j4S5WbL/ONeMHlnxLHKCD3BgRjouojtL/7w9AGV/hVDwe4FNNruPoXH985SYgdnn
         nAQpNqetRVqDGjmRBZ3YAb6qCJOH2/9bOIDO+1oLoujz4SkRqwgZPpHRWipsxjpE6if3
         gwTDjVckK5vmRXZfKdwai/6EDLMpS2UEIxLcQ=
Received: by 10.224.67.133 with SMTP id r5mr3640113qai.285.1240618790191; Fri, 
	24 Apr 2009 17:19:50 -0700 (PDT)
In-Reply-To: <20090424233509.GA15341@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117528>

On Fri, Apr 24, 2009 at 18:35, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 24, 2009 at 06:31:26PM -0500, Michael Witten wrote:
>
>> On Fri, Apr 24, 2009 at 18:14, Jeff King <peff@peff.net> wrote:
>> > Junio suggested "object name" in another thread, which I think is nicely
>> > descriptive.
>>
>> The reason I don't like "object name" is that "name" has connotations
>> that don't go well with the idea of referencing. Isn't "address" (or
>> "location") better in this sense?
>
> I'm not sure I agree, but if you are concerned with "name", then I think
> something like "object id" or "object identifier" would probably be
> better. "address" and "location" imply to me that they are part of a
> contiguous set. And while technically they may be considered addresses
> of a sparse 2^160 array, I'm not sure that explanation is really helping
> new users understand what is going on.

You make an interesting point about implied contiguousness, but I
don't think any git operation is in danger of evoking that thought. I
mainly like the idea of "address" and "location", because they go
extremely well with "pointer", "handle" and the idea of a "git store
(memory)". Most importantly, this is an analogy that has been around a
long time.
