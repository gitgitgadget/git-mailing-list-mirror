From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 28 Nov 2012 04:10:07 +0100
Message-ID: <CAMP44s3F4MPm-kLAW67rZG8oZg76CGS32h44LnK05UT11TOnSA@mail.gmail.com>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
	<7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
	<7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
	<CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
	<20121128025928.GA27772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdY2c-0001hl-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab2K1DKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:10:09 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53760 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab2K1DKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:10:08 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11629993obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 19:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zAkNnYl8uO7GROtl1DKSH7TrMNSOKg+FdgpqEBT/72A=;
        b=vurrmN0mVO20V45598Wags1Nwd5DsFireHj904NSjBPNAGCpqEVOyqty62cMIUOutE
         aXQ5dvMXsMVBWNscm3SxP7MnS0ayyO+yXlkWLHPLa3HFpwET4YpFOZTpZwSpsaB4yMQs
         wh/IVohXPrHWGiXofCgkPFkAlzm+1JaS/Wom0FolGjKNkYW0wnkypefPhbqDDX730CED
         UKlDuV7mo5Yngh56cobZW2ZqRaE7HDowI89AoLjXpy9AomV+n2ASmei8Z/6f5iucjq9T
         5x0XtSH3TWzirFaEUBXywv423K0XMSOq0k7YwG2rpyOsA9aGidZtivNyIQmNOYioA0EL
         jmcg==
Received: by 10.182.98.19 with SMTP id ee19mr1646799obb.90.1354072207505; Tue,
 27 Nov 2012 19:10:07 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 19:10:07 -0800 (PST)
In-Reply-To: <20121128025928.GA27772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210681>

On Wed, Nov 28, 2012 at 3:59 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 21, 2012 at 04:31:11AM +0100, Felipe Contreras wrote:
>
>> On Wed, Nov 21, 2012 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Here is a list of stalled topics I am having trouble deciding what
>> > to do (the default is to dismiss them around feature freeze).
>> >
>> > * fc/fast-export-fixes (2012-11-08) 14 commits
>> >
>> >  Renaming of remote-testgit feels to be a mistake.  It probably
>> >  should keep its source in remote-testgit.bash and generate it,
>>
>> Why generate it? There's nothing to generate. python's source code
>> needs regeneration, bash's code doesn't.
>
> We fix up the #!-lines on all of the existing shell scripts (as well as
> python and perl). Wouldn't we want to do the same for people who have
> bash in an alternate location?

'#!/usr/bin/env bash' should take care of people who have bash in an
alternate location, no?

-- 
Felipe Contreras
