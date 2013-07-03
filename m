From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Change "remote tracking" to "remote-tracking"
Date: Wed, 3 Jul 2013 18:43:36 -0400
Message-ID: <20130703224336.GA3702@padd.com>
References: <1372842754-13366-1-git-send-email-mschub@elegosoft.com>
 <20130703183851.GR408@google.com>
 <7vy59ncrjk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 00:39:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuVhj-00082I-5a
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 00:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837Ab3GCWjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 18:39:11 -0400
Received: from honk.padd.com ([74.3.171.149]:57575 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932278Ab3GCWjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 18:39:10 -0400
Received: from tic.padd.com (unknown [50.55.134.154])
	by honk.padd.com (Postfix) with ESMTPSA id 69F1F3397;
	Wed,  3 Jul 2013 15:39:09 -0700 (PDT)
Received: by tic.padd.com (Postfix, from userid 1000)
	id AD273100664; Wed,  3 Jul 2013 18:43:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vy59ncrjk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229542>

gitster@pobox.com wrote on Wed, 03 Jul 2013 13:33 -0700:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Michael Schubert wrote:
> >
> >> --- a/Documentation/git-p4.txt
> >> +++ b/Documentation/git-p4.txt
> >> @@ -180,7 +180,7 @@ subsequent 'sync' operations.
> >>  	Import changes into given branch.  If the branch starts with
> >>  	'refs/', it will be used as is.  Otherwise if it does not start
> >>  	with 'p4/', that prefix is added.  The branch is assumed to
> >> -	name a remote tracking, but this can be modified using
> >> +	name a remote-tracking, but this can be modified using
> >>  	'--import-local', or by giving a full ref name.  The default
> >>  	branch is 'master'.
> >
> > This is confusing both before and after the patch.  What is "a remote
> > tracking"?
> >
> > Perhaps:
> >
> > 	--branch <ref>::
> > 		Import changes into <ref> instead of refs/remotes/p4/master.
> > 		If <ref> starts with refs/, it is used as is.  Otherwise, if
> > 		it does not start with p4/, that prefix is added.
> > 	+
> > 	By default a <ref> not starting with refs/ is treated as the
> > 	name of a remote-tracking branch (under refs/remotes/).  This
> > 	behavior can be modified using the --import-local option.
> > 	+
> > 	The default <ref> is "master".
> >
> > The rest of the patch looks good.
> 
> Myy reading did hiccup at the same "remote-tracking" used as if it
> were a noun, and your rewritten version reads much better.

Yes, very clear and complete rewrite; thanks.  The final
paragraph is perhaps duplicative of the first sentence, but adds
clarity, so I'm happy as it stands.

Acked-by: Pete Wyckoff <pw@padd.com>

		-- Pete
