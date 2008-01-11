From: Florian La Roche <laroche@redhat.com>
Subject: Re: [PATCH] gitweb: Change feeds from commit to commitdiff output.
Date: Fri, 11 Jan 2008 07:53:48 +0100
Message-ID: <20080111065348.GA3967@dudweiler.stuttgart.redhat.com>
References: <20080110130900.GA9395@dudweiler.stuttgart.redhat.com> <7vtzll5t4u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 07:54:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDDme-0007T8-7G
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 07:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbYAKGx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 01:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbYAKGx7
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 01:53:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbYAKGx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 01:53:58 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0B6rn25011614;
	Fri, 11 Jan 2008 01:53:49 -0500
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0B6rmID017068;
	Fri, 11 Jan 2008 01:53:48 -0500
Received: from dudweiler.stuttgart.redhat.com (vpn-4-21.str.redhat.com [10.32.4.21])
	by pobox.stuttgart.redhat.com (8.13.1/8.13.1) with ESMTP id m0B6rlf7018279;
	Fri, 11 Jan 2008 01:53:48 -0500
Received: from dudweiler.stuttgart.redhat.com (localhost.localdomain [127.0.0.1])
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8) with ESMTP id m0B6rm54004845;
	Fri, 11 Jan 2008 07:53:48 +0100
Received: (from laroche@localhost)
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8/Submit) id m0B6rmQ1004842;
	Fri, 11 Jan 2008 07:53:48 +0100
Content-Disposition: inline
In-Reply-To: <7vtzll5t4u.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70125>

On Thu, Jan 10, 2008 at 12:21:21PM -0800, Junio C Hamano wrote:
> Florian La Roche <laroche@redhat.com> writes:
> 
> > [PATCH] gitweb: Change feeds from commit to commitdiff output.
> >
> > Change feeds from displaying the commit to displaying the commitdiff
> > output. This way the patches are shown directly and code review is
> > done more easily via watching feeds.
> >
> > Signed-off-by: Florian La Roche <laroche@redhat.com>
> 
> I can see that easier access to commitdiff output is sometimes
> desirable.
> 
> If you are making this change unconditional, however, I think
> there needs a list discussion between you and the silent
> majority of people that have been perfectly happy with the
> current "log only" behaviour.


Hello Junio,

Right, this is a change in behaviour. Maybe a config option
for this would be good, so that users can configure their
wanted output style.


> And to have that discussion, you first have to wake them up,
> which this patch would serve well as a wake-up call.  But if
> that was the purpose of the posting, please (1) mark the patch
> as such (commonly done by saying [RFC/PATCH] instead), and (2)
> keep me out of the "To:" list, if the patch is not for inclusion
> but for discussion ("cc:" is fine but it's redundant as long as
> you are sending to the list).


Ok.


> After such a discussion, we may end up finding out that
> everybody have been silently unhappy and wanted to have
> commitdiff there, and agree on doing this unconditionally.
> 
> But we do not know that yet.


>From asking people, most don't use feeds to follow development
checkins, but prefer to keep with mailinglists and looking only
at the repos for their own interesting parts.

Hope more people will speak up here on the git@ list.

Thanks a lot,

Florian La Roche
