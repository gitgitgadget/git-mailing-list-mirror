From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Thu, 4 Mar 2010 01:46:18 -0600
Message-ID: <b4087cc51003032346o4e8f338ub703c460e33c3f1e@mail.gmail.com>
References: <4B67227A.7030908@web.de> <4B8B9BF1.10408@web.de> 
	<7v1vg4ufas.fsf@alter.siamese.dyndns.org> <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com> 
	<7vk4tvsu6x.fsf@alter.siamese.dyndns.org> <4B8C2F90.8080104@web.de> 
	<b4087cc51003011741w29023914wec78f9acd6efb516@mail.gmail.com> 
	<4B8CDBCA.4030101@web.de> <7vvdde62ai.fsf@alter.siamese.dyndns.org> 
	<4B8E8677.8060003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 04 08:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn5ld-0002Bz-JS
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 08:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab0CDHqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 02:46:40 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:53501 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab0CDHqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 02:46:39 -0500
Received: by ey-out-2122.google.com with SMTP id 25so382830eya.19
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 23:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=KTurdqzJXut5+fzq6f/FnFZUnCsNafl3zHUPDM5ZsgA=;
        b=ZZp/FAZtpLIBafT+Qd2+rKioWDy6x/305Respt2DV7S/K87vIJ7yC1olBedwa2QqPW
         hi3903kCnr29GbHzG5XzVwxKv104PBWL4xuinkLn+uYnVfkEo+NAd4JDacsD+/ZhmxOz
         5zdWeRN5D9QFfNWkUvaNpBdG/F64WTNMtE6e4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=x3ZdfYnySq4VRr6u/S1dwZwdfOXtYFBEQkgXOxHlyqWoSL41zGtuQtqqbFfoEwkbQH
         JRFI+NpQuUVuSNldKjCq/HI/KuS6P8dOJsfkQA8kPkFSmy2AJL1sUzpJOMB7yuHWU4cM
         rZY34M9XU6+ZyVZs5e+DmQ2N4SOnVqGMSlJFQ=
Received: by 10.213.104.80 with SMTP id n16mr3161408ebo.54.1267688798128; Wed, 
	03 Mar 2010 23:46:38 -0800 (PST)
In-Reply-To: <4B8E8677.8060003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141515>

On Wed, Mar 3, 2010 at 09:55, Markus Elfring <Markus.Elfring@web.de> wrote:
>> Traditionally the right way to do this has been to make a temporary commit
>> on the branch, i.e.
>
> I would like to avoid such commits for unfinished content updates. Should the
> storage operation be provided by the stash instead for intermediate work results?
> Will it happen to forget corresponding clean-up for "temporary" changes that
> might be committed too early just to get them stored?

Junio,

I'm not sure how often WIP commits become accidentally published or
left in the history, but perhaps it would be advantageous to provide a
means of specifying officially that a particular commit is in fact a
WIP commit such that no other commits can be made on top of this WIP
commit and it can't be merged with other branches or pushed or
whatever.
