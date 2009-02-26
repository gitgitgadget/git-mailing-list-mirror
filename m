From: Tim Visher <tim.visher@gmail.com>
Subject: Re: `./configure --XXdir=` ignored?
Date: Thu, 26 Feb 2009 14:04:58 -0500
Message-ID: <c115fd3c0902261104x7f867d07v5ba917adbc826435@mail.gmail.com>
References: <c115fd3c0902260648g3cc9bfeap58823e53a9dc72e6@mail.gmail.com>
	 <vpq4oyht85f.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 26 20:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LclZ1-0006Dl-9R
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 20:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbZBZTFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 14:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbZBZTFB
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 14:05:01 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:9642 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbZBZTFB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 14:05:01 -0500
Received: by an-out-0708.google.com with SMTP id c2so543923anc.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 11:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=urox5FKS/pGOimlsuaG+uygSGiINJNtsV8NIIhrkhaA=;
        b=eV13KnNtowCOHNvxq4yIARcgr3VEx07MI1hy7VibV/Scfbmb69IQ0L4EFnOppeE7DB
         QR0ids6EVehGm2ITMYsr47Rn9g87nFsf6wFsi8z06AY4ggR8qCNbbBj4LmIdHwXG268m
         kf9HhEA3q3LyFhybCUYM16VK6I/7jBHMKqOZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o8JqzwqNlXkI+FApWLC4/VePHKrWKsMAMq/II88EryVZDakWFFnw2YF42gk17MMXgE
         FyfXiNK42/jxfCzlWVsUAwve2uhgKhLtXzvryAP2IAJMXUKvQlGkw94EcT8iYV+jMGcG
         ZmZEC6ae7et7GujG4/gAzXo4SLY4scvc166SY=
Received: by 10.100.142.4 with SMTP id p4mr1912759and.23.1235675098828; Thu, 
	26 Feb 2009 11:04:58 -0800 (PST)
In-Reply-To: <vpq4oyht85f.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111587>

On Thu, Feb 26, 2009 at 12:33 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Tim Visher <tim.visher@gmail.com> writes:
> I attempted to do this through
>>
>>     make configure
>>     ./configure --XXdir=/full/path/to/dir
>
> Did you actually type --XXdir, or is this XX just a way to mean
> something else? I don't see --XXdir mentionned anywhere.

Yes, it was just a placeholder.  I actually typed things like
--htmldir, --mandir, --bindir, etc.

>
> I use "./configure --prefix=$HOME/some/dir" and it works fine (make
> install-html installs to $prefix/share/doc/).

This works for me as well.  However, I was hoping for finer tuned
control than that through configure.  IE ~/bin ~/man ~/info etc.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
