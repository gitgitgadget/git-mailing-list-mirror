From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Tue, 6 Dec 2005 08:35:19 +0100
Message-ID: <81b0412b0512052335i43da5d34xf2ef78e66e40c6ee@mail.gmail.com>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	 <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	 <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	 <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512052135260.5944@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vk6ejb72r.fsf@assigned-by-dhcp.cox.net>
	 <20051205213929.GB4443@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 08:36:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXMC-0008Kx-Sp
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 08:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVLFHfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 02:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVLFHfV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 02:35:21 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:33362 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751440AbVLFHfU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 02:35:20 -0500
Received: by nproxy.gmail.com with SMTP id x29so97345nfb
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 23:35:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZCurVTzlQC7w25vXowC5wM847+tthhB7PBSLlN8PiO3RA3BwsJHISNDjlHp8Eln+99/eUfXtOtuVXfh1PSMkjMZX+JiXCnq3Gejp88nrKN/GRZfpHhh+AS0iwv7N9ym+LVgiI+8ocrVm3RKkzrRORBJsu/Kw+WTherQpciFmJ4o=
Received: by 10.48.221.11 with SMTP id t11mr26947nfg;
        Mon, 05 Dec 2005 23:35:19 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 5 Dec 2005 23:35:19 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20051205213929.GB4443@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13262>

On 12/5/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> Junio C Hamano, Mon, Dec 05, 2005 21:51:56 +0100:
> > >> This attempts to clean up the way various compatibility
> > >> functions are defined and used.
> > >
> > > You sure you want that before 1.0?
> >
> > I think this is mostly an obvious clean-up, but I do not have
> > enough test environments, so ...
> I will do cygwin. Tomorrow, that is.

The patch works on cygwin. I let the tests run, too.
