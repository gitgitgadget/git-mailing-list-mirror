From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Fri, 5 Feb 2010 00:38:51 +0100
Message-ID: <cb7bb73a1002041538m64c6a6b3p5ee8bbaf0d78457@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vpr4lhsfu.fsf@alter.siamese.dyndns.org> <7v4olxhrti.fsf@alter.siamese.dyndns.org> 
	<201002041821.22864.jnareb@gmail.com> <cb7bb73a1002041208q54ff1f57y3202e88ae2f5f44e@mail.gmail.com> 
	<7vaavo90ic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:39:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdBI7-00038j-VF
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 00:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132Ab0BDXjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 18:39:14 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:56999 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933112Ab0BDXjN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 18:39:13 -0500
Received: by ewy28 with SMTP id 28so3615435ewy.28
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9ZlsphjHBp7v6LXw7omHth2Hc6UPuGGp1Ba+4ObG1rs=;
        b=veTZdvDwaDhg7YSjwXr+qyGdY4LA0ItEOlPpHaPWTSClXdvz78Oxraj5pAhWHQ4kqO
         Ie8Um2B/AWNjnlWyDF5opdj6qsqDu98pxJilkM3oUfGDoatPaoJfTZb8J748fehPqxL7
         JM0LIHqQC5j1pkF23wAIg0aNT3g3jl+YklVwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Th1IkN6JCdRBZS4cb+UP+OvWwJ17dj/rZxcjH+oJLbVVbsBWhwphRckB4s4TLYA/OP
         KL3vN2V2yRnYTIaGcacc5Kwro5MEHdFG5brB+cBmZ7Th9HygctX3MLSIpxjVbCV/oHE5
         EcKO/iO2O+OJ9xV+l+Udxc1zdlsuXx/tY9S5E=
Received: by 10.213.103.134 with SMTP id k6mr393107ebo.2.1265326751219; Thu, 
	04 Feb 2010 15:39:11 -0800 (PST)
In-Reply-To: <7vaavo90ic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139012>

On Thu, Feb 4, 2010 at 10:03 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> AFAIU, the note code on the core side already creates a fan-out struc=
ture
> when notes tree gets large (see recent "What's cooking"; the series i=
s
> parked in 'pu' but that is primarily because we are in feature freeze=
); it
> is not just "inherently not robust" but is much closer to "broken fro=
m day
> one" ;-). =A0Otherwise I wouldn't have wasted time to point it out.

Ouch, I hadn't considered that, indeed.

> Your code is a very good proof-of-concept, though.

Thanks. I guess at this point a proper implementation can wait for the
necessary core support functions.

> Regarding support of multiple notes hierarchies, listing, etc.
>
> See for example:
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/138079/focu=
s=3D138128
>
> I expect more ideas from needs by end-user would come, as we gain
> experience with using notes in real projects. =A0You will certainly f=
ind
> some other needs of your own, like the "not an environment but a comm=
and
> line option" which Jakub mentioned, and "multiple hierarchies" like b=
oth
> you and I found need for. =A0Share them and let us together make the =
notes
> mechanism nicer to use.

Collecting those ideas together would also help define some sort of
roadmap, or at least have a clear idea of what's needed, to help drive
the design of the features themselves. Maybe we could start a TODO
page on the wiki collecting these ideas?

--=20
Giuseppe "Oblomov" Bilotta
