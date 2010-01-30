From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 00:11:55 -0500
Message-ID: <76718491001292111y2d15620ei8a12c081a9283a07@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
	 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
	 <7viqakcu56.fsf@alter.siamese.dyndns.org>
	 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
	 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
	 <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com>
	 <alpine.LFD.2.00.1001292208470.1681@xanadu.home>
	 <ca433831001291959m76ed6adap32a17c10e465af1f@mail.gmail.com>
	 <alpine.LFD.2.00.1001292305500.1681@xanadu.home>
	 <alpine.LFD.2.00.1001292352540.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:12:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5cn-0001vm-LO
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087Ab0A3FL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 00:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070Ab0A3FL5
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:11:57 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:59584 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0A3FL4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 00:11:56 -0500
Received: by iwn39 with SMTP id 39so756039iwn.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 21:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3jxPp2mZ1co/5r/4XpOA1ZXIcqADuYAM0YBLyuXvn9Y=;
        b=N4OBzk5gON/j03lMq5zfpNco29YmWE5F8SlDlu/SZM7MF2vN3K/HogG1di/kQeD7Zl
         V8nU2rdb/mr3GIb2akcf8tx+IiJtH0VP8lQIK0PX0bqPd1EPz1dbSfRoeb12KQI+2ddW
         A72nXJj1FiS9JlhP8B0KEMxwdr+zAjxjTx4Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bm9NyC42EpIms6ikRGXq/5lityxUIyD/GRGnfnp6ZOjrCnaytD9Y3gM8FsHJ9FDs/K
         /GpRYKdxc+1Y5+1DN0cTH+0U7Ie6B6+tK46/HtEEzXKODVmTBZKOsShRFgg2MMmMyYI1
         /Pylqur34YsdUvYvijqzK7Yvi3+EhIfzDOBrY=
Received: by 10.231.169.71 with SMTP id x7mr2878166iby.18.1264828315544; Fri, 
	29 Jan 2010 21:11:55 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001292352540.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138444>

On Sat, Jan 30, 2010 at 12:05 AM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> Thinking more about it, I still consider that making 'git commit' mor=
e
> noisy is the wrong approach. =C2=A0Again, the problem is not about ma=
king
> commits on a detached HEAD. =C2=A0but rather about losing those commi=
ts at
> the next 'git checkout'. =C2=A0Probably a warning should be made when=
 that
> checkout is attempted after one or more commits were made on a detach=
ed
> HEAD instead, and refuse the checkout by default unless it is forced =
(-f
> is already taken for some other force meaning). =C2=A0The warning sho=
uld say
> how not to lose those commits by suggesting a branch creation, or giv=
e
> the hint for performing the checkout anyway.

This sounds right to me too. There's nothing wrong with having a
detached HEAD, and nothing wrong with creating commits in that state.
You're effectively creating an anonymous branch in the DAG and it's
subject to garbage collection if you move away from that anonymous
branch w/o naming it.

Pedantic note: you don't lose those commits at the next checkout. They
are merely subject to garbage collection (and not until they age out
of HEAD's reflog). I know you know that, just being precise. :-)

j.
