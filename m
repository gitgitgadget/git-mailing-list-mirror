From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Making submodules easier to work with
Date: Thu, 8 May 2008 09:13:33 +0800
Message-ID: <46dff0320805071813p34abde3aye7f954708e0bc6a7@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
	 <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
	 <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
	 <1209594215.25663.864.camel@work.sfbay.sun.com>
	 <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com>
	 <20080501183837.GA4772@pvv.org>
	 <32541b130805011255t4b37a73cx9d670b9250e787c6@mail.gmail.com>
	 <1210117622.25663.1110.camel@work.sfbay.sun.com>
	 <32541b130805070914n2d090971rf367c838dcfd9557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Roman Shaposhnik" <rvs@sun.com>,
	"Finn Arne Gangstad" <finnag@pvv.org>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 03:14:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtuiL-0003lz-Hr
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 03:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbYEHBNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 21:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbYEHBNh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 21:13:37 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:33889 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbYEHBNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 21:13:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so118447and.103
        for <git@vger.kernel.org>; Wed, 07 May 2008 18:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XLHXG0TZF9Hmd3Fe3caxrBcsC4iaGmeA0WFBA/Gjn5k=;
        b=SktLPQ9vTwUwybZUl3jTBjMo1DGCS5OTXWEYx3/S/4yb4lq1qsSiEUxDYH6Us/Sp2AKPn2fJZ/RvQY8hgx7HiTSMqYeoag8IoISl9Q4IIvVPfefLx1+fo+72uXGX/sQSe6H2x2MUMNthTPgemojgLASq2ckD235560jXae0HjHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KvqjWlRxRyCJzAMBP0gMINdiGkv7dGC3WHxvRvqK13WWxw2HJ8b9DGbRUpK9HsJHViL3OIpXzke/dTTb5g/zW+qev+GSz+DmtzyOXEcu7yB1X6rvF0ygXQwsQxgsOAlZ0OuZUBjDCwoLS/tt+FU6QzcGp6Mn5wcHukm6CdO859M=
Received: by 10.100.133.1 with SMTP id g1mr3742292and.88.1210209213373;
        Wed, 07 May 2008 18:13:33 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 7 May 2008 18:13:33 -0700 (PDT)
In-Reply-To: <32541b130805070914n2d090971rf367c838dcfd9557@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81495>

On Thu, May 8, 2008 at 12:14 AM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 5/6/08, Roman Shaposhnik <rvs@sun.com> wrote:
>  > May be my brain is saturated with "partial cloning" but somehow the
>  >  following looks like an interesting twist on a decentralized SCM:
>  >  imagine that the picture given by Finn Arne Gangstad weren't
>  >  static. IOW, os-lib wasn't really a separate component to begin
>  >  with but was first developed as part of a "crawler" and only
>  >  when the other team started to implement "indexer" there was
>  >  a need for os-lib to be shared between two independent projects.
>  >  Is there any nice way to express such a dynamic history sharing,
>  >  short of truly refactoring os-lib into a separate Git repository
>  >  and treating it either as a submodule or a subtree-merge?
>
>  Personally, I think it would be good enough to split out the os-lib
>  into its own repo using "git-filter-branch --subdirectory-filter", and
>  then link to it in newer versions of your crawler and indexer projects
>  using git-submodule.
>
>  There would be a bit of wastage here, since crawler still contains the
>  history of os-lib, which is the same (even the same tree and file
>  objects!) as the ones in os-lib.
>
>  I can think of two responses to that:
>
>  1) It's not very important, disk space is cheap and git repositories
>  are small, and it's much better to have an accurate history of the
>  crawler project than to overoptimize for space.
>
>  2) If the supermodule and submodule shared the same object repository
>  (eg. the submodule was checked out with
>  --alternate=<supermodule-gitdir>), there would be no need to waste
>  storage space.  If/when I get my act in gear and start submitting
>  git-submodule patches, supporting this behaviour is the direction I'll
>  probably start in.
>  (http://article.gmane.org/gmane.comp.version-control.git/78675)
>

It doesn't change the workflow whether using --alternative (although i
think it is a good idea).

The most interesting idea in that thread is the "When checking out a
submodule, give the submodule's current commit a useful branch name".
As a heavy submodule user, this will make my life much easier.


-- 
Ping Yin
