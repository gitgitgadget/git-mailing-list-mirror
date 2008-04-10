From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: git annoyances
Date: Thu, 10 Apr 2008 14:45:36 -0500
Message-ID: <5d46db230804101245yf4a0c22qaee99f2c01256938@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
	 <b8bf37780804091656s2f24ebe5h758884e63cea4845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Ingo Molnar" <mingo@elte.hu>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:50:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk2jT-000863-J9
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 21:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758466AbYDJTpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2008 15:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757792AbYDJTpm
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 15:45:42 -0400
Received: from ti-out-0910.google.com ([209.85.142.185]:58302 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332AbYDJTpl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2008 15:45:41 -0400
Received: by ti-out-0910.google.com with SMTP id 28so159416tif.23
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 12:45:39 -0700 (PDT)
Received: by 10.151.39.2 with SMTP id r2mr2201994ybj.243.1207856736153;
        Thu, 10 Apr 2008 12:45:36 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Thu, 10 Apr 2008 12:45:36 -0700 (PDT)
In-Reply-To: <b8bf37780804091656s2f24ebe5h758884e63cea4845@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79244>

On Wed, Apr 9, 2008 at 6:56 PM, Andr=E9 Goddard Rosa
<andre.goddard@gmail.com> wrote:
> >  > but it was a PITA and all of git's messages about the problem we=
re not
>  >  > only unhelpful, they confused me into looking for problems wher=
e there
>  >  > were none IMO.
>  >
>  >  Yes, we need to teach "git" to do more mind-reading (I am not bei=
ng
>  >  sarcastic).  There should be a pattern in common user errors that=
 share
>  >  their roots to the same user misperception, and if we can identif=
y that,
>  >  maybe we can make git guess what the user was really trying to do=
 and give
>  >  better error messages than it currently does.
>
>  Something along the lines of:
>
>  Error description
>  Why it happened
>  How to solve/Sugestion
>

Hi,

This actually touches on one of my main purposes  behind Pyrite.  I int=
end to
do the following things to help the situation and I was wondering what =
the
git community's reaction is.

1) Since it will be designed for end users I intend to remove the optio=
ns not
designed for end users.  This will also shorten up the help so that the=
 entire
help can be shown to the user when they encounter an error.

2) No unnamed options.  I think this would have helped the above case
although it would have required a *bit* more typing.  The command would
have looked like "pyt pull/fetch -r x86 -b latest"  Combined with the a=
bove
the command would have spit out the help and a message stating what was
missing.

3) No syntax.  Git has a lot of syntax.  It has refspecs, revision rang=
es,
symbolic names (although i do like these) that a user has to learn.  I
think this
is one of the most error prone parts of the git for new users.
Hopefully, I will
be able to find simple and straightforward ways for the user to supply
this info.

Any comments/suggestions will be appreciated.

Thanks,
Govind.
