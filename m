From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: libgit api & external integration
Date: Fri, 17 Jul 2009 19:10:35 -0700
Message-ID: <fabb9a1e0907171910t529f3d9oe4b6ce0ed55f4800@mail.gmail.com>
References: <b086760e0907111409w602f4338u868729dcfa188908@mail.gmail.com> 
	<b086760e0907111417o4b249676jc821e8733d340c9d@mail.gmail.com> 
	<20090716100334.GB6742@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, devzero2000 <pinto.elia@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 04:11:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRzOQ-0002gm-8A
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 04:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbZGRCK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 22:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbZGRCK5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 22:10:57 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:50914 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbZGRCK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 22:10:56 -0400
Received: by ewy26 with SMTP id 26so1262283ewy.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bcfRuv0gn+gKPUjDpjlpaym2pseoY7ZH4SVh4rjdYrc=;
        b=aZzeRe/8toNi+Bua43Ypj1OE6EBbLCtTng8APYjJ765LHfIpbT6zIywlALABby+IQ8
         Rf/Tz3hbDi2QW0woq9Vu4+g0N20dEJK4M1HeLc2mwe4mMgaVMHaLJBOlAe6EmDC88ivO
         4nzqAqY+m4Bjcw3DZBmYXwX6JWjYwqYHlVVcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uRY+y149NKTA8d4mHU02TCfvirDl8YPH/rXhccrFaJhWyCE4nHcTtss4Uq3hag0kO1
         g4uVsHnWGn4/gUUlQ0uavzZu4nTpz/coWrSEimLviilCrB/+adMEzRz2v/YStbvwKj6U
         bl4PoUpZi7ZGunEbFUToLvhgLDxXJRXP7Gm20=
Received: by 10.216.10.73 with SMTP id 51mr485329weu.167.1247883055112; Fri, 
	17 Jul 2009 19:10:55 -0700 (PDT)
In-Reply-To: <20090716100334.GB6742@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123503>

Heya,

On Thu, Jul 16, 2009 at 03:03, Jeff King<peff@peff.net> wrote:
> No, there is currently no linkable libgit. The official stable interface
> for interacting with git is the set of plumbing commands.

Since this might not be obvious, you can find which commands are
plumbing in 'man git' [0].

[0] http://www.kernel.org/pub/software/scm/git/docs/#_low_level_commands_plumbing

-- 
Cheers,

Sverre Rabbelier
