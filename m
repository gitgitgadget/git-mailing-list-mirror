From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] Change "remote tracking" to "remote-tracking"
Date: Thu, 4 Jul 2013 11:05:12 +0200
Message-ID: <20130704090511.GA5317@pc>
References: <1372842754-13366-1-git-send-email-mschub@elegosoft.com>
 <20130703183851.GR408@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Pete Wyckoff <pw@padd.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 11:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UufdV-0003DW-FP
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 11:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933682Ab3GDJP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 05:15:29 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:58357 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933532Ab3GDJP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 05:15:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 19856DE051;
	Thu,  4 Jul 2013 11:15:28 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ga6zY7pjPGET; Thu,  4 Jul 2013 11:15:28 +0200 (CEST)
Received: from localhost (g226055195.adsl.alicedsl.de [92.226.55.195])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id CDB66DE00E;
	Thu,  4 Jul 2013 11:15:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130703183851.GR408@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229563>

On Wed, Jul 03, 2013 at 11:38:51AM -0700, Jonathan Nieder wrote:
> Michael Schubert wrote:
> 
> > --- a/Documentation/git-p4.txt
> > +++ b/Documentation/git-p4.txt
> > @@ -180,7 +180,7 @@ subsequent 'sync' operations.
> >  	Import changes into given branch.  If the branch starts with
> >  	'refs/', it will be used as is.  Otherwise if it does not start
> >  	with 'p4/', that prefix is added.  The branch is assumed to
> > -	name a remote tracking, but this can be modified using
> > +	name a remote-tracking, but this can be modified using
> >  	'--import-local', or by giving a full ref name.  The default
> >  	branch is 'master'.
> 
> This is confusing both before and after the patch.  What is "a remote
> tracking"?
> 
> Perhaps:
> 
> 	--branch <ref>::
> 		Import changes into <ref> instead of refs/remotes/p4/master.
> 		If <ref> starts with refs/, it is used as is.  Otherwise, if
> 		it does not start with p4/, that prefix is added.
> 	+
> 	By default a <ref> not starting with refs/ is treated as the
> 	name of a remote-tracking branch (under refs/remotes/).  This
> 	behavior can be modified using the --import-local option.
> 	+
> 	The default <ref> is "master".

Thanks.
