From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 08:22:11 -0400
Message-ID: <2c6b72b30909040522l4f27ed36u10f47517d42d57a3@mail.gmail.com>
References: <loom.20090904T064602-511@post.gmane.org> <554991.93608.qm@web27807.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:25:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjXr5-0004dh-7e
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbZIDMWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbZIDMW3
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:22:29 -0400
Received: from mail-iw0-f175.google.com ([209.85.223.175]:40765 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbZIDMW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 08:22:29 -0400
Received: by iwn5 with SMTP id 5so207241iwn.4
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=q++5yU2HTiNVn1LbFcVVZfDl3WsZvh2mqWJCPh4tHh4=;
        b=fmxbE9V/uHRdV7spDa1OkVcp+xANSpMc++x9NO7GCL8ZgkZG231RN/obFRrEw1qAM5
         PWXJdJyToJ4GCsxdXTDXlhmBkZebWMdp0DDfFcjkqtxVWoHq2i8fRu2jdIlvBlgxwA2N
         6wq4Oecm6LlbbV8xUwIzyaOJwZ0GVQtOkF3Us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Jvhdq+P9ab6jz+qajt8s727pHNGV98BG0rgx3buFygmUMzc4zvqSkdyJb9bHku6728
         iIX5AC1ZpoqpkD15ljqbsOZS5jzGFpmKSr1EV0conMaaBRGPQGh28Wzj/FZlhsuBQl9P
         zp6y3awy29E5HWMjB591PFMCAKdrCc7xDcB3U=
Received: by 10.231.67.212 with SMTP id s20mr9943060ibi.32.1252066951078; Fri, 
	04 Sep 2009 05:22:31 -0700 (PDT)
In-Reply-To: <554991.93608.qm@web27807.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127724>

On Fri, Sep 4, 2009 at 03:33, Mark Struberg<struberg@yahoo.de> wrote:
> .) we don't need a tag.sh any more if we work with maven. Maven now has the maven-scm-provider-gitexe activated by default (since early 2008), so
> mvn release:prepare
> mvn release:perform
> should work if we set the proper <scm> section. Any feedback or bugreporting on the maven-git integration is highly welcome btw ;)

If tag_jgit.sh goes away, it could be nice to add a document showing
how releasing/tagging it's done the maven way.

-- 
Jonas Fonseca
