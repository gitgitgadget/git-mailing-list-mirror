From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 2 May 2009 20:26:03 -0500
Message-ID: <b4087cc50905021826o2b259009pda15dcaaa135ca38@mail.gmail.com>
References: <200904240051.46233.johan@herland.net>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <20090424231632.GB10155@atjola.homenet>
	 <b4087cc50904241701jb78ce50m122fef475b0f1de7@mail.gmail.com>
	 <20090502155348.GB6135@atjola.homenet>
	 <b4087cc50905021136l5209777bs2209bab385deeef6@mail.gmail.com>
	 <20090502211110.GC6135@atjola.homenet>
	 <b4087cc50905021613j1d269757g8c599b484208c188@mail.gmail.com>
	 <ca433830905021818v5c99cce4q57902eba8ff3d7fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 03:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0QTE-0008OJ-B5
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 03:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbZECB0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 21:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbZECB0G
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 21:26:06 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:53783 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbZECB0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 21:26:03 -0400
Received: by qyk34 with SMTP id 34so4532917qyk.33
        for <git@vger.kernel.org>; Sat, 02 May 2009 18:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UvaR0hxKY5GBssNlHhOcInWFni/u6REGwZtp6uPUvRM=;
        b=pNlpkXwco8tkE1zdB0iGtP9pyQJf9skx8GoFAuPeuUwREjGv/GRong1yZdlAmY6Ezh
         147jTmY9VBreEeY7ivQtbugrbQ/VZbLZMRbRlOmijSkI9edkxN68gq1CGKXjH7ZOMVaN
         44+fFLJGE1aJ/lxfNerwH7xJ3QELSF7Xc7s70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X+teZi6buwCbIWkaHrYHndsT4InXfIu6swSOltSs/rQrkIIhYyyCdn1UFnE47kHb/H
         q5R3OQdzism4GxTWE4Tfe2HhUdZAW3Avdni36Zk5HdNJ5QNhcuJ8GQXk9wMnsXlCQb+n
         JKUngtckWkn+2mQsNSFnzvpbfd6Asi9V9WKJs=
Received: by 10.224.10.208 with SMTP id q16mr4517902qaq.387.1241313963381; 
	Sat, 02 May 2009 18:26:03 -0700 (PDT)
In-Reply-To: <ca433830905021818v5c99cce4q57902eba8ff3d7fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118160>

On Sat, May 2, 2009 at 20:18, Mark Lodato <lodatom@gmail.com> wrote:
> 2009/5/2 Michael Witten <mfwitten@gmail.com>:
>> I also dislike the use of 'name' rather than 'hash'; a name is
>> something provided by the user, but a hash is something computed. The
>> use of sha[-]1 is even more egregious.
>
> What about "identifier" as a compromise between "hash" and "name"?
> This is really what we're talking about - a way of identifying
> objects.

It's the same problem, in my opinion. '[Cryptographic] hash' says so
much more and still remains quite generic.

Also, continuing with 'sha1' doesn't seem satisfactory:

    http://marc.info/?l=git&m=124068702303042&w=2
