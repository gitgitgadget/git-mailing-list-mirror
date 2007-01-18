From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 14:12:15 -0600
Message-ID: <625fc13d0701181212r67a9f132k7d9bed8e9fc51d29@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
	 <45AF7FE8.5060003@op5.se>
	 <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
	 <Pine.LNX.4.63.0701181547440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701180653i7cc0c87md7a9c94a10fa3b24@mail.gmail.com>
	 <Pine.LNX.4.63.0701181615360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701180737m49895d24td104b8dd2579de44@mail.gmail.com>
	 <625fc13d0701180742t703f4f0ei8847c32fe4e0dcfd@mail.gmail.com>
	 <Pine.LNX.4.63.0701182101230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 21:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7dcl-0001Zo-7w
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 21:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXARUMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 15:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbXARUMV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 15:12:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:36092 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587AbXARUMR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 15:12:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so273219uga
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 12:12:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WbyRastzVfK+AVB67bpnegcVBdu14n/KvBTZymsy/mXMlCGt/YiNx8/rwLJu4sgIn8kQ598HDD3NuUK7/sQqYcbZHIyfFrGB0dX8G53Qx27dCD5U2X2iG5838sCaMgp3tm7aR88NbuDqstV4XULrhe2TvznMqXCdMNBKpxKuVHk=
Received: by 10.82.184.2 with SMTP id h2mr339027buf.1169151135451;
        Thu, 18 Jan 2007 12:12:15 -0800 (PST)
Received: by 10.82.107.1 with HTTP; Thu, 18 Jan 2007 12:12:15 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701182101230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37136>

On 1/18/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 18 Jan 2007, Josh Boyer wrote:
>
> > On 1/18/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > > The template mechanism can handle _all_ files in GIT_DIR. Just drop a
> > > > "config" into the templates directory, and you're settled.
> > >
> > > I'm settled! From now on I will never have any objections regarding
> > > any defaults as long as they have a config option :)
> >
> > Whew.  Cool :)
> >
> > Junio, will this go into git at some point soon-ish?  I'm looking
> > forward to it...
>
> You mean the templates mechanism? Has been in git since

No, I mean a switch to using ".patch" as the default and the option to
specify your own suffix.  The actual reason this thread was started :)

josh
