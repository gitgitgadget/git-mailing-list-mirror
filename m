From: <dag@cray.com>
Subject: Re: Subtree in Git
Date: Mon, 7 May 2012 10:21:08 -0500
Message-ID: <nng8vh4yq3f.fsf@transit.us.cray.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <greened@obbligato.org>, Herman van Rink <rink@initfour.nl>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 17:22:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRPlj-0004PH-V0
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 17:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247Ab2EGPW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 11:22:28 -0400
Received: from exprod6og109.obsmtp.com ([64.18.1.23]:49746 "EHLO
	exprod6og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab2EGPW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 11:22:27 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob109.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT6foaIHPHlFhG8iE5UpEDpw1lMBkjo4Y@postini.com; Mon, 07 May 2012 08:22:26 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 7 May
 2012 10:21:12 -0500
In-Reply-To: <7v8vh78dag.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 4 May 2012 21:25:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197278>

Junio C Hamano <gitster@pobox.com> writes:

>> This branch seems to have a bunch of commits from master or some other
>> branch:
>
> Isn't the confusing shape of the history a direct result of what Herman
> said he did above, i.e. use of "subtree merge"?  I thought that we agreed
> not to do any more subtree merges for further updates when we slurped the
> subtree history to contrib/ early in this cycle, so if that is the case,
> Herman needs to rebase his work so that the integration will not need any
> "subtree merge" into git.git, perhaps?

I think you're right.

> In short, it is a mess.

I agree.  I think Herman is working to fix it.  A rebase and rework of
the patch set would be very helpful.

> Not very impressed, but I have this suspition that the history I was
> looking at was not what was meant to be sent to me and an older
> incarnation of the project before Herman cleaned it up for public
> consumption, or something.

That's the impression I got as well.

I haven't had a chance to look at Herman's latest tree.

                            -Dave
