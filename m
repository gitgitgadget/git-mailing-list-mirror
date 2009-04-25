From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 19:26:32 -0500
Message-ID: <b4087cc50904241726l1b38495apf3df4d8e10254902@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <4E155CC5-B20A-4B79-8CBF-9D1E0E36920F@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 02:28:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxVkW-0005CA-9r
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 02:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbZDYA0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 20:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbZDYA0e
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 20:26:34 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:44809 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZDYA0d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 20:26:33 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1161234qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KHWfsBcMl1LgBwhIbwgrQl56PGRZU9xWV2QGtlAHg/0=;
        b=fu1Hq2ZR8YVn3zq0w4dHBbH0RKnG2H7Ztygt1g3n1XWbYea8UL8jBMJkoBrDpDuD8f
         ohD0M0hYxaj3Pkz6rsBFv2BqHnYc9N/lrRPYn3xiEnhvNDqSiv/QOfq2Ob58Wc2f+fOl
         ybdHQ+R/yF2yaLEEoSIvlYBr+toKKJGxjYClA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ILwoZfswRlLDqmDLgXMOzLvKzmAaHXegkLLmww1n7wrWmcyMXsmw6KjZNN3QtgK0GY
         yaE3j6HsJG6LT93civgFG0Yv4Qx7xbQmKhaAItp57jnX/KJBe2M1M0xu/R6lW6upxnNA
         7+zwPIehza+BG4jcv0KQv9iC6y/oJJQ/PU7tI=
Received: by 10.224.32.146 with SMTP id c18mr3706334qad.58.1240619192619; Fri, 
	24 Apr 2009 17:26:32 -0700 (PDT)
In-Reply-To: <4E155CC5-B20A-4B79-8CBF-9D1E0E36920F@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117529>

On Fri, Apr 24, 2009 at 19:19, David Abrahams <dave@boostpro.com> wrote=
:
>> =A0git show master
>> =A0git show master:Documentation
>> =A0git show master:Makefile
>>
>> just makes sense. You are always just specifying an object, but the =
type
>> is different for each (and show "does the right thing" based on obje=
ct
>> type).
>
> I don't believe you need to know about trees and blobs to make sense =
of
> that. =A0Those are just directories and files.

I still think the key is that commits and blobs and trees are all
objects, and the important things are the concepts of objects, object
addresses, object pointers, and handles (or, what everyone else calls
objects, object names, references, and symbolic references).

Also, you've mixed in the theory of file system addressing in with the
theory of git addressing. I think it's important to realize that the
tool 'git show' is actually providing a translation between the two
worlds. There's not really any need for paths to be considered a
fundamental git concept; simply, git tools know how to translate
between both worlds.
