From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 1 Jun 2007 17:56:34 +0200
Message-ID: <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
References: <1180385483418-git-send-email-hjemli@gmail.com>
	 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
	 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
	 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri Jun 01 17:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu9UZ-0000Vu-Hx
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 17:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbXFAP4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbXFAP4g
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 11:56:36 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:14332 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbXFAP4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 11:56:35 -0400
Received: by nz-out-0506.google.com with SMTP id n1so565955nzf
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 08:56:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P93oCJHWkDaiBaHVI4fzYJoHRtGClrjgfszXSVgJ1RQefJMgRnOuqAJMQeT4+zCk82ddYvnOlsxsE3JHM4N0AE2vcDFz8W2kQi/zooRHMAU/ZObY1uKLWwdLGo/XePQ9zlGcAAHAep6iv1ry9PFa2Ow/WSNESu4M1Qt3E7BW94k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MrMOJU6F3v7NdVn+1O2MdTggkX4NawIBIXCRWsHODYdBsftp953+TtQqvyh4ZVsn3IvcSXOul1KLPwfctU2UyrhCW6WUvxOoZIP6q/qaNsatvoYy001ndRSGBNJIeyDWemHvbiBnd/H7e7K351eS9P8zXfznGdAd/tHL3m10QEs=
Received: by 10.114.126.1 with SMTP id y1mr1964320wac.1180713394057;
        Fri, 01 Jun 2007 08:56:34 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 1 Jun 2007 08:56:34 -0700 (PDT)
In-Reply-To: <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48869>

On 6/1/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Fri, Jun 01, 2007 at 04:45:06PM +0200, Lars Hjemli wrote:
> > On 6/1/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> > >On Fri, Jun 01, 2007 at 11:25:42AM +0200, Lars Hjemli wrote:
> > >> [path '$path']
> > >>  submodule=modulename
> > >>  url=/some/url
> > >
> > >Wouldn't it make more sense to have
> > >
> > >[path '$path']
> > >        submodule=modulename
> > >
> > >and
> > >
> > >[submodule '$modulename']
> > >        url=/some/url
> > >
> > >in case the same module appears in more than one path?
> >
> > Yes, that would be a properly normalized model.
> >
> > Hmm.... Maybe we could allow both variations, with your suggestion
> > overriding mine if both are present? (I think there would be many
> > cases where the extra level of [submodule...] wouldn't be needed.
>
> Hmm.... I was thinking that the extra "path" level could be optional,
> i.e., if there is no path.$path.submodule, then the name of the
> submodule would simply be $path.

Yeah, that should also work out. Time for a quick poll?

-- 
larsh
