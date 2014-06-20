From: Nico Williams <nico@cryptonector.com>
Subject: Re: Our merge bases sometimes suck
Date: Fri, 20 Jun 2014 16:17:37 -0500
Message-ID: <CAK3OfOjfyrsN47Ho0MFh4VZUg6YMjjwPOa16iuw3xtqyhz16hg@mail.gmail.com>
References: <539A25BF.4060501@alum.mit.edu>
	<xmqq8uovo9pa.fsf@gitster.dls.corp.google.com>
	<53A06264.9080205@alum.mit.edu>
	<xmqqtx7gdqbt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 23:17:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy6Br-0000q7-QV
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 23:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758109AbaFTVRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 17:17:40 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:59544 "EHLO
	homiemail-a96.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757903AbaFTVRj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jun 2014 17:17:39 -0400
Received: from homiemail-a96.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a96.g.dreamhost.com (Postfix) with ESMTP id 043343B805B
	for <git@vger.kernel.org>; Fri, 20 Jun 2014 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=5v9JfRcp5KwIZlKgWwxc
	tZ5d7g4=; b=ScGpyUiiNWJgHU3tqfNjTK/cSi1qkfyGHaB920CESg7QYt3b6gh5
	Pw++xEWtXLbfK4lFIkvFdn/wIWLzp1CPglDJs+VrAa6PFfwziY0aCge26PUa7uY7
	cYWpkVTyKfy3pjYLXHM8EnzuOzY9j3/tRCXKMTGeeHlCj5vjxdvUAxw=
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com [209.85.212.173])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a96.g.dreamhost.com (Postfix) with ESMTPSA id A92BC3B8059
	for <git@vger.kernel.org>; Fri, 20 Jun 2014 14:17:38 -0700 (PDT)
Received: by mail-wi0-f173.google.com with SMTP id cc10so1432023wib.6
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 14:17:37 -0700 (PDT)
X-Received: by 10.194.157.195 with SMTP id wo3mr6375677wjb.130.1403299057601;
 Fri, 20 Jun 2014 14:17:37 -0700 (PDT)
Received: by 10.216.29.200 with HTTP; Fri, 20 Jun 2014 14:17:37 -0700 (PDT)
In-Reply-To: <xmqqtx7gdqbt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252291>

On Fri, Jun 20, 2014 at 1:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> [...]
>
> Hmph, but that obviously will become very expensive to compute as
> project grows.

That's the main reason to like Fossil's approach (namely, the use of
SQL, specifically SQLite3): you can write declarative queries and let
the query planner optimize.

(That's also about the only thing I like about Fossil: the use of
SQL/SQLite3, and all that that implies.  Fossil is otherwise an
anti-git, and that makes it useless for me.)

Pardon the intrusion,

Nico
--
