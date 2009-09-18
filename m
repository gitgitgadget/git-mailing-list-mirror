From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: git workflow for fully distributed mini-teams
Date: Fri, 18 Sep 2009 12:31:22 +0530
Message-ID: <f46c52560909180001r2a4e58aaxfdea136784431139@mail.gmail.com>
References: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>
	 <20090916164356.GB24893@vidovic>
	 <f46c52560909170003l61a2e1a3kf62c94ffd7ed9710@mail.gmail.com>
	 <4AB1E514.9030501@viscovery.net>
	 <f46c52560909170538q4d316d00jcccad8ec9f563574@mail.gmail.com>
	 <f46c52560909170652t54f68c31hfbb8ae6472190ac1@mail.gmail.com>
	 <4AB24C06.5030207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 18 09:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoXan-0000hr-OG
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 09:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbZIRHJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 03:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbZIRHJH
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 03:09:07 -0400
Received: from mail-pz0-f179.google.com ([209.85.222.179]:60189 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbZIRHJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 03:09:06 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2009 03:09:06 EDT
Received: by pzk9 with SMTP id 9so11683pzk.33
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 00:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JCTaQMyPy99OQoj36Je6ZCNeMjvC8I6AH4bY2HV38pY=;
        b=h/91dmOXdwAujii8ak8IazLlVy5K/A1E5uJcn3mhtfbs+A6p5wH2ZWPUnllfDyoiWE
         xaBh95p0UP6SgM2ZL+r2RIBg9x1pJ2knY/xjLebgBuBgW/lYbRRzSgfqYIximNLOOMWh
         ioYDuJlA21Y/7/TZkb+0gX4Y/GjNjFFgyOHWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ugcx0WGU1GbhecAdc7146Ef/DNV0IKa31RwVyQFzb+nuY/RC9/cWrKMFbOJPTmvgx5
         NWVMF45uTPZUmwQ87oJvGvgfiKHnR+aaLO+Wmbl7gfca/KB+wdqKg73xOenFHNMFmX+4
         isomT38cj4LOa0mcWwc1LmWXnu+mR96n+WscE=
Received: by 10.115.149.12 with SMTP id b12mr1841726wao.176.1253257282299; 
	Fri, 18 Sep 2009 00:01:22 -0700 (PDT)
In-Reply-To: <4AB24C06.5030207@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128789>

On Thu, Sep 17, 2009 at 8:17 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> [On this list, we reply to all, so that the Cc list remains]
>
> Rustom Mody schrieb:
>> I started looking at git bundle and find things like master\~10.
>> Whats the backslash doing?
>
> It's intended as markup for the pipeline that generates the documentation
> from git-bundle.txt. Either the markup is incorrect, or there is a bug in
> the pipeline, because I only see it in the generated HTML. Ignore it.

Seems to be there in my git-bundle.txt as well as git-bundle.html.
So its probably the markup not the pipeline.
