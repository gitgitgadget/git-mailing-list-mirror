From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Fri, 9 Aug 2013 16:19:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1308091618530.24252@s15462909.onlinehome-server.info>
References: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com> <1375983492-32282-2-git-send-email-stephen@exigencecorp.com> <alpine.DEB.1.00.1308082314320.24252@s15462909.onlinehome-server.info> <20130808163539.0b59b20a@sh9>
 <7vd2pn977v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 16:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7nXm-000292-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 16:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610Ab3HIOTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 10:19:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:61938 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030568Ab3HIOTm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 10:19:42 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LcBBl-1Vonv70yBB-00jbW9
 for <git@vger.kernel.org>; Fri, 09 Aug 2013 16:19:40 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vd2pn977v.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:X5hqJeD4ZGP3sd4PzNs+SqOHwvSEhTNassRcoSKnZYYpv0PHsSn
 TOAv5K2Q1HvW+iIajYXmj9XE0gpnU1bzh+n1PeZR579eIXFSHBaWtwCDMKBdc+C7oQfTNJf
 SF5iiTOa592LF0sKj5sX2OJghFEr4QJJTHzc1fky1hnmGpQd7QQZZ63nivyoffG8S8MX8A0
 POrNV5IYsKhJNzRoRmZnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231983>

Hi,

On Thu, 8 Aug 2013, Junio C Hamano wrote:

> Stephen Haberman <stephen@exigencecorp.com> writes:
> 
> > Hi Johannes,
> >
> >> This should probably be added to config.txt and
> >> Documentation/git-pull.txt, too, right?
> >
> > Yep, I meant to note that I'd do that after getting an initial
> > confirmation that the pull.preserve-merges was the preferred approach.
> 
> If you were to go that route, no dashes in the last component of
> configuration variable names, please.
> 
> > (I was being lazy and didn't want to write up docs only to switch to
> > overloading pull.rebase or what not.)
> 
> I think we have a recent update that allows you to say
> 
> 	[pull]
>         	rebase = false
> 
> to mean "I want 'git pull' to use merge".  Currently the other
> choice is:
> 
> 	[pull]
> 		rebase = true
> 
> to say "I want to run 'git pull --rebase'".  I do not think it is
> unreasonable to extend it further so that
> 
> 	[pull]
> 		rebase = preserve
> 
> is understood.

We have a patch in Git for Windows allowing rebase = interactive which I
did not have time to send upstream.

Ciao,
Johannes
