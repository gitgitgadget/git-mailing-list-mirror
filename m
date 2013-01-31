From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 12:04:34 -0800
Message-ID: <20130131200434.GI27340@google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org>
 <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10NZ-0006mb-J2
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab3AaUEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:04:40 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41603 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab3AaUEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:04:39 -0500
Received: by mail-pb0-f52.google.com with SMTP id mc8so1018461pbc.25
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 12:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3XHhI3SzyXqHzECXGd9F5jY5B05hCAY91w12HHFqYV0=;
        b=kOxJ3txC4dZIUxKmWw50cjQYHMhbyrEdSl+RAbRNPfyPH54OsVY6d8JcJsrqIiH5pW
         Xxq54fx254/ElxbShAODhMZLxUE6/esMvLl3DY7hgjKBPKVS2v4IOW3Lenpor6FQIpne
         fiN3poTmjR5rh/roYvt0q3oLyVU1MTqPdPLoMhdlT8G6gJPVvk5m1kpoX2ZBzqnOLh2U
         eR/7XHlFbayrIA6voHqHcPzH/bxFImvw//biKMFa9OUNnxC0b2BHvMkZVvI15bOSE540
         +eA4ZgZuUcgItu/rUYEWZUlYkMXRUOKuWLx6sR3Trfx7s31jWv7rGoXWA63z7bYclGdT
         pLmg==
X-Received: by 10.68.244.6 with SMTP id xc6mr25572781pbc.94.1359662679049;
        Thu, 31 Jan 2013 12:04:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id a4sm6496861paw.21.2013.01.31.12.04.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 12:04:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vip6dgmx2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215160>

Junio C Hamano wrote:

>                                                      For those who
> want to _learn_ what possibilities are available to them (i.e. they
> are not going from `tracking` to what it means, but going in the
> opposite direction), it should be unmistakingly clear that
> `tracking` is not a part of the choices they should make.

Until pre-1.7.4 versions of git fall out of use, I don't agree that
the above is true. :(


>                                                            I do not
> think the following list created by a simple "revert" makes it clear.
>
>     * `nothing` - do not push anything.
>     * `matching` - push all branches having the same name in both ends.
>     * `upstream` - push the current branch to ...
>     * `simple` - like `upstream`, but refuses to ...
>     * `tracking` - deprecated synonym for `upstream`.
>     * `current` - push the current branch to a branch of the same name.

How about the following?

    * `nothing` - ...
    * `matching` - ...
    * `upstream` - ...
    * `simple` - ...
    * `current` - ...

  For compatibility with ancient config files, the following synonym
  is also supported.  Don't use it.

    * `tracking` - old name for `upstream`
