From: Mark Hills <mark@pogo.org.uk>
Subject: Re: sharedRepository derived from file permissions
Date: Wed, 17 Oct 2012 13:25:32 +0100 (BST)
Message-ID: <1210171258060.22876@wes.ijneb.com>
References: <1210080955590.12283@wes.ijneb.com> <7vhaq4nc7g.fsf@alter.siamese.dyndns.org> <1210170009180.2113@vega> <7vfw5dpmkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 14:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOSh1-000179-5T
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 14:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab2JQMZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 08:25:36 -0400
Received: from mx.ij.cx ([212.13.201.15]:51411 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756675Ab2JQMZf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 08:25:35 -0400
Received: from mark (helo=localhost)
	by wes.ijneb.com with local-esmtp (Exim 4.77)
	(envelope-from <mark@pogo.org.uk>)
	id 1TOSgm-0002tS-Mp; Wed, 17 Oct 2012 13:25:32 +0100
In-Reply-To: <7vfw5dpmkv.fsf@alter.siamese.dyndns.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207913>

On Wed, 17 Oct 2012, Junio C Hamano wrote:

> Mark Hills <mark@pogo.org.uk> writes:
> 
> >> > It looks like it might be easier (and less confusing to users) to derive 
> >> > this attribute from the top-level .git directory?
> >> 
> >> Hrm, clever ;-)
> >> 
> >> > Is there a reason why Git doesn't just follow (and echo) the top-level 
> >> > permissions?
> >> 
> >> Other than "we did not trust that all the end users are capable of
> >> doing the right 'chmod 2775 .git && chgrp project .git", with a
> >> little bit of "we didn't think of that when we wrote the system", I
> >> do not recall any.
> >
> > Thanks. If I understand, you mean it might be worth a try to implement 
> > this.
> 
> Not really.
> 
> I still do not think that all the end users are capable of doing the
> right 'chmod 2775 .git && chgrp project .git' themselves.

But with the current method, users still have to do this _and_ set 
sharedRepository=.

It would make things hard or impossible if we assume that a user wanting 
to share a repository does not understand file modes or groups.

-- 
Mark
