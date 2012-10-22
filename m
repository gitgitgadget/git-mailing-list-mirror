From: <dag@cray.com>
Subject: Re: Subtree in Git
Date: Mon, 22 Oct 2012 09:44:29 -0500
Message-ID: <nng6262ftwy.fsf@transit.us.cray.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl>
	<nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl>
	<7vbofwgwso.fsf@alter.siamese.dyndns.org>
	<5084102A.2010006@initfour.nl>
	<7vfw57fvtl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Herman van Rink <rink@initfour.nl>, <greened@obbligato.org>,
	"Hilco Wijbenga" <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:47:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQJHq-0002F2-OS
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 16:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab2JVOrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 10:47:15 -0400
Received: from exprod6og114.obsmtp.com ([64.18.1.33]:44183 "EHLO
	exprod6og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab2JVOrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 10:47:15 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob114.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUIVca6IhCZWiJokrJ2ozwPczxWtCF9Mr@postini.com; Mon, 22 Oct 2012 07:47:14 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Mon, 22 Oct
 2012 09:44:30 -0500
In-Reply-To: <7vfw57fvtl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 21 Oct 2012 12:51:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208192>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't formed an opinion on the particular change as to how bad
> its collapsing unrelated changes into a single change is. Maybe they
> are not as unrelated and form a coherent whole.  Maybe not.  

It is difficult for me to tell which is one of the red flags that caused
me to request breaking it up.  It's much to hard to review this patch as
it is.  It conflates multiple features and bug fixes.  It includes
comments to the effect of, "I don't like this but I don't know of a
better way."  Part of the reson we do reviews is to have people help out
and find a better way.  I don't think people can do that with the way
the patch is currently structured.

> Note that I was not following the thread very closely, so I may have
> misread the discussion.  I read his "Unless Junio accepts..." to
> mean "I (dag) still object, but if Junio accepts that patch I object
> to directly, there is nothing I can do about it".  That is very
> different from "I am on the fence and cannot decide it is a good
> patch or not.  I'll let Junio decide; I am OK as long as he is".

Yopur first reading is the correct one.

                              -David
