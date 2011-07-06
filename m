From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Wed, 6 Jul 2011 13:24:15 +0200
Message-ID: <CAGdFq_gUUEWOKkVKK2vbR73JAZOj-BZomx939CRpSs=eF0BXog@mail.gmail.com>
References: <1309884564.18513.12.camel@umgah> <4E137701.1020007@elegosoft.com>
 <20110705231604.GC12085@sigill.intra.peff.net> <20110705232200.GD12085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Alex Vandiver <alex@chmrr.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQE0-00012I-OY
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab1GFLY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 07:24:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49370 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab1GFLYz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 07:24:55 -0400
Received: by pvg12 with SMTP id 12so5945044pvg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8dXh5p4TAWotLvHlxyndpL7TAwrw1+FaexzvSPv9/FM=;
        b=XAcknKEOe3+AiUpPZI1gctwEZ2r3ms8gmLvh0oGEr8Jk7FBZGqK60OE5P/MUnQmHMW
         L+WhnoDUkO2Fa8WORaUw4h1N+dpF+6p3zvhINEVBNRAuBdgWFmqRbuw2ogsfJ0s+FFxp
         oM+83DoGQTBGpyTQYbzJf40z7xalj2PkOB3lw=
Received: by 10.68.7.6 with SMTP id f6mr6486202pba.234.1309951495049; Wed, 06
 Jul 2011 04:24:55 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Wed, 6 Jul 2011 04:24:15 -0700 (PDT)
In-Reply-To: <20110705232200.GD12085@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176691>

Heya,

On Wed, Jul 6, 2011 at 01:22, Jeff King <peff@peff.net> wrote:
> So I think I prefer giving some more specific advice. Even if we don't
> mention "#!" lines explicitly, saying "This exists, but exec didn't
> work" is probably more helpful than pretending it's not there. It gives
> clueful people an idea of where to start looking for the problem.

Seconded. We should at least give the user enough information to
figure out next steps. I like the advice from bad_interpreter_advice,
although it might be phrased more as a suggestion "Try looking at
..."?

-- 
Cheers,

Sverre Rabbelier
