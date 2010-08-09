From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: understanding how remote tracking works
Date: Mon, 9 Aug 2010 15:53:09 -0500
Message-ID: <20100809205309.GA3204@burratino>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
 <i3nlq0$8un$1@dough.gmane.org>
 <AANLkTinktpx-rXj1K0BSy0Qwo62SEGFAJWvhKo0nJq=i@mail.gmail.com>
 <AANLkTi=usaZGfOM67acmdAWwvbHe_eHyjmRLGmdTYNaC@mail.gmail.com>
 <20100809021900.GA10596@burratino>
 <7vaaov60rv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, geoffrey.russell@gmail.com,
	Ralf Ebert <info@ralfebert.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 22:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZN1-0004OI-1M
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab0HIUyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 16:54:49 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34193 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab0HIUyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 16:54:47 -0400
Received: by vws3 with SMTP id 3so7091553vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uqr6WBqs3yBT0FvXRYP983LFxzjK6Y1T6GX2eHQlm0A=;
        b=ce2BbfzH8tXbbG9bfJtBbj3xddiapGg0UUX2ndpCNxIF6YPJs8FHKkKfZ/G2LsFChr
         pPwCf0vPpF72SO+TEYzITfopci90Booj+oYEMBs1eweqtEgB2Cs7Zgk2DLsVFSnZaemL
         GE8svwNKaCfTOFh2A4kH19t4EzJGoHxk6Kdb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AInPX7qv3Bm13bJA10o6Sm4dylx9hyhJYsP2rlwXIW+BI/sha6nbM5KaifiQVl9Iu/
         JGb3rJ3SduYiLuW9jf1oVJXkAg6joTi+po5e+gMSfPoY0zzLX2/EFRMxhaHHnU8doxpA
         Lj0uH4+OrZGIz6qGCe7pQZ5QzfvbDwHZ4Wn+s=
Received: by 10.220.59.202 with SMTP id m10mr9955094vch.48.1281387285872;
        Mon, 09 Aug 2010 13:54:45 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id m11sm1099515vcg.6.2010.08.09.13.54.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 13:54:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaaov60rv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153022>

Junio C Hamano wrote:

> I tend to agree with Michael (modulo s/ culture/'s early&/) here.  Ma=
ny
> documents written in the early days, the "tutorial" document by Linus
> being the most prominent example, were written in a way to focus expo=
sing
> the implementation details to show how simple the structure is.
[...]
>> Probably the more relevant question: what do you want to do about it=
?
>
> Continue the current course of encouraging the use of plumbing comman=
ds
> and not looking at the low-level implementation detail.  Perhaps help
> people update their documents, moving stale descriptions into "histor=
ical
> note" sections.

Thanks for deciphering.

So here=E2=80=99s a list from a quick Google search for =E2=80=9C.git/r=
efs=E2=80=9D (alas, the
search engine is not strong enough to return the right hits for =E2=80=9C=
git
"layering violation"=E2=80=9D).  Some nice pages here, actually.

 . http://linux.yyz.us/git-howto.html#diff_branch
 . http://www.lostechies.com/blogs/jason_meridth/archive/2009/06/07/git=
-for-windows-developers-git-series-part-3.aspx
 . http://gitfu.wordpress.com/2008/05/25/git-describe-great-another-way=
-to-refer-to-commits/
 . http://www-cs-students.stanford.edu/~blynn/gitmagic/ch08.html
 . http://google-opensource.blogspot.com/2008/05/export-git-project-to-=
google-code.html
   and http://code.google.com/p/support/wiki/ImportingFromGit
 . http://blog.stevecoinc.com/2010/02/stupid-git-tricks.html

It would be nice to find ways to suggest updates (but please
coordinate so as not to flood the authors with mail).

There are a lot of instances of =E2=80=9Crm -r .git/refs/original=E2=80=
=9D after
running filter-branch, too.  Maybe filter-branch ought to provide
some synonym for

 eval "$(
	git for-each-ref refs/heads/\* --shell --format=3D'git update-ref -d %=
(refname) &&' &&
	echo :
 )"
