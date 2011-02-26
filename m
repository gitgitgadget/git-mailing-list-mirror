From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sat, 26 Feb 2011 15:51:39 -0600
Message-ID: <20110226215139.GA19176@elie>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie>
 <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie>
 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 22:52:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtS3U-000763-Tg
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 22:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab1BZVvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 16:51:46 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57384 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1BZVvp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 16:51:45 -0500
Received: by qwd7 with SMTP id 7so2028731qwd.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 13:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=u0N/iNDo6E1pCAlLhA+Gj/iAkDFKtG3sGos03cI37KE=;
        b=S/Nf1++059pwyCv/zZ6nmTZJqbdo9jtwNXzCGUwlzL8qUOByJLOmPuajsKrY7A/oai
         CCJY6o0D92hCQtS1MjR6Z8hkKlvT/2aWep+XCPhAKp9MghaVBgmfaSI8XrhgGNcGbloA
         DnKYGDjdAA1+AjsUMfb4wjNKVgQ0DiU6bWJwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DR72jg4DSeuTLQQZNdhYJdfGGEY2gMsV9xO8cyeanNiPL80A0t3TuJm1yfu0jVCWua
         2CDulpDEdb05Q07gLPYNjngKxmU75ZgXsak15NaB/R2Jhb3YvdqG5TwbvwiwOLxKxfSL
         rmDx4rHUtmkU3iKN0WEt3ENFTtQOc70zVOuis=
Received: by 10.229.130.106 with SMTP id r42mr1442459qcs.227.1298757105104;
        Sat, 26 Feb 2011 13:51:45 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id l17sm1709371qck.32.2011.02.26.13.51.43
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 13:51:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167995>

Hi Felipe et al,

=46elipe Contreras wrote:
> On Tue, Feb 15, 2011 at 1:19 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =C2=A0- mode and blob name for paths as requested by the user with
>> =C2=A0 "git add"
>
> A commit stage.
>
>> =C2=A0- competing versions for paths whose proposed content is
>> =C2=A0 uncertain during a merge
>
> Multiple commit stages.
>
>> =C2=A0- stat(2) information to speed up comparison with the worktree
>
> If only a subset of the files are there, it's an 'index', if not, the=
n
> I'd say it's a 'registry'.

These terms you suggest aren't the established ones (as I'm sure you
know).  Just as with everyday language, there is some resistance to
moving to new terms that have not been established for a while.  In
everyday language, many terms gained popularity by

 - appearing in some document that people read for another reason
 - describing the notion they are meant to describe clearly (or
   having some other feature that makes them likeable)

This is how "staging area" has been gaining popularity, I think ---
some (out-of-tree) documentation that is good for other reasons uses
it, and it really does seem to be a clearer term than "index" for
"place where the next commit is being prepared".  Unfortunately, I do
not think it is a clearer term than "index" for "the git index, which
contains stat() information and pointers to blobs that either belong
in the next commit or are participating in a merge conflict".  So it
does not seem to justify rewriting everything to use it.

Which suggests one way forward --- if you believe you have terms that
do describe those concepts clearly, one way to promote them is to
write some good, clear (out-of-tree, to begin with) documentation
using them.  Presumably this documentation would also mention that
other people use other terms to avoid confusing the reader.

Hope that helps,
Jonathan
