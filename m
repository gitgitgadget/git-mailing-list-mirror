From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Sun, 27 Sep 2009 21:31:50 +0200
Message-ID: <81b0412b0909271231u54fbe035n3ce2503237b5ebf3@mail.gmail.com>
References: <81b0412b0909271144o26743e05uac3132cdc5b530b@mail.gmail.com>
	 <585748.13758.qm@web27802.mail.ukl.yahoo.com>
	 <h9odqq$ig9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net
X-From: git-owner@vger.kernel.org Sun Sep 27 21:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrzXw-0006I9-Oo
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbZI0Tbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 15:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbZI0Tbt
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 15:31:49 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:50642 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZI0Tbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 15:31:48 -0400
Received: by bwz6 with SMTP id 6so885422bwz.37
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zNHNKKSfijbh9T+52JfSrmvRIuTIfoW4/I41w7PPYaw=;
        b=pgEt7IxSMgiHRQrtxNFqpfB4ah6STMK3fMIHtVPgBU5zwcRMWcgH7bnClZBNcqlZIe
         XCRcmZ/Bx4ezi15IJPTjif35q5VpFW2hZeOuQcEPGc4/EjelDFC+FNpZre4bwJYBOItT
         Rzv+QBxj6k6E5munoq/1NS1XGDE/3Rrw8+KbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fOsbmTudiF84sfi9qoAzTPZdhCdH5JMa7xoAqYZMMWmlmRlqv7WG8rriLsLUo8tkV8
         Zb4Emf71gQUKSNF4Y2cFSVH1LLhZg1XOGKca/hoXhWUOG8ETy1WxYb/818TnT38BRbB3
         Qwt61uuBeVrCz6Ac5noMDdANJVqaYct1C+ELo=
Received: by 10.204.8.155 with SMTP id h27mr2347459bkh.55.1254079910873; Sun, 
	27 Sep 2009 12:31:50 -0700 (PDT)
In-Reply-To: <h9odqq$ig9$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129217>

On Sun, Sep 27, 2009 at 21:18, Anteru <newsgroups@catchall.shelter13.net> wrote:
> Don't get me wrong with Git+msysgit on Windows, the point is simply if
> we switch to git, can we expect that Windows will be supported for the
> foreseeable future or is it possible that git may simply drop Windows
> support completely? ...

Despite what I said, this is very unlikely (sadly). There are active developers
whose professional life happens in Windows. Besides, the project is open-
source and no one can stop you from taking over the maintainership of a port.

> As I said, I'm happy with using msysgit, but I cannot find any roadmap

There isn't any. Roadmaps are for projects with a guaranteed end of life :-p

> etc. which helps me to determine how git and Windows is going to
> continue (for instance, I can find some complaints that git's
> performance is bad on Windows due to cygwin's fork()/exec(), is this
> likely to get ever "fixed"?

Not likely. OTOH, msysGIT does not have that part of performance problem.
