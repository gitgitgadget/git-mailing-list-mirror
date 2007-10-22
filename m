From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Tue, 23 Oct 2007 01:27:07 +0200
Message-ID: <8fe92b430710221627p6d8a28a3oa0d6f747d99af0b6@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org>
	 <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site>
	 <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C586A.9030900@op5.se>
	 <1193064780.4522.142.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Federico Mena Quintero" <federico@novell.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 01:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6gM-0002ID-7t
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 01:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXJVX1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 19:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbXJVX1L
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 19:27:11 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:11753 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbXJVX1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 19:27:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1334824rvb
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+vuQi2w1MLOD/RLhFyhwnjo7un6ishfH6j09YnIqV9k=;
        b=iFl8HkLFl/mY4yIWyfq9oD6Xk9lZIYmTLPo6+tQnnRM96RbVFwAU1pfhWwlv1aNqfZRe8m4cv+n3bUe3mJTQi7nEXAB8FRODnmZ2y6NGXSOkmxwlBXNeDnWj/oTEHctmAoI/ujNfjrLxdAOoTQKsxqW+U5odtfiC6EMhP3TEPD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bZbn/sN/A16NU3tAnogb6Ngy3dFIG3sWE0/acKPLJOZ4YUluWZA8VOHoE6B+pLBBvADbAxzogy+g8On8oBD83A5ajP2jGc5sBcs/Vq6C0fAAyMbYTfp72VFAlIhBmCLvTCaAuaysHpIlxPDl75HCsGuha4efoLEh9qLWGFt85oI=
Received: by 10.114.169.2 with SMTP id r2mr1884212wae.1193095627250;
        Mon, 22 Oct 2007 16:27:07 -0700 (PDT)
Received: by 10.114.160.12 with HTTP; Mon, 22 Oct 2007 16:27:07 -0700 (PDT)
In-Reply-To: <1193064780.4522.142.camel@cacharro.xalalinux.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62056>

On 10/22/07, Federico Mena Quintero <federico@novell.com> wrote:
> On Mon, 2007-10-22 at 09:59 +0200, Andreas Ericsson wrote:
>
>> I doubt many people on this list regularly use git-blame but it's a
>> command that's definitely non-trivial to script out using only the
>> "proper" commands, and CVS/SVN users expect it to be there, so it's
>> probably worth listing anyhow.

> Personally I find git-blame *EXTREMELY* useful.  The workflow is:

> 5. "WTF?  Who wrote this crappy code?"
>
> 6. git blame culprit-file.c
>
> 7. "Oh, it was $person with $commit_id... what were they thinking at the
> time?"
>
> 8. git show $commit_id

You don't need blame for that (by the way, as git-blame is slow, you
can try -L option to limit range of lines; it is a pity that 'git gui
blame' does not support it yet). You can use 'pickaxe search', i.e.
"git log -S'<crappy code>'". Sometimes it is better than git-blame...

-- 
Jakub Narebski
