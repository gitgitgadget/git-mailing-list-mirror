From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 16:37:50 +0100
Message-ID: <81b0412b0701180737m49895d24td104b8dd2579de44@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
	 <45AF7FE8.5060003@op5.se>
	 <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
	 <Pine.LNX.4.63.0701181547440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701180653i7cc0c87md7a9c94a10fa3b24@mail.gmail.com>
	 <Pine.LNX.4.63.0701181615360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 16:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZL0-00053r-Aq
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbXARPhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbXARPhx
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:37:53 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:12817 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbXARPhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:37:52 -0500
Received: by wr-out-0506.google.com with SMTP id i22so191296wra
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 07:37:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QM1kNm/euEnd92a+zNqUnKDMBfNEkIXCPl7qwRqFsbeQnVxA/RPy190PcKlvp2z/THMb7g5Ti0fRyEa9Mi+hQygQvNcoTHtweKRD9V0bewmN3yYd8CIMkDLaSHnsKv3K1dRFdGH5aVisgEx/6coofG42XSufXNdEESzy+gULr2w=
Received: by 10.78.122.11 with SMTP id u11mr1006593huc.1169134670414;
        Thu, 18 Jan 2007 07:37:50 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 07:37:50 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701181615360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37110>

On 1/18/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > BTW, Junio, how about making the _default_ settable at compile time?
> > > > It'd be reasonable to allow local installations choose to default to what
> > > > they find the most paranoid?
> > >
> > > Better control that with templates.
> > >
> >
> > Do we have a template for config already? I thought they were only for
> > hooks...
>
> The template mechanism can handle _all_ files in GIT_DIR. Just drop a
> "config" into the templates directory, and you're settled.

I'm settled! From now on I will never have any objections regarding
any defaults as long as they have a config option :)
