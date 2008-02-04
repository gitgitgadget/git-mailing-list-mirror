From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Tue, 5 Feb 2008 01:33:50 +0300
Message-ID: <20080204223350.GA30368@dpotapov.dyndns.org>
References: <3asc6spe.fsf@blue.sea.net> <7v7iho6p2m.fsf@gitster.siamese.dyndns.org> <20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net> <20080203193024.GV29522@dpotapov.dyndns.org> <bq6x38lc.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9tU-0006fw-FG
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbYBDWd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbYBDWd5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:33:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:59032 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247AbYBDWd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:33:56 -0500
Received: by nf-out-0910.google.com with SMTP id g13so420004nfb.21
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=60SNQV9IURv7a5bu67RBVCRLrzDu9gGiVV6iwpD8Z6Q=;
        b=WOgja3YBQOn5o9hLmDwx5UVMrTJGZ73R70mTQJT9ax3g+WAhY2scnsiQuWiYhK1UgqukkMbixq0aMIMqCj1o+eW9e9GaJ+8YnQloed1R59N48/aq9tdrD7EKz7avm/Mzx2lptk0dXGdkTwlOGiHQaULWXNakTODWCU7SHrWKEEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RuZjJONeIBRm6vZ5j9FSVieA2fEWn9R1BW6tnatgdrdnsJIX+NwcDH5lB5DxsioJLQ7xBGVr9oPHwZpC3/dnkSdAONlVpMvvN3y1vKK3HEhkn5Ca4ll/nw4yXqn05tpZHhYNqh4+sY4yc9ZkLRJ4+yQz0Gn681v01N2rgrl3Uw0=
Received: by 10.78.83.15 with SMTP id g15mr13283293hub.6.1202164434383;
        Mon, 04 Feb 2008 14:33:54 -0800 (PST)
Received: from localhost ( [85.141.188.113])
        by mx.google.com with ESMTPS id y2sm1633020mug.9.2008.02.04.14.33.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Feb 2008 14:33:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bq6x38lc.fsf@blue.sea.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72584>

On Mon, Feb 04, 2008 at 01:48:15AM +0200, Jari Aalto wrote:
> * Sun 2008-02-03 Dmitry Potapov <dpotapov@gmail.com>
> * Message-Id: 20080203193024.GV29522@dpotapov.dyndns.org
> > ^-syntax is very natural to specify the _previous_ commit. Have you
> > notice we usually say "previous", not "one commit before"?
> 
> Only if you're grown with git.

Hmm... I always thought that the word "previous" existed well before Git...

> Everywhere else the concept of HEAD or
> TIP is more natural,

How so?

> thus progression:
> 
>     HEAD, HEAD~1, HEAD~2

Non sequitur.



Dmitry
