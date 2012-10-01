From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Deletion of remote branches
Date: Mon, 1 Oct 2012 21:12:10 +0100
Organization: OPDS
Message-ID: <583784AD1BE54FD582B1D58FE7F4CADA@PhilipOakley>
References: <CC8F65C7.E79%jens.hausherr@xing.com> <7v1uhids5a.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jens Hausherr" <Jens.Hausherr@xing.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 22:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TImLo-00025Q-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 22:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab2JAUMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2012 16:12:13 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:60742 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223Ab2JAUMM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 16:12:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArANAPn3aVBcHmKZ/2dsb2JhbABFhguFP7FpAQECgQuBCYIbBQEBBAEIAQEZDwEFHgEBIQUGAgMFAgEDFQUCBSECAhQBBBoGBxcGARIIAgECAwGHbgqmIJMJgSGKBy8+KT6DXDJgA41pmCuCaIFZ
X-IronPort-AV: E=Sophos;i="4.80,517,1344207600"; 
   d="scan'208";a="395124136"
Received: from host-92-30-98-153.as13285.net (HELO PhilipOakley) ([92.30.98.153])
  by out1.ip05ir2.opaltelecom.net with SMTP; 01 Oct 2012 21:12:09 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206764>

=46rom: "Junio C Hamano" <gitster@pobox.com>
> Jens Hausherr <Jens.Hausherr@xing.com> writes:
>
>> I came across an issue with deleting remote branches: When deleting =
a
>> branch using "git branch =C2=ADr =C2=ADd <branch>" the branch is del=
eted and no
>> longer shown by "git branch =C2=ADr".
>>
>> "git ls-remote --heads" on the other hand still lists the ref for th=
e=20
>> last
>> branch commit.
>>
>> If I delete the branch using "git push origin :<branch>" the branch=20
>> is
>> removed completely (i.e. git ls-remote  no longer returns a ref).
>
> All of the above are expected and working as designed.  Remote
> tracking branches are local _copies_ of what you have over there at
> the remote repository. The latter is the authoritative version, and
> you asked "ls-remote" to go over the network to view them.
>
Is there a definitive naming convention for the two types of 'remote=20
branch'?

IIRC (somewhere) the 'tracking' term was to be deprecated, though it is=
=20
still in common use. It is usually only the context that clarifies if i=
t=20
is the local or the distant copy/repo.

Distinct names make for less confusion.

> If you are trying to remove the branches you show to others and
> yourself who are observing that remote repository from your local
> workstation, you can first "git push origin :<branch>" to remove it
> in the remote repository. You can run your next fetch with "--prune"
> to get rid of remotes/origin/<branch>, I think.
>

Philip=20
