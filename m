From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [FEATURE REQUEST] - extend git request-pull to send email
Date: Thu, 3 Feb 2011 18:30:57 -0500
Message-ID: <AANLkTikmOvCXqcCSvOgyxVoh8Gvk1KOhcLng68PvdVwy@mail.gmail.com>
References: <AANLkTi=kXJF_rYGMyh1gj49J7fh-ZxD7Bo8o_ELHb-2M@mail.gmail.com>
	<7vpqr8zpux.fsf@alter.siamese.dyndns.org>
	<7vlj1wzpiq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 00:31:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl8dr-0006qu-Rb
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 00:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab1BCXa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 18:30:59 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46981 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab1BCXa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 18:30:58 -0500
Received: by gwj20 with SMTP id 20so704235gwj.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 15:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SUWbcSyK0VqUmwJOpzmmNddByfGh4Q/MnoRTOhV69xE=;
        b=GtRY//4X3ZI+0X7zLkbx3ByaSo/N35VlSkrzxgiVU9qwq1AZ02gAhwgHl79KPPChhE
         Ue/L7eitAV5lPGgPgZFexF6uzJrFscdVTlBnaj3xNPH1RTWPuGPotLabEfDEWLZpvOSz
         oIfmZi+i7f9vcdmf7u3WE7OEY2swyiSX0NAZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=weiP1WFq1997C38X9Aj8Wfh5yOYjEdgPkFJ4WuX4O4/utC2cv1Tl3qJonpelH+J5z8
         GCDGxesOIo+vfpTKNv4/PDcA2Ydp60zPbYUq1X/4L1Eqvca+6m81N8uh69/WUHBQ/1C8
         /aNVdqefsl6Rbqd9c5Eo8GuvnFbIo6VhZH7wQ=
Received: by 10.150.58.2 with SMTP id g2mr280906yba.397.1296775857699; Thu, 03
 Feb 2011 15:30:57 -0800 (PST)
Received: by 10.146.168.5 with HTTP; Thu, 3 Feb 2011 15:30:57 -0800 (PST)
In-Reply-To: <7vlj1wzpiq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166009>

On Thu, Feb 3, 2011 at 6:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> What do you think?
>>
>> Horrible ;-).
>
> Just a quick note.
>
> Please take this with a huge grain of salt, considering that the comment
> is coming from somebody who thinks --compose and format-patch integration
> to git-send-email was also a bad idea.
>

;) Anyway thanks for prompt answer;))

Well, it is of course pretty cool that you can pipe the output to mail
but there are at least three problems that i currently see with this:

1. it is not cross-platform solution
2. By default subject gets empty;)
3. I probably would like the from address to be the one that I'm using
in git configuration...

Thanks,
Eugene
