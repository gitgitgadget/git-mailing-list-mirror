From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git diff with add/modified codes
Date: Sat, 28 Jul 2007 14:07:29 -0400
Message-ID: <9e4733910707281107w6aff86f5sf746ca3f2c74d098@mail.gmail.com>
References: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com>
	 <7vir85whxy.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910707271717q5ea33b55r227d8dbb1023de47@mail.gmail.com>
	 <20070728043901.GB11916@coredump.intra.peff.net>
	 <f8fn72$l30$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 20:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEqhS-0005rS-Pq
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 20:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbXG1SHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 14:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbXG1SHc
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 14:07:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:63535 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbXG1SHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 14:07:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1280784wah
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 11:07:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jEMj5sRtkWk1wYpwgXciwg/SLvUKgpzG0zroaYLJTO+egV0wcTo6iGj9qlg4PLJFMqMgghZGxU+zgLQojhcCfkbrF3L/EbLW2uEB/K896Zp908NzGbxs22yRkV4kPFN2C69p06IlN050+udabv42IH7IQ0pjy8epmq4k9uQ/h0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=efBXMoCohIIBoE4PRefs5ajXiNxcCM30DFVRT7I+fo2jTb9DmQTRdwsYO4zIYmkDsVqH3vZm+T0GM/Z6+VIPsw1nXhEVjNDHSKB6UEnm1CFAObMpBuCf4VqY7Zwu7Tc6W1FQBP0uVvgLOxA1Jnd28XCXNkOpU3VHmeATCmcoMW8=
Received: by 10.114.177.1 with SMTP id z1mr4078689wae.1185646049659;
        Sat, 28 Jul 2007 11:07:29 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sat, 28 Jul 2007 11:07:29 -0700 (PDT)
In-Reply-To: <f8fn72$l30$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54046>

On 7/28/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Jeff King wrote:
>
> > On Fri, Jul 27, 2007 at 08:17:54PM -0400, Jon Smirl wrote:
> >
> >> That's not what I want. I'm looking a report that indicates new files
> >> vs modified ones in a single list. These old patches I am working with
> >> often create 100 files and modify another 200.
> >>
> >> Adding a code like (Added (A), Copied (C), Deleted (D), Modified (M),
> >> Renamed (R))  to --stat would be perfect.
> >
> > How about --name-status?
>
> Or -r --name-status?

-r is not in the git diff doc but it is used in the examples.
http://www.kernel.org/pub/software/scm/git/docs/git-diff.html

-- 
Jon Smirl
jonsmirl@gmail.com
