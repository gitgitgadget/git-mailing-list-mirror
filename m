From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Redhat stateless Linux and git
Date: Sun, 11 Jun 2006 11:07:57 -0400
Message-ID: <9e4733910606110807m41fe82er9c4876a88336209c@mail.gmail.com>
References: <9e4733910606091559m6a88e864m16f9d75a507ee684@mail.gmail.com>
	 <D5AC73C4-5A2F-482E-9B45-71A72C62D670@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, stateless-list@redhat.com
X-From: git-owner@vger.kernel.org Sun Jun 11 17:08:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpRXq-0004Ht-Dq
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 17:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWFKPH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWFKPH7
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 11:07:59 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:4088 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751617AbWFKPH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 11:07:58 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1451452nze
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 08:07:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rvDNjam9NVGusL7eY4doSG/8LQTBUv2YbonGDvd2i8uf/aqK5NOvDXUJj5JyIpCIYUsHhox7ATA88/Zhka+0wuONTSTI/0vxb1U/zyAXwlseAzE7KCLGl5ODKFn3CijN+IpK8seeEbnysSt6haFQkDYnVY83mc8CFTFV4/HuB5U=
Received: by 10.37.15.13 with SMTP id s13mr7191720nzi;
        Sun, 11 Jun 2006 08:07:57 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Sun, 11 Jun 2006 08:07:57 -0700 (PDT)
To: "Geert Bosch" <bosch@adacore.com>
In-Reply-To: <D5AC73C4-5A2F-482E-9B45-71A72C62D670@adacore.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21656>

On 6/11/06, Geert Bosch <bosch@adacore.com> wrote:
>
> On Jun 9, 2006, at 18:59, Jon Smirl wrote:
> > Redhat is looking for a scheme to sync the disk system of their
> > stateless Linux client. They were using rsync and now they are looking
> > at doing it with LVM.
> >
> > What about using git?
>
> The data model is fine in principle, but git as-is isn't suitable
> for general backup/sync-like schemes. Large (multi-GB) files
> are not really supported yet. Still, I think the underlying
> data model, with some modifications to split large files on
> content-determined boundaries, would be really great for
> distributed filesystems.
>
> Many people using laptops these days connect to different
> filesystems on their office networks, home networks,
> digital cameras and even their PDA, cellphone and MP3-player.
> What is commonly described as "synching", really is just a
> merge between different branches. All arguments in favor
> of using a distributed SCM hold here too.
>
> Right now I'm using a hodge-podge of different manual and
> semi-automated methods to keep my local filesystem with 1.5M
> files totalling 90GB somewhat in synch with various
> homedirectories on different remote systems and backup disks.
> IMO, git is tantalizing close to be able to handle this, just
> needs to get a bit more scalable. Probably you'd want to use
> a different user interface as well, but all the underlying
> data structures and merge strategies may be equally valid.

That's why I though stateless Linux was a good place to start. The
client is read only so it is the simplest case to start with. I would
much prefer a file orientated system for syncing over a block oriented
one, with the block one there is no easy way to tell what is being
copied to your machine.

I added the stateless list to the cc, maybe they'll join in.

-- 
Jon Smirl
jonsmirl@gmail.com
