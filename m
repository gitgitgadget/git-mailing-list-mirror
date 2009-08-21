From: David Aguilar <davvid@gmail.com>
Subject: Re: git diffall, open all diff files immediatly (eg tabbed
	window?in BC)
Date: Fri, 21 Aug 2009 16:45:13 -0700
Message-ID: <20090821234512.GA58248@gmail.com>
References: <loom.20090821T053954-649@post.gmane.org> <20090821054044.GB32879@gmail.com> <loom.20090821T074953-77@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seba Illingworth <seba.illingworth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 01:45:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MednW-0006Ed-Pa
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 01:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbZHUXpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 19:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbZHUXpT
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 19:45:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:11769 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723AbZHUXpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 19:45:18 -0400
Received: by rv-out-0506.google.com with SMTP id f6so367806rvb.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 16:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RR4FwXyXyUnLNGQ2fFBw5cKwFh36enVlNki2TkMy3/A=;
        b=qflqOjXPhpeb6tfznr1FjxIMF6eqL0yrVFXft5VRARq+JwZCtTYBwzhk481rKJ5dQV
         NqqAdF9NBzqbEBTMxPuvrh7RO4u9gOXZ6puUJAkgL8reJ/qVESLO3HHVkznU9GY8Wzjw
         /twXON4ItwLi2GL2SLUP0sV01xICBlZ7TaEn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HHhubxBi+4IBHbuVfraOToZYeLASjwfqW9ZOoLhgezAcmYzp6Txt0LqgRtgXODz8UP
         e54BVZsNXqI4C5RRYxcmnxVRf3rxIXjko+PdUQpIGF8OpJZHeNE7umXE6DdWlZDtVo07
         bvbqpcDUovo+8YcjLB3GAYaYShPsCcsDrdshk=
Received: by 10.140.134.17 with SMTP id h17mr920343rvd.282.1250898320117;
        Fri, 21 Aug 2009 16:45:20 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id k2sm2972206rvb.13.2009.08.21.16.45.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 16:45:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20090821T074953-77@post.gmane.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126773>

On Fri, Aug 21, 2009 at 05:54:48AM +0000, Seba Illingworth wrote:
> David Aguilar <davvid <at> gmail.com> writes:
> > To make it work irrespective of the configuration...
> 
> Hi David, great to get your comments, thanks for the pointers!

One last note (I promise ;)):

I would recommend against saying 'git difftool head' on your
blog beause that only works on OSX with its case-preserving yet
case-insensitive filesystem.  It might be worth mentioning that.

If you try 'git diff head' on a different filesystem (for
example, if you tried it on Linux) you'll find that it doesn't
work because the file is .git/HEAD; .git/head doesn't exist.

On OSX the filesystem tells git that .git/head exists even
though it's actually finding .git/HEAD.

-- 
		David
