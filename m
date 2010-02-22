From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: working out where git-rebase is up to?
Date: Mon, 22 Feb 2010 21:47:04 +1100
Message-ID: <2cfc40321002220247q1b73ac32v6ff39035a61a6a1@mail.gmail.com>
References: <2cfc40321002220209pe1942ecucb3716f60bf05d32@mail.gmail.com>
	 <201002221126.47372.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:50:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVoq-00036D-GI
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab0BVKrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 05:47:11 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42621 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab0BVKrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 05:47:09 -0500
Received: by pwj8 with SMTP id 8so2559401pwj.19
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 02:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FmUM716n6V17MfBeMzQMmNvd1P/rKxECwsr4oVkbIDk=;
        b=OoA2voMffWT5sOplK66OgValxRa62RY/jUx6eGpK6QtKq3b97wyEq+CyTz90D/OrO/
         N1pq02XwTaXNsT7Uj1f+oc4liDuwXhU5zL3W/u5rS51C+sdl+IZUMcgC59S3tWs+gQCg
         aoDpB2cAs97CAnYFZ0t+oUDHA1j9EoJr8JYec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F4qfQekXbp6/jVJdyY9ji8No4oWsluFDAx620gmUVT0uO+evpD4m481L+RzCX2b/5r
         XDT7pLERhd1g7ORBMKpyjDrINQDTZ9r8h1/TnVd8fxf/foH/5oVSkyaNjVYQkANSy4RX
         pOwIU7smPZLQFQNJqYl1rmFc/Qa5k/sxB5m5c=
Received: by 10.114.249.9 with SMTP id w9mr309108wah.199.1266835624252; Mon, 
	22 Feb 2010 02:47:04 -0800 (PST)
In-Reply-To: <201002221126.47372.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140668>

Once I am done with my compensating rebase, rebase won't have to stop :=
-)

jon.

On Mon, Feb 22, 2010 at 9:26 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> On Monday 22 February 2010 11:09:18 Jon Seymour wrote:
>> Hi,
>>
>> For my funky "compensating rebases" I need to know where an automate=
d
>> rebase has stopped. In particular, I need to know the sha1 of the
>> commit that caused the rebase to stop.
>>
>> No doubt rebase is tracking this info, but is there a supported way =
to
>> discover it?
>
> It's in .git/rebase-merge/done (and .git/rebase-merge/git-rebase-todo
> for the remaining TODO file). =A0Maybe we should add a 'git rebase
> --whydiditstop' command ;-)
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>
