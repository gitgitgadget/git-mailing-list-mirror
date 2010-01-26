From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #08; Sun, 24)
Date: Tue, 26 Jan 2010 01:59:07 +0100
Message-ID: <201001260159.09286.jnareb@gmail.com>
References: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org> <201001260107.25796.jnareb@gmail.com> <4B5E357A.50607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 01:59:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZZm6-0002D4-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 01:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab0AZA7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 19:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761Ab0AZA7R
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 19:59:17 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:54444 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab0AZA7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 19:59:16 -0500
Received: by fxm20 with SMTP id 20so4232102fxm.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 16:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZZRMyKrfdI1uLxwGyRnQDzI5/SDNiK296Sow4qoUZw4=;
        b=bjG6ETi6xWhMYRiH6jzlHS/pAgghkYho9us0eCxzOzNCAPk1V24au8oFl9U3XTaOb2
         SWH7yBPPEPzBQ0djB/1cnusbzkS+/UbS4nEl9l//avqPDIL3mv8nE2R7yJ+cp2V2U6HH
         Ynl5KMuHl/Tg/1S40MT+TLUY7ePBl0jc1PU2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VeVy4zijg67lmVePKvAu4FNGazuhgvONFHvWnYrVMI7psO5QLLH5BSyVMftKHmJ3Jk
         StPAUvMk+Sw5a8Mo2pewpS9o+rQGfqtOf1cA35F5QWpoS9RD+NomR6LlCQ9J5z7IgkDI
         WM2iyh0Q0mlwn7SG9o3kSw8gOIVRvKSB3EAzc=
Received: by 10.103.122.22 with SMTP id z22mr3728506mum.68.1264467554822;
        Mon, 25 Jan 2010 16:59:14 -0800 (PST)
Received: from ?192.168.1.13? (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id j10sm1020030mue.30.2010.01.25.16.59.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 16:59:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B5E357A.50607@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138015>

On Mon, 25 Jan 2010 at 16:21:51 -0800 (PST), J.H. wrote:
> >
> > I am waiting for response from (I guess busy) J.H.; I can do the re-roll
> > if he is too busy to work on it.
> 
> I'm juggling about 4 things in the air right now, with gitweb being one 
> of them, and two of them involving external entities to kernel.org.  
> It's good news all told, just requires a fair amount of my time 
> (currently) and babysitting.  I've been digging through the patches 
> you've got right now.  I should really just pull them in from your git 
> tree again.

Note however that my series (gitweb/cache-kernel branch) is based on
gitweb-ml-v2, not on newer gitweb-ml-v5.

> After reading through some of the discussions today I've had some more 
> ideas on the caching stuff, they are written up on my whiteboard and I 
> might be able to get to shortly, but I've got a rather large wall 
> looming ahead of me that's going to chew up a *LOT* (read at least a 
> month, if not two) of my time, so I'm a bit under the gun to try and get 
> this as far as I can before I hit that wall or this is going to fall by 
> the wayside again till I've got time again.

I think the best way of utilizing your time would be for you to take
active part in discussion, especially in what git.kernel.org needs and why.

I can clean up the miscellaneous improvements parts myself, and re-roll
caching patches.

> > > For the main caching patch, it seems like good idea to take Jakub's
> > > split-up series instead, let's see what is J.H.'s opinion on the series?
> > >     
> >
> > Let me at least make them into proper patches, with commit messages and 
> > configureability at least of the original caching patch by J.H.
> >
> > Also the question whether to create 'print -> print $out' patch, or to
> > manipulate *STDOUT instead must be solved, I think, before applying
> > those patches... well, at least beyond 'pu'.
> >
> > I am waiting for promised J.H. comments, when he will have time for it...

-- 
Jakub Narebski
Poland
