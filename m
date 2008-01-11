From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 11:39:48 -0500
Message-ID: <30e4a070801110839j6b27e224j9a83fc9975f2e4c6@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>
	 <alpine.LSU.1.00.0801111348230.31053@racer.site>
	 <30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>
	 <alpine.LSU.1.00.0801111501510.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:40:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDMva-0000tS-VR
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 17:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389AbYAKQjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 11:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbYAKQjv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 11:39:51 -0500
Received: from hs-out-0708.google.com ([64.233.178.242]:3717 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752577AbYAKQju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 11:39:50 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1073602hsz.5
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 08:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=12qK+YJB9S/534UU5czcuHGmMsQaPINkNnYPKK7iTGU=;
        b=mUjyggpRgJLj34Rnxfgo8e5MVyicyVYDn0smDnNPnF0b7rli/kOHXBp0g4WNGxZM3SVcAtvoGzYcgS8I+4Py4yldpZshi6QTvMg0h2lwx7Prkiuh9XgoPXKrQao0YurEInHpxjI22u9X18s6a3Kbko2fr80E5UUQVEpc9wne5W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jO3Ou2ef7n7eQSKPTzq84ZuUbz0ZsuIQXSUWD8JVa71HZtHPlNVo0+7TA6t1oVLtSUmS+9YXp7Zl1p6QjbdLGnehytMMNfjqICMWbjxOrhB4rLXarw3yNiGycKUDUBQh7VQHtg3TaBbp5l1ptUWvQU8bpDRvSd45UZ6TtBy/9HE=
Received: by 10.142.232.20 with SMTP id e20mr1768863wfh.59.1200069588163;
        Fri, 11 Jan 2008 08:39:48 -0800 (PST)
Received: by 10.143.159.5 with HTTP; Fri, 11 Jan 2008 08:39:48 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801111501510.31053@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70175>

On Jan 11, 2008 10:03 AM, Johannes Schindelin >
> Okay, so with your change the user has to either remember or lookup which
> is the default remote.  Without your change, the user has to either
> remember or lookup where origin points to.
>
> I still think your change does not help.

That's a theoretical argument: my *experience* with trying to make the
current workflow operate was sufficiently bad and troublesome that it
caused me to write code and fix it to enable the new workflow. Also,
absent submodules the new workflow is fully supported by
branch.<name>.remote: are you advocating the elimination of that
existing feature?

Mark
