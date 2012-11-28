From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 28 Nov 2012 04:15:12 +0100
Message-ID: <CAMP44s3ZtCNsedJtsHDJx5d4Myjbbp+D6yT-rO-CmKOTtt91VQ@mail.gmail.com>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
	<7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
	<7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
	<CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
	<20121128025928.GA27772@sigill.intra.peff.net>
	<20121128031118.GB27772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:15:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdY7X-00067k-8i
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab2K1DPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:15:14 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59453 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2K1DPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:15:13 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11633020obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 19:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5627daAzvmqqF4u6TKqVChjVz1I1ZcPa8oewnQVRf+A=;
        b=VzJRJpd1CJxoRXth/Vm+huTEWjb8sTYU7VseZ83l67W3ovRKXBsspr9vSMO9NG4UtX
         IBAzt77eT7/lueVhC8n/4Rm1AhyYn3CVbNjafcGeP4m+I5ARJtiGgQ2pLkQ9fxFUNBts
         ifRkmClGJEQmINgF3D3ACpOtPDnqLBncrCQJEL6OxuU4s2DnwsAsWVItIQq71/rNe8rB
         fLvMqFBjzj4Bf+Y+VuKVsJnv8nDZ4PsCJWE4W/r15MjLL9MLvOISTf1TRonQr0FFdK+e
         D+r6BALw6EDVoL2Be1UL1SAQDn09poeRIb+RFxKxeO2clRs5SX7/s2c79+CgDlwx0oqQ
         PJow==
Received: by 10.60.172.229 with SMTP id bf5mr14546820oec.81.1354072512845;
 Tue, 27 Nov 2012 19:15:12 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 19:15:12 -0800 (PST)
In-Reply-To: <20121128031118.GB27772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210685>

On Wed, Nov 28, 2012 at 4:11 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 27, 2012 at 09:59:28PM -0500, Jeff King wrote:
>
>> > >  Renaming of remote-testgit feels to be a mistake.  It probably
>> > >  should keep its source in remote-testgit.bash and generate it,
>> >
>> > Why generate it? There's nothing to generate. python's source code
>> > needs regeneration, bash's code doesn't.
>>
>> We fix up the #!-lines on all of the existing shell scripts (as well as
>> python and perl). Wouldn't we want to do the same for people who have
>> bash in an alternate location?
>>
>> As the series is now, people with bash in their PATH, but not in
>> /bin/bash, will fail t5801 (the prereq to skip the test uses "type", but
>> git-remote-testgit hardcodes /bin/bash).
>
> We could improve the test in t5801, but it is nice to let people on such
> systems test it, as well. And the infrastructure might be useful if we
> ever acquire more bash scripts.
>
> There's a fair bit of boilerplate, but I think this squashable patch
> would do it:

Yeah, but I wonder what's the point of installing this script, it's
mostly for testing and reference, and to add a whole category for that
seems like overkill.

Cheers.

-- 
Felipe Contreras
