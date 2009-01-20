From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH resend] bash completion: add 'rename' subcommand to git-remote
Date: Tue, 20 Jan 2009 19:21:09 +0100
Message-ID: <200901201921.10223.markus.heidelberg@web.de>
References: <200901162254.58300.markus.heidelberg@web.de> <20090116221203.GP10179@spearce.org> <7vd4em8ilx.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 19:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPLF9-0007Ay-QW
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 19:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbZATSVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 13:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbZATSVK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 13:21:10 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:59532 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbZATSVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 13:21:08 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id ACD2CF92A361;
	Tue, 20 Jan 2009 19:21:06 +0100 (CET)
Received: from [89.59.121.55] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LPLDm-0004QZ-00; Tue, 20 Jan 2009 19:21:06 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vd4em8ilx.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+k8N9qkSogb3cidWWoaDpby8BtQ/E5FhNpkptT
	EMGURVjYxdVNamU+n5f07Y4hixnnKG4wafvOLKm/zF8SLrJ0ZG
	sTtPbMxgiK4iF6CatyBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106507>

Junio C Hamano, 17.01.2009:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Markus Heidelberg <markus.heidelberg@web.de> wrote:
> >> 
> >> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> >
> > Acked-by: Shawn O. Pearce <spearce@spearce.org>
> >
> >> 	I've just accidently read in the completion file itself, that
> >> 	Shawn is the maintainer, so I give it a third try. The first two
> >> 	haven't been sent to him.
> >
> > Sorry, I must have missed the other two attempts.  :-)
> 
> And I seem to have missed all three.

I really don't like to bother you again, but compared to the inclusion
of the other patches, I guess you have forgotten the third try of this
patch.

Thus this fourth try :)

Markus


> >>  contrib/completion/git-completion.bash |    4 ++--
> >>  1 files changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> >> index 049ded0..6623344 100755
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -1384,7 +1384,7 @@ _git_config ()
> >>  
> >>  _git_remote ()
> >>  {
> >> -	local subcommands="add rm show prune update"
> >> +	local subcommands="add rename rm show prune update"
> >>  	local subcommand="$(__git_find_subcommand "$subcommands")"
> >>  	if [ -z "$subcommand" ]; then
> >>  		__gitcomp "$subcommands"
> >> @@ -1392,7 +1392,7 @@ _git_remote ()
> >>  	fi
> >>  
> >>  	case "$subcommand" in
> >> -	rm|show|prune)
> >> +	rename|rm|show|prune)
> >>  		__gitcomp "$(__git_remotes)"
> >>  		;;
> >>  	update)
> >> -- 
> >> 1.6.1.35.g0c23
