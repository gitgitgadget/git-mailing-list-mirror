From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: git describe is failing
Date: Thu, 22 Oct 2009 16:59:30 +0200
Message-ID: <237967ef0910220759r509775e1oc2e20af90800198c@mail.gmail.com>
References: <76c5b8580910220747w709d2b41s4f7b121e421e843c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 17:00:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0z8q-0006qm-Tp
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 16:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915AbZJVO72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 10:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755670AbZJVO71
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 10:59:27 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55924 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbZJVO71 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 10:59:27 -0400
Received: by ewy3 with SMTP id 3so672350ewy.17
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=RgQH5cImt+QYtHQvAAMp99sbePiFsBlIKLXM7rKcqjI=;
        b=WLefycC5nNfI2pA6FaXt724tgvNNxs/jWRj5sZw35jxWwU8JerTiHqaBa9vaUDApGO
         gRAG09Mx7GUrAVezy+70ctvdhzLRE67mylXb88dIy4ti3EIPMhDMYHG0wv3qHQPoGGix
         ng+DhwAZ+QFmdvJdphixAbNUbAzAS6Nkvuj08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=N/bWL0tlLCBdDFgfowziukIpP+zAABWcrc4m0QRvHjR8CacgNDg2qoxMwVw9rrSXap
         ZiO6Oq2py5lyQlrDUag4mEpTjhYoOensn1MeDA1a2YdU1k3dnaZNbIqW9uaSwjCG83RJ
         UBIjNcIhkWLuROpNi60CJjPdN7f2L3WGHo6c8=
Received: by 10.211.132.28 with SMTP id j28mr10402003ebn.95.1256223570798; 
	Thu, 22 Oct 2009 07:59:30 -0700 (PDT)
In-Reply-To: <76c5b8580910220747w709d2b41s4f7b121e421e843c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131023>

2009/10/22 Eugene Sajine <euguess@gmail.com>:
> Hi,
>
> I have a test repo which I'm playing with. It has about 15 commits and
> one branch only (master) and couple of tags. Somehow it got to a state
> when
>
> $ git describe
>
> gives:
>
> fatal: cannot describe 'SHA-1'
>
> The command is working ok with my other repo. It doesn't seem that the
> test repo is corrupted. I can commit, push and pull, see the history
> with gitk... How can I check or repair it?
>
> Thanks,
> Eugene

Your tags are probably not annotated (lightweight tags), use git
describe --tags.

-- 
Mikael Magnusson
