From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Numeric Revision Names?
Date: Sun, 5 Oct 2008 00:13:43 -0300
Message-ID: <b8bf37780810042013g57fc7073xd638e44bb666bf@mail.gmail.com>
References: <19796862.post@talk.nabble.com>
	 <m3d4ihr7as.fsf@localhost.localdomain>
	 <20081003115557.08d80c2f.stephen@exigencecorp.com>
	 <200810031913.55594.trast@student.ethz.ch>
	 <20081003124224.843a5a21.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Thomas Rast" <trast@student.ethz.ch>,
	"Jakub Narebski" <jnareb@gmail.com>,
	marceloribeiro <marcelo@sonnay.com>, git@vger.kernel.org
To: "Stephen Haberman" <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 05:14:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmK5B-0006VO-Nb
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 05:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbYJEDNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Oct 2008 23:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbYJEDNq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 23:13:46 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:16308 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbYJEDNp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Oct 2008 23:13:45 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1672436fkq.5
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 20:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qv0obbj5N8enY9D23aM5FL69EndOrFZ07teZGzbAJ/s=;
        b=V0aptswfFof5TQ9HsRk05Xts2lyQmELCpM4Agd3gYKlbiXVjS2pLcNlb+riwZjbz6N
         hw/rdj7bhM9Cug1oBgptwD8IFImGKee2g4BK0fXYtTlXxW/OdaXqAaXDjX48DihWt8UC
         m+/df2FonXQjxhF4zCXnVKmDffXtEcgCKMhNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fF264oWIBMelPrlUlTci/Qpqd/jiKQUymcqsyRXzHZBFwvQMBLG/CgoMGHlg5+KXPJ
         OGmW6pJ//unOoKxcXNvUu42H5ZvPITrA6DrlSE5u5p1Mw5P73dJKyxNEw1CPlmoGHUPT
         peXOh4v8eD+/BFMYaqtT/YPIwYsL0Ldu2FI8k=
Received: by 10.187.225.12 with SMTP id c12mr798711far.88.1223176423300;
        Sat, 04 Oct 2008 20:13:43 -0700 (PDT)
Received: by 10.187.189.11 with HTTP; Sat, 4 Oct 2008 20:13:43 -0700 (PDT)
In-Reply-To: <20081003124224.843a5a21.stephen@exigencecorp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97496>

> For projects that do have a central authority (e.g. internal corporat=
e
> projects), revision numbers make more sense.

Surely!

> Granted, they are on separate branches (like svn), but the nice thing
> about them is that they are monotonically increasing. E.g. our qa
> people love numbers--the bug fix ticket says dev just put in
> r100...qa/production box says it is on r95. Doesn't matter the
> branch/whatever, they know the box doesn't have r100. Now, right, if
> its r105, it is trickier, although we also throw in branch name (e.g.
> topica-r100) which means no false positives but can lead to false
> negatives.

Yes

> haven't gotten to it yet. For now I've just attached the commit
> numbers script.

It would be good to have this feature in git.

> For our team, lack of monotonic version numbers was a big deal--as in
> can't use git sort of big deal. I wouldn't be surprised if it is a

Yes, it's true that this is a big deal for many people out there.

> contributing factor that keeps other people, especially internal team=
s,
> from git. I understand all of the reasons it can't be in git proper,
> but an FAQ entry about the hook/tag hack or link to a contrib script
> might be useful (not necessarily the one attached, given its
> functions/etc. baggage).

That would be helpful, if it cannot go in git proper for real in the
centralized model.

> (I also face/faced a situation where "monotonic revision numbers" wer=
e
> essentially a check box item on a required list of SCM features, so
> despite whatever I/the-git-team/etc. thought about their technical
> inferiority, it was a criteria that could have ruled git out for us.
> Hence my mentioning an FAQ entry for others faced with my same
> political situation.)
>

This is so true in a corporate environment with centralized
repositories, then I completely agree
that in the case git is being used in this model (many companies are
really used to that), the
monotonic revision number is helpful and sometimes is showstopper to
not have them.

Regards,
--=20
[]s,
Andr=E9 Goddard
