From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: cc/cherry-pick-ff (Re: What's cooking in git.git (Mar 2010, #04; Tue, 16))
Date: Thu, 18 Mar 2010 01:38:56 +0100
Message-ID: <201003180138.56529.chriscool@tuxfamily.org>
References: <7vhbof4fof.fsf@alter.siamese.dyndns.org> <20100317095218.GA6961@progeny.tock> <7vwrxaubjy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 01:50:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns3wr-0005aI-GB
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 01:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab0CRAus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 20:50:48 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46580 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab0CRAur convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 20:50:47 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 05222818075;
	Thu, 18 Mar 2010 01:50:39 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AA07A818078;
	Thu, 18 Mar 2010 01:50:36 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vwrxaubjy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142444>

On Wednesday 17 March 2010 18:01:53 Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > For what it=E2=80=99s worth, I am not convinced about the --no-ff o=
ption.  I do
> > not think --ff ever will be the default: for an operation that amou=
nts
> > to applying a patch and making a new commit, it just feels wrong.
>=20
> Same here ;-) and because of that, --no-ff as an undocumented feature
> feels doubly wrong to me.  If some scripts use it, people would wonde=
r
> what that no-op option is doing there.  Perhaps we should discard the=
 bits
> about --no-ff to make it more clear that --ff is an oddball case that=
 is
> meant only for supporting what "rebase-i" (and other tools that reinv=
ent
> and enhance it) does.

My opinion is that if we implement "git cherry-pick A..B", and if many =
people=20
start to use it, then perhaps it will make sense for --ff to become the=
=20
default. Because people may not want to have to remember using --ff to =
avoid=20
many spurious commits to be created.

And having --ff and --no-ff makes "git cherry-pick" consistent with "gi=
t merge"=20
which has both. And --ff is the default for "git merge", so consistency=
 will be=20
an argument to make it the default for "git cherry-pick" if "git cherry=
-pick=20
A..B" is used a lot.

Best regards,
Christian.
