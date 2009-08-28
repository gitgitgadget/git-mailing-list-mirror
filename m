From: seanh <seanh.nospam@gmail.com>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 14:37:08 +0100
Message-ID: <20090828133708.GA11146@kisimul>
References: <4A979690.1050601@gnu.org> <20090827203402.GC7168@kisimul> <vpqk50pasek.fsf@bauges.imag.fr> <20090827203402.GC7168@kisimul> <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com> <20090827203402.GC7168@kisimul> <7v1vmxq6nw.fsf@alter.siamese.dyndns.org> <20090827203402.GC7168@kisimul> <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com> <20090827203402.GC7168@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 15:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh1gP-0000K2-9o
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 15:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbZH1Njv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 09:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbZH1Njv
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 09:39:51 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:53459 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbZH1Nju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 09:39:50 -0400
Received: by ey-out-2122.google.com with SMTP id 4so27209eyf.5
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=td+EcSsej8hZhDvHtiwuJ+1gzz7fA8YmfWfH2XoWXco=;
        b=UNrxpRCMKdbRdcFntuYVsiNZzLiIxdqsCF4e3P7s42+7PDd5yIiOcTJn9Lj+PMiYm2
         ex+ENLFnQUlNHYVYkosj5Tci6/nQz7RVWqFAK1V9xIM1d2dmWJTH8bL98nV1VfOz2+ON
         CTxVvfZ92J2Wvm7rcT7zyLnrSkLZLqQ4SuSeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w63PcFgIPsw9lNW9etUMpSa26gvjxOQ8nAd2y6PPUc22Z7G1aML4ymrkasfFcnCQFP
         GHjIm6gVkvhBWI26hjrS2ApSYzZodlhlcCk0aFQBEon63faz8urcpFel1z5GFo06t3WR
         eDS0aeWv/fUaHV+08avPiHij/bVXEma/Hcc90=
Received: by 10.216.20.67 with SMTP id o45mr256350weo.106.1251466791251;
        Fri, 28 Aug 2009 06:39:51 -0700 (PDT)
Received: from kisimul (kisimul.inf.ed.ac.uk [129.215.197.9])
        by mx.google.com with ESMTPS id 24sm563914eyx.2.2009.08.28.06.39.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 06:39:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpq7hwo8gxd.fsf@bauges.imag.fr> <4A979690.1050601@gnu.org> <vpqk50pasek.fsf@bauges.imag.fr> <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com> <7v1vmxq6nw.fsf@alter.siamese.dyndns.org> <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com> <20090827203402.GC7168@kisimul>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127296>

Wow, really helpful responses, thanks a lot.

I think having read all this that I'll do it manually. I'll still use 
git to track my latex source and will commit to it as often as I like 
and not worry about commit granularity. Whenever I've finished a 
significant chunk I'll add a PDF of it to a manually edited web page 
along with a description of what changed since the last time I added a 
PDF. I can use git log etc to help write the manual changelog. My 
supervisors can just look at this manually constructed page and if it 
gets too big I'll just archive the oldest PDFs. I can tag the git repo 
at the points where I add a PDF to the web page. I guess this is pretty 
close to what software projects do with version releases and their 
public website.

On Thu, Aug 27, 2009 at 01:41:04PM -0700, Sverre Rabbelier wrote:
> If they only care about the pdf anyway, why not have a separate branch
> to which you commit the pdf's instead?

Well I was thinking they'd look at the changelogs with the diffs showing 
exactly what changed in the latex source files, which should be pretty 
self-explanatory, but then when they wanted to read a whole chapter and 
add comments to it they'd want the PDF not the latex.

I don't really understand the script Junio posted (not literate in sh) 
but I think it might have something to do with copying changelogs over 
from the source repo to a PDFs repo.
 
On Fri, Aug 28, 2009 at 12:21:42AM +0200, demerphq wrote:
> As you can generate the PDF's from the latex then just hack gitweb to
> let them download it from there.

Unfortunately gitweb is written in Perl. But I know what you mean, it 
should in theory be possible for them to click on a 'Get PDF' link for a 
particular revision that causes the PDF to be built and returned to 
their browser.

In response to Matthieu and Paolo, I'm not sure I understand the git 
internals involved in the discussion around merge --squash, I had a 
feeling this would produce a 'merge' that git in some sense would 'not 
know about', since it sounds complex and I don't understand it I don't 
think I want to go there.

Thanks all
