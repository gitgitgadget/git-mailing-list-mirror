From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 14:18:57 -0600
Message-ID: <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <87ps9d7j6t.fsf@morpheus.local>
	 <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 21:19:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7HFQ-0006x5-II
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 21:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbXAQUTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 15:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbXAQUTA
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 15:19:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:34182 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735AbXAQUS7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jan 2007 15:18:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2083154uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 12:18:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NeMdhzJy22NSNHbLbm/bQRCDvQ4eEBpyLRmZn6mRPOnJeSDwwKEsaevBFExxGjkUoMA4W/wJ6PCufjShd9fr8KnxYadT3OJEApAaQ/Oz+3i1V4QMg2ipiCRfjPnPlmKuE9Id3mZDvsEwcXgoQwBK9+2dEnjfqm26EMHLp89MuRc=
Received: by 10.82.120.15 with SMTP id s15mr1616242buc.1169065137744;
        Wed, 17 Jan 2007 12:18:57 -0800 (PST)
Received: by 10.82.107.1 with HTTP; Wed, 17 Jan 2007 12:18:57 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37037>

On 1/17/07, Junio C Hamano <junkio@cox.net> wrote:
> David K=E5gedal <davidk@lysator.liu.se> writes:
>
> > "Josh Boyer" <jwboyer@gmail.com> writes:
> >
> >> I use git quite a bit to track my changes and then use
> >> git-format-patch to generate patches to send on to others.  For th=
e
> >> most part, it works great but I find myself constantly doing:
> >>
> >> mv xxxx-foo.txt xxxx-foo.patch
> >
> > Seconded. I would even prefer .patch to be default, but I guess a
> > config parameter would help me there.
>
> Two minor objections to changing the default are: (1) it's a
> change and any change is bad ;-) and (2) the reason I changed it
> to .txt before submitting the original format-patch to Linus was
> because Emacs wanted to go into its "diff" mode when files are
> named with .patch suffix, which had two annoyances (read-only by
> default, and editing patch tried to automatically recount diff
> and its recounting screwed up in some cases I do not remember
> the details about).

Well there's your problem.  You're using Emacs.  ;)

Seriously though, I'll try and fix up the patch a bit soon and resubmit=
=2E

josh
