From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v2] Allow git-shell to be used as a ssh forced-command
Date: Tue, 21 Apr 2009 15:16:25 +0400
Message-ID: <20090421111625.GJ25059@dpotapov.dyndns.org>
References: <20090418063100.GA18568@glandium.org> <1240292586-28192-1-git-send-email-mh@glandium.org> <7vbpqqa0gy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 13:18:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwDzl-0007Q9-AU
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 13:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbZDULQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 07:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbZDULQ6
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 07:16:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:40532 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbZDULQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 07:16:57 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2380713rvb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1LqjuLisBLS6WhVfW2ZPNE30+rrVBOqHht6U8/Z6xBs=;
        b=xhG94+dZbBfLFW2SiMFZkXd9t/I7nimyvnAC7F/sF8z4I/1r5ZztLMqoYdW7xKKjto
         TfNYtvpMaw1d6opVbC2ebVXBdQTPGsHxhiQVOWsxXYP6ekx/2n+lX1cbw9E+SjkbLMs3
         42apWQp7TEGIpNcmG/Uab8PsXpEU1nH856ku4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pS4DjXSWP4+W21w7LX8veVx7e9UmJO/B37eYaABV8qQTMkxrHaC9JHSO9dfYZC3DZ1
         iPHZdkQMcLR6T0HRc/DFWPQJ7cZaK2xVI7PmuJ5bDgOVv7rAWmTVn/fPTuKLKiQvTheb
         /3D6X9QxlGdumsdtuxeo/vv3zNjFDXuvY1uO0=
Received: by 10.114.200.2 with SMTP id x2mr3912118waf.83.1240312615167;
        Tue, 21 Apr 2009 04:16:55 -0700 (PDT)
Received: from localhost ([91.78.51.18])
        by mx.google.com with ESMTPS id y25sm596075pod.1.2009.04.21.04.16.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 04:16:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbpqqa0gy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117121>

On Tue, Apr 21, 2009 at 01:13:17AM -0700, Junio C Hamano wrote:
> 
> Is it a valid question to ask "what's wrong with gitosis"?

Git user needs /bin/sh as the login shell, and some sysadmins aren't
happy about adding any user with a real shell. OTOH, it seems Mike
is not concern about having a real shell for git user...

BTW, no so long ago, I posted a smiliar patch, which not only allowed
to use git-shell as a force-command (but in a more explicit way), it
also made possible to assotiate some name with every ssh key, so this
name could be used later in git hooks.

http://marc.info/?l=git&m=121483868801547&w=2

Dmitry
