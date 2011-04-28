From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 13:07:48 +1000
Message-ID: <BANLkTimyFmujc+Lsd7DMWfJgUzZME+Sveg@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
	<BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
	<4DB84D65.6070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 28 05:07:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFHa7-0004qf-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 05:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab1D1DHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 23:07:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40554 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1D1DHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 23:07:50 -0400
Received: by ewy4 with SMTP id 4so696301ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 20:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N7llXAxoRzakz00IHcOvN/EzJ8xOT38S6Q7vyAHAK0Y=;
        b=KGF4yJf1yGKYxCZu2OGFB89rqKPLKh3YRDkxDsaMUKrMKpQHkBbERjnfnKH0oges7Z
         B2hM7ARMy5pzDre5gtyRjHUVt+5xOcwCtlwJMuPtbvX84Z1OMdB9UIBLmlV7j6HgX5+m
         cKIk3o/ipWms8SolKhXG+JYDFlPg6ych0OExI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bT1a9ckWTkR+rgaqri31e8XOlnXH4cIXa3QiWhI227FMchiUtB9QLcv+Vymgp3x65N
         EK8bt0LKKvMZ6Na3hsbiPawjeuy89N3qyrJJ2s5pM9NZcLbXvNZA4f0ajSR1sPAZCx6M
         5yOrrzTkMDGy6VW3S+cL8nGdkLQR849Ki43Rg=
Received: by 10.14.10.130 with SMTP id 2mr1293411eev.181.1303960068856; Wed,
 27 Apr 2011 20:07:48 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 20:07:48 -0700 (PDT)
In-Reply-To: <4DB84D65.6070906@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172313>

On Thu, Apr 28, 2011 at 3:07 AM, A Large Angry SCM <gitzilla@gmail.com> wrote:
>
> For a git plugin ecosystem to work, a (relatively) stable API/ABI is
> necessary for the plugin authors to code to. Where is your proposal for
> that.
>

To answer your question, the intent is to provide plugins git's
command line interface.

As has already explained by Junio amongst others, git already provides
support for such extensions via its idiom of treating any executable
of the form git-{command} found in the PATH.

The intention of my proposal is simply to formalise the plugin
architecture and provide a degree of plugin management.

Of course, others might think there is a need for ABI plugins, and
they are free to propose such extensions, but that is not my intent.

jon.
