From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 11:57:21 +0200
Message-ID: <200610201157.22348.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 11:57:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gar80-0007iv-Ru
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 11:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWJTJ5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Oct 2006 05:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWJTJ5W
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 05:57:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:80 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932242AbWJTJ5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 05:57:21 -0400
Received: by ug-out-1314.google.com with SMTP id o38so704982ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 02:57:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VKemnXfcoqKtbXwhA/SHRqY6dSdNTOyDhSFSamyYkvGjZ3o5oWnfAV9srkHCzAdzh5OR/HE93pJrQBlE4OnNeUMzYQxCmkOUnJer3OyElCZZg648pGifOk59sYoD1KPI2kZPuebXTQWln67DWgxWEAu8/6IcOudiAgYz2pxehrk=
Received: by 10.67.93.7 with SMTP id v7mr1165238ugl;
        Fri, 20 Oct 2006 02:57:19 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id x26sm1031690ugc.2006.10.20.02.57.19;
        Fri, 20 Oct 2006 02:57:19 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45382120.9060702@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29434>

Aaron Bentley wrote:
>> The naming in git really is beautiful and beautifully simple.
>=20
> Well, you've got to admit that those names are at least superficially
> ugly.=20

If you want pretty name, you tag it. Tags are exchanged during=20
fetch/push operation. And you can have pretty names of revisions
like v1.4.3
=20
>> It's not monotonically increasing from one revision to the next, but
>> I've never found that to be an issue. Of course, we do still use our
>> own "simple" names for versioning the releases and snapshots of
>> software we manage with git, and that's where being able to easily
>> determine "newer" or "older" by simple numerical examination is
>> important. I've honestly never encountered a situation where I was
>> handed two git sha1 sums and wished that I could do the same thing.
>=20
> What's nice is being able see the revno 753 and knowing that "diff -r
> 752..753" will show the changes it introduced. =A0Checking the revo o=
n a
> branch mirror and knowing how out-of-date it is.

Huh? If you want what changes have been introduced by commit=20
c3424aebbf722c1f204931bf1c843e8a103ee143, you just do

# git diff c3424aebbf722c1f204931bf1c843e8a103ee143

(or better "git show" instead of "git diff" or "git diff-tree").
If you give only one commit (only one revision) git automatically
gives diff to its parent(s).


By the way, is referring to revision by it's revno _fast_?
--=20
Jakub Narebski
Poland
