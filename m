From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull opinion
Date: Mon, 5 Nov 2007 23:04:28 -0500
Message-ID: <3abd05a90711052004v3de6d448s2d1d9a53323060be@mail.gmail.com>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
	 <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 05:04:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpFgD-0006tu-8v
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 05:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998AbXKFEEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 23:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbXKFEEb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 23:04:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:39416 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802AbXKFEEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 23:04:30 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1572011nfb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 20:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hbN/GYVcrwopfcciZ3VcrsCvLxKdiGRiEuLwpvkW0IE=;
        b=KbUq7usRPxzxef8/gp6fV2a9cL+QBr6TMsT1huysFPi+P0xmqMVtTsvVCCDw/6zi40p9m9boE3iMGlfdqyrYkfQ2t7a5WttuURSTp0z9cNZjtcbbPswd68z/gIskGJPlk2jCJ9NkhHuzDnMRQP+2x1lb0XW5YEmK0LJpeqZbwuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bNEu4Hxc+/xXdyk9A2qQqTEV2+KNQeg0TG9FEtI/sbIlpB3cf2x1aaOJw9x9qddsle3dk60DmEliWfleF1c6nmEdr6psnHiDPkyLZ2g7h+HEihMi+vvjEejD2BLM2Spk+UnynJVNSyUjJ51D2ZNeLBo2KdoJjC2Y5tlcooBZUJo=
Received: by 10.78.107.8 with SMTP id f8mr4400221huc.1194321868512;
        Mon, 05 Nov 2007 20:04:28 -0800 (PST)
Received: by 10.78.185.1 with HTTP; Mon, 5 Nov 2007 20:04:28 -0800 (PST)
In-Reply-To: <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63621>

Hello Junio,

> You need to switch your mindset from centralized SVN workflow.

Yes, we understood that and we are trying hard :)

> The beauty of distributedness is that it redefines the meaning
> of "to commit".  In distributed systems, the act of committing
> is purely checkpointing and it is not associated with publishing
> the result to others as centralized systems force you to.
>

This is very nice actually and we absolutely understand what a
commit means in the git world. Having the commit as a step
before publishing is very helpful (although some  concepts such
as "staging for a commit" are still obscure as of now).

> Stop thinking like "I need to integrate the changes from
> upstream into my WIP to keep up to date."  You first finish what
> you are currently doing, at least to the point that it is
> stable, make a commit to mark that state, and then start
> thinking about what other people did.

One particular situation in which this might not apply is when
two people work very closely on the same feature (as mentioned
by Steve Grimm in this thread) and one needs the changes
made by the other. This often happens when starting a new project,
as it is our case now :)

Thank you,

- Aghiles.
