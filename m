From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 12:54:31 +0200
Message-ID: <8c5c35580706120354w69bddb7o8edce484be714087@mail.gmail.com>
References: <20070611225918.GD4323@planck.djpig.de>
	 <11816319211097-git-send-email-hjemli@gmail.com>
	 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
	 <466E7A17.CEB0F196@eudaptics.com>
	 <8c5c35580706120352y24e53a10sf339147b22f1286e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 12:54:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy41H-00032e-5f
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 12:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXFLKyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 06:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbXFLKyd
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 06:54:33 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:45126 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXFLKyc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 06:54:32 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1602452nzf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 03:54:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tyPDvug52y+CAXDednH7hUwdiey0nf7xiPh1mf7A3y/W7RZLzN611FQ9ggpvVtveTx2OmU0HGjwSMB/f0b9SCSm2hqNvRUwMy4ak2nYZee0f687QxkQfLFekkFvHT2DtUqG861CfeUnRtclDthC7fs7dRK+y43A9FhAZzwoZQ0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I7Db+QtmIyJ7YQEtvrpkOSwi6ZeYy6DXJN0af4kaz02ccJyBYO8bftZ3q1tpCGTk4T1QwYTs2XNzZJve4T19hVgb8sFg7cYm/mb7/xXcp7fBm/5X26zfbf5n+JXxgD1xdM0wDd7EJYa9m/UufVY8XoQpZBITnSG+QdzL7VvGuq8=
Received: by 10.114.103.1 with SMTP id a1mr6546872wac.1181645671530;
        Tue, 12 Jun 2007 03:54:31 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 12 Jun 2007 03:54:31 -0700 (PDT)
In-Reply-To: <8c5c35580706120352y24e53a10sf339147b22f1286e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49946>

(readded the gitlist)

On 6/12/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Lars Hjemli wrote:
> > Multiple checkout paths for a single submodule will bring havoc on
> > this plan, so I need to ask: what is the use-case for multiple
> > checkout paths?
>
> A use-case is the admin directory in the KDE repository. It has:
>
> KDE (superproject)
>  +- kdelibs (subproject)
>  |   +- admin (subproject)
>  |   +- subdir1
>  |   +- ...
>  +- kdebase (subproject)
>  |   +- admin (subproject)
>  |   +- subdir2
>  |   +- ...
>  +- kdenetwork (subproject)
>  |   +- admin (subproject)
>  |   +- subdir3
>  |   +- ...
>  ...

But in this case, 'admin' isn't a submodule/subproject contained by
KDE, right? It's contained in three different submodules/subprojects:
kdelibs, kdebase and kdenetwork.

--
larsh
