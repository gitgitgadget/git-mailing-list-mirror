From: "Ricky Nite" <ricky.nite@gmail.com>
Subject: Re: submodule init problem
Date: Thu, 26 Jul 2007 07:43:42 +0800
Message-ID: <d4b731510707251643m4c1b416qabf8a01205581c9d@mail.gmail.com>
References: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	 <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
	 <b6ebd0a50707201023h12ed3c61v31ccb2b356c1ee42@mail.gmail.com>
	 <7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707201933360.14781@racer.site>
	 <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
	 <d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com>
	 <7vir89fe1l.fsf@assigned-by-dhcp.cox.net>
	 <20070725081508.GN1591MdfPADPa@greensroom.kotnet.org>
	 <7v8x94dt2b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Lars Hjemli" <hjemli@gmail.com>, git@vger.kernel.org,
	"Chris Larson" <clarson@kergoth.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDqWB-00065n-R5
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 01:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbXGYXno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 19:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbXGYXno
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 19:43:44 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:36747 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbXGYXnn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 19:43:43 -0400
Received: by py-out-1112.google.com with SMTP id d32so662759pye
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 16:43:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HSnFekkyjoFLCXEXmR+4tGyodUKTOkry95nJIuCoAGPfobaEFVONVyjOxyArNEzUm2VAYgLG1Dr/CjGt9j4zljmLVqq/GtujUzchmTZESrOFgpT+kmgVWPOIFwSWHKM8wNpXwI33AEXT60/cU+1LPjcsXN1o4Rhi0vWDWqHF7HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vk8xce6tlvBB6s8fwREQ/NJ7iFdOO5qva7JGlfifljy8aLwFjL5gVdiFp9MBX+uROB09N+ciQz/OqPdGdCiqzPlhQLwj8e4TouR9+cbn9p76ckWDCxxl+TWo3b36Q80yorzA9GGnV6xUkqBUypOAdyy1OR1D1Ry8ImhBKYoH0DA=
Received: by 10.65.72.7 with SMTP id z7mr2109486qbk.1185407022612;
        Wed, 25 Jul 2007 16:43:42 -0700 (PDT)
Received: by 10.65.96.19 with HTTP; Wed, 25 Jul 2007 16:43:42 -0700 (PDT)
In-Reply-To: <7v8x94dt2b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53740>

works for me :)

backgrounder:
I'm currently importing a large cvs repo (multiple projects, shared
modules, shared environment) into cvs-tracking git "superprojects".
Incremental import of the cvs modules using periodic invocations of
"git cvsimport" seems to be working, although there were some messages
(I suspect cvsps - will post later).  I was adding modules into the
superprojects when I hit this submodule init issue.

It will also be nice to have some kind of "superproject browser" in gitk..

On 7/26/07, Junio C Hamano <gitster@pobox.com> wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
>
> > On Tue, Jul 24, 2007 at 06:49:26PM -0700, Junio C Hamano wrote:
> >> Ok, this appears it most likely to be related to the fact that
> >> one is a prefix of the other in problematic case.
> >
> > Yes, this has been noted before and Chris Larson sent in a patch,
> > but he didn't follow up on it.
>
> Ok, I re-read the thread and came up with a different solution.
> How does this look?
>
