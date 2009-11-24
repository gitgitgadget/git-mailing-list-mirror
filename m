From: Karl Wiberg <kha@treskal.com>
Subject: Re: [PATCH RFC] git-send-email --expand-aliases
Date: Tue, 24 Nov 2009 08:12:17 +0100
Message-ID: <b8197bcb0911232312l251dfbc9va671388cfb7fe57b@mail.gmail.com>
References: <20091123221628.GE26810@ldl.fc.hp.com>
	 <7v6390sqhz.fsf@alter.siamese.dyndns.org>
	 <20091124004554.GA27643@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 08:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCpZZ-0007Yt-EY
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 08:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030AbZKXHMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 02:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758011AbZKXHMO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 02:12:14 -0500
Received: from mail1.space2u.com ([62.20.1.135]:41016 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758006AbZKXHMN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 02:12:13 -0500
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com [209.85.218.223])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nAO7CB16030300
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 08:12:11 +0100
Received: by bwz23 with SMTP id 23so6023120bwz.29
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 23:12:17 -0800 (PST)
Received: by 10.204.3.219 with SMTP id 27mr5796800bko.127.1259046737419; Mon, 
	23 Nov 2009 23:12:17 -0800 (PST)
In-Reply-To: <20091124004554.GA27643@ldl.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133562>

On Tue, Nov 24, 2009 at 1:45 AM, Alex Chiang <achiang@hp.com> wrote:

> * Junio C Hamano <gitster@pobox.com>:
>
> > If you are changing StGit to call git-send-email anyway, why not
> > arrange stgit to call git-send-email to send the message out
> > instead, instead of sending messages on its own?
>
> Yeah, I thought about that as I was poking around further in StGit
> to figure out how it would be calling git-send-email. ;)
>
> > I imagine the internal implementation of stg mail would work
> > something like:
> >
> > =C2=A0 =C2=A0 prepare messages to send out
> > =C2=A0 =C2=A0 call git-send-email and have it send them
> >
> > What am I missing?
>
> My lack of familiarity with StGit internals. ;)
>
> Your suggestion is much better. I'll take a closer look at StGit and
> see how feasible it is.
>
> Unless Catalin has strong objections?

I think that sounds like a splendid idea. It would be interesting to
see just how thin a wrapper around git send-email (and format-patch)
stg mail could become, without sacrificing features anyone actually
uses. The main complication could be stg mail's templates.

Catalin, how wedded are you to those? ;-)

--=20
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
