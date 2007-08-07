From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: Submodules
Date: Tue, 7 Aug 2007 16:10:38 -0700
Message-ID: <a1bbc6950708071610g4ea4d874t458cec14a444b519@mail.gmail.com>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
	 <Pine.LNX.4.64.0708072344450.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 01:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIYCL-0008B4-Gw
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 01:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbXHGXKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761786AbXHGXKk
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 19:10:40 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:32919 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759013AbXHGXKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 19:10:39 -0400
Received: by rv-out-0910.google.com with SMTP id l15so4223rvb
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 16:10:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=akK8yFXnxJ/HcRfWrAXvEp708B39BO29LxSth7lqhD+M3aG9u01WP6vP4K/TXkKk5bZWkRjVUs6H59wZykNwCkQ3xcjz73E072/NTIGDw6q1gyTTFzf3+5j3IajTlIYT8CEgDbmVAColuosPeFQkvYlDXHDjlcP9wdoakO43Et4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cwFZngIurxpEyf2M73En0kN6nEZ17r/HZO3SNwNQlUMo0s5snDxBg7dapQm3jIOGWBbK9adnekMcXG7vZc+efEt1k/cIElWAbcTUgtGn8ULo3synxQF3HDGsxodws4qTwFFdUXi+uDdCNTCDCwMbQmbLm2zL4roHKX3UEpaP5XU=
Received: by 10.140.139.3 with SMTP id m3mr2733779rvd.1186528238447;
        Tue, 07 Aug 2007 16:10:38 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Tue, 7 Aug 2007 16:10:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708072344450.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55285>

Yeah, I've already went thru these. But I want (much) more details.
I can ask a bunch of random questions on this list, like:

* Why after 'submodule update' it becomes detached, what if I want it
to stay on certain branch?
* How do I control which branches are fetched?
* What if I do 'commit -a' standing in /super, will /super/submodule
commit as well?
* What if I'm standing in /super/submodule and do 'commit -a'? Will
super notice it in any way?

But I was hoping that it's all summarized somewhere already.

- Dmitry
On 8/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 7 Aug 2007, Dmitry Kakurin wrote:
>
> > Where can I find more information about submodules?
> > I'm interested in both internal implementation details and how to use them.
>
> Most information is found in git-submodule.sh, although
> Documentation/git-submodule.txt has beginnings of a good documentation.
>
> The basic idea is this:
>
> A subdirectory contains a self-contained project.
>
> Once that project is at a stage you want to have in the superproject, you
> can commit that submodule state, much like a subdirectory.
>
> However, the history can progress in much coarser steps for the
> superproject.  IOW an ideal case for msysgit.git, where we want to have a
> stable version which can be checked out with GitMe.
>
> Also, find more about submodules here:
>
> http://git.or.cz/gitwiki/SubprojectSupport?highlight=%28submodule%29
>
> Ciao,
> Dscho
