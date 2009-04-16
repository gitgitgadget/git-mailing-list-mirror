From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: integrating make and git
Date: Thu, 16 Apr 2009 10:05:56 +0200
Message-ID: <8763h5qazf.fsf@krank.kagedal.org>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com> <loom.20090416T034427-809@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:07:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuMdP-0006Xd-Am
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 10:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbZDPIGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2009 04:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZDPIGO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 04:06:14 -0400
Received: from main.gmane.org ([80.91.229.2]:47785 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbZDPIGM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 04:06:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LuMbp-0002OJ-Ea
	for git@vger.kernel.org; Thu, 16 Apr 2009 08:06:09 +0000
Received: from cust-ip-10.data.tre.se ([80.251.207.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 08:06:09 +0000
Received: from davidk by cust-ip-10.data.tre.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 08:06:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cust-ip-10.data.tre.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:JLCakL9HXimWaKaIZNvwoj7fgug=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116682>

Ben Jackson <ben@ben.com> writes:

> E R <pc88mxer <at> gmail.com> writes:
>
>> Now suppose that making 'lib1' only depends on the source code in a
>> certain directory. The idea is to associate the hash of the source
>> directory for lib1 with its the derived files. Make can check this t=
o
>> determine if the component really needs to be rebuilt.
>
> ClearCase has "wink-ins" which are very much like this.  It knows tha=
t a given
> object was produced from a certain set of sources with a particular c=
ommand.=20
> When someone wants to recreate that object (not even necessarily the =
original
> builder) it can "wink in" the result.  Typically a brand new "view" (=
a ClearCase
> working directory) build will consist of winking in a ton of objects =
rather than
> building anything.  I'm not sure how much of this is due to clevernes=
s in
> clearmake and how much is due to the view being implemented as a virt=
ual
> filesystem (which can see every repository file being read as part of=
 a build).

It very much depends on implementing its own file system, since it
otherwise would have no idea what the *real* build dependencies are.

That one of the nice things about clearmake, by the way. You don't
have to worry much about describing the dependencies, since it will
figure it out all by itself when you first build the project.

But I don't think there is much in CC for git to copy... :-)

--=20
David K=C3=A5gedal
