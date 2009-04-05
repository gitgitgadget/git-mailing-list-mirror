From: David Aguilar <davvid@gmail.com>
Subject: Re: git-{diff,merge} refactor round 2
Date: Sat, 4 Apr 2009 20:34:44 -0700
Message-ID: <20090405033443.GA16219@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <200904050458.17708.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, charles@hashpling.org, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 05 05:36:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJ9s-0003Xv-74
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 05:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850AbZDEDe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 23:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbZDEDe7
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 23:34:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:51089 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbZDEDe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 23:34:58 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1728086rvb.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 20:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0M8O/7Lml9Pgtxhe59DNyzylfv3LchqoTjlyc2X0Upg=;
        b=AWK1eSLCdjYP0p4/qVITLUYrc/rrvzxyeOcC2+/6RrMhF/H9fu885s1ZMi3sLCWpI3
         y63mUrA5UmYqMS08FN9gkojstqIE5+aEzJXe2BVSvKvAVoYXkp0iAclMLNRM7PX1CEN0
         RltzbZD7FbU6U8HJv0vfYdSMFXW2RO6iZI/4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u3/rcBD0eMuF1OwzxnTKkmAj0p9Gkm6xWl9UBIjt1HSHKcQY0GoNpPgsoBdD0X5oiS
         ftBJy83r7wS9ErlfQaSQpIcvkAib7PnoEPRjPY834VeIUIiSuLOF4B64dfrd5AbKUiwi
         fdvKKq4Tx2QM2JJAmhAG6SPFpr+QpbMgU5P9I=
Received: by 10.114.255.1 with SMTP id c1mr1506536wai.4.1238902495555;
        Sat, 04 Apr 2009 20:34:55 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l37sm3875780waf.38.2009.04.04.20.34.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 20:34:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904050458.17708.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115627>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> David Aguilar, 01.04.2009:
> > Here's the 2nd round of refactoring.
> 
> I just noticed that mergetool.<mergetool>.path doesn't work anymore.
> git grep mergetool.*path only hits one line in git-difftool--helper.sh
> Neither does it seem to work with difftool, but I'm gonna go to bed now.
> 
> Markus
> 

Oops.  Well, I have one final patch that removes the last bit of
redundant code.  It also fixed this problem so I'll go ahead
and send it (it's based on top of da/difftool mentioned in
pu).

Since the test cases didn't catch that breakage I added a test
for it. 

Look for a patch called:

mergetool--lib: consolidate the last redundant bits in {diff,merge}tool


-- 

	David
