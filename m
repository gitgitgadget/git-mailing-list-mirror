From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 14:16:50 -0500
Message-ID: <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com>
	 <alpine.LNX.2.00.0904251445030.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 21:18:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxnOL-0004Pn-Rq
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 21:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbZDYTQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 15:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZDYTQw
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 15:16:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:49097 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbZDYTQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 15:16:51 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1406859qwd.37
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/TLuQnMUB6ggnRjSf0s+D6wnwJV39f9gRIhnXRKyw20=;
        b=LA3r31MJtmoNQyxqMAkOIFSGXKajQYF3evhhSAH9HFpH4TYvwpMeewqPVr+UZOuk/V
         JdaYw33Is0C+wk/Vw9YEprVJrZwrAz9fgFOJnniHx0UmZ9XcOCitiFfRryOUmkSahE/n
         k3H6zsq7JnD5IdYsQ+kT8R1xuIYscmb77X6GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kPB15rPxUz52UUpepB80N6TOq1hvL5lPwd6HabQlJQHyikKbtOXZR6aU7QnI4MMsWK
         tf53EXDTq0eA8AYw9hb9i75oscb9EhZwFo97bn2jlWVOFtS8OsoSUvNVv0CH6WpH86N7
         4yzWXtQHe6QAAmZRO9U/O6tTVYzZr3AwJDdU0=
Received: by 10.224.67.1 with SMTP id p1mr4236974qai.263.1240687010837; Sat, 
	25 Apr 2009 12:16:50 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904251445030.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117573>

On Sat, Apr 25, 2009 at 13:55, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 24 Apr 2009, Michael Witten wrote:
>
>> > And the term is already in use for this particular case,
>> > and it doesn't mean anything else at all (since, of course, the crypto
>> > thing is "SHA-1", not "sha1"), and it's short (which is important for
>> > making it easy to look at usage help).
>>
>> What happens when SHA-1 is shown to be broken or there is a better
>> alternative? Then we'll see "sha1 for historical reasons"... bleh!
>
> Why do you think SHA-1 has anything to do with it?

Well, it's named sha1.

> Git's sha1s could just
> as easily be 160 bits of a SHA-256 hash and there wouldn't be any
> user-visible difference. The term doesn't imply any particular significant
> connection to a particular algorithm.

Then give it a generic name like 'hash'.

> It could be like "pencil lead", which has never been made of lead,
> but is called that for no particularly important reason.

Hence the perennial:

    "Hey! Did you know that pencil lead isn't lead at all?"

to which someone might respond:

    "Why do you think lead has anything to do with it?"

Look familiar?
