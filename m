From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Thu, 26 Nov 2009 10:56:55 -0700
Message-ID: <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
	 <20091125203922.GA18487@coredump.intra.peff.net>
	 <7viqcytjic.fsf@alter.siamese.dyndns.org>
	 <20091125210034.GC18487@coredump.intra.peff.net>
	 <7vmy2as319.fsf@alter.siamese.dyndns.org>
	 <20091125214949.GA31473@coredump.intra.peff.net>
	 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
	 <20091125222037.GA2861@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 18:57:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDiaU-0000uC-2P
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 18:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbZKZR4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbZKZR4u
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 12:56:50 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55645 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZKZR4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 12:56:49 -0500
Received: by iwn1 with SMTP id 1so565972iwn.33
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 09:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=7OcIS5E8MrYNocPw4LWK5aTmVF0ZQdgCcaYDpQyPqGE=;
        b=bCVlhW+sJxqQojbzIGoP2POZmLaaN7GWhRD9g82dlJUzySYivHoQTngkCOcBHXUK0c
         Ox2XudEV6588fndT0fx8Dl0NlpYe2IAaObToZ+mbMlkrz4AwTb76Cd5GcChRh+k3tYju
         t9JHQG0JoLP/RAIt8IJaM/gOB/fD1UaSgX9Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Zvmq4uTebGG9lOAWUNDvTxxKNpG/1DR404WZTY6fU4enHIl6NDfN2o3dUKj7fW5vNn
         Mp9umthqHSpic9AtYUkZhyDKZetI0/EYBxvVvYIFN2P0qn12pf9VAG3gGblHhpDkwi6z
         IaaNF6KUybRS+sE20YdQ+W3AHQtIyfc3qz4BI=
Received: by 10.231.48.210 with SMTP id s18mr112316ibf.3.1259258215509; Thu, 
	26 Nov 2009 09:56:55 -0800 (PST)
In-Reply-To: <20091125222037.GA2861@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133816>

On Wed, Nov 25, 2009 at 3:20 PM, Jeff King <peff@peff.net> wrote:
> Sure, there are all those downsides. But what is the other option?
> Making me use the command line option (or pathspec magic) every single
> time I invoke git grep?

Yes, but only when you want non-default behavior, not every single time.

> That is a huge downside to me.

Is it *really*?  Does it also bother you that you have to tell standalone
unix commands like diff and grep what you want them to diff or grep every
single time you invoke them?

> I started to try to write an argument against this, but I really don't
> know how to. You don't think this particular option gets over the bar.
> Probably because it is not something that has been annoying you
> personally. But is _is_ something that has been annoying me. Now we are
> both making claims from our gut. How do we proceed with a rational
> analysis?

I really think that this config option wouldn't even help you, because
you'll have to remember what that option is set to in each working repo,
and type the right command based on the setting.  That seems worse than
having to use the same options over and over again, which you probably use
the shell's history for anyways and don't actually type the same stuff over
and over.  Oh and you also have to remember to set the option in each new
repo you create.

If you can get the behavior you want using an alias or a script, then I
suggest you do that.  I don't think this config option should be considered
unless *many* people want it, and so far I count only 1.

James
