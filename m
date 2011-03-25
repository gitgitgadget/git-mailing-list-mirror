From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: start of git2 (based on libgit2)
Date: Sat, 26 Mar 2011 00:54:25 +0100
Message-ID: <4D8D2B31.4040908@lyx.org>
References: <20110325231203.GA7961@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TW90aWVqdXMgSmFrxaF0eXM=?= <desired.mta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:54:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Gq1-0005wK-3T
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 00:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468Ab1CYXy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 19:54:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48941 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab1CYXy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 19:54:26 -0400
Received: by wwa36 with SMTP id 36so1929515wwa.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 16:54:25 -0700 (PDT)
Received: by 10.227.1.102 with SMTP id 38mr1299862wbe.109.1301097264944;
        Fri, 25 Mar 2011 16:54:24 -0700 (PDT)
Received: from [192.168.101.108] (62-193-62-123.stella-net.net [62.193.62.123])
        by mx.google.com with ESMTPS id o23sm688144wbc.61.2011.03.25.16.54.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 16:54:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110325231203.GA7961@jakstys.lt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170034>

On 26-3-2011 0:12, Motiejus Jak=C5=A1tys wrote:
> Hello,
>
> I wrote similar letter before, but did not receive feedback I was exp=
ecting.

I wrote a mail on the same topic to the libgit2@librelist.org=20
mailinglist, because I got interested in the same project (although I=20
will not be a GSoC student).

http://librelist.com/browser/libgit2/
> According to Jeff King[2], I should start with plumbing commands. I
> agree.  However, how deep?  I.e. do I have to make sure all git rev-l=
ist
> possible arguments are implemented?

I guess a lot can be copied from Git itself. Actually builtin/rev-list.=
c=20
consists mostly of command line arguments parsing methods, and=20
outputting functions. The key is to parse what you want to know and ask=
=20
libgit2 to provide the info. If libgit2 has implemented the basic=20
functionality that is needed, the rest would be relatively simple.

> Are we aiming for a distributed 100s of executables architecture
> (current git), or single huge binary? I would go for single executabl=
e
> for to higher portability. Is that ok?

AFAICS, current git is a single binary on Windows already.

> Build tool. Currently libgit2 uses waf. I am not against it (I've cho=
sen
> waf for one of my own C++ projects), However, it's too clumsy for me.=
 Is
> it me who lacks experience? Scons looks much easier for me. Moreover,=
 we
> do not need automatic configuration, so it makes waf "overfeatured".

Why not CMake which is also used for libgit2 ?

I already wrote a CMakeLists file for your git2 app.

> I am a student and would like to do this take this up in GSOC. I just
> received a letter from Vicent Marti with sort of confirmation that th=
e
> project is interesting for the community.

As you know, this project can be possibly fulfilled by a GSoC student=20
(either you or someone else). Maybe people are awaiting this before=20
diving into the project.

Vincent
