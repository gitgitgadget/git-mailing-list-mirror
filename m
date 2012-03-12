From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Removing unmaintained scripts
Date: Mon, 12 Mar 2012 16:41:39 -0500
Message-ID: <20120312214139.GA11362@burratino>
References: <1331514446.3022.140.camel@deadeye>
 <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu>
 <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu>
 <20120312152004.GB9380@kroah.com>
 <7vfwddu60f.fsf@alter.siamese.dyndns.org>
 <20120312171257.GA25347@kroah.com>
 <7vzkblsnos.fsf@alter.siamese.dyndns.org>
 <m38vj5zeo5.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Greg KH <greg@kroah.com>,
	Willy Tarreau <w@1wt.eu>, Ben Hutchings <ben@decadent.org.uk>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:42:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7D0F-0000EO-It
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab2CLVlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 17:41:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52949 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab2CLVlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:41:53 -0400
Received: by iagz16 with SMTP id z16so7413238iag.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ptjJv7izFzXk+mabomDbQ4IDeEavoD1mBmr83s6GwzU=;
        b=DGphgeiD2M6j+6ndY/BMommCHYav66OMi/I+qDX4LL6gjdJDM9DVGxaeh6ep/Su4E+
         FPrmvWnILib2G5IIN6MV3tNtSrfRGYPf62E8fqyJr/r4XdMsXag4TgLW8jA8kVfffx+/
         YXVo9b7UjLMK80mr1Ko+FcmnMVQx6OD4cnkTCUEagebR9k8Xf1PdafDFV2iF4JRO5KYd
         FKqv+1qKqXDSULKTuKeDzJvOcpcRXURrvcRKh33sgHT+x1XPY90/iqoJC+D8+PFRvYUq
         EJQUJ8diLtnaSdlnxSzs+NgEP6jP2P3T9jCzj0kvoHJPRv96LDYqdKZxGlBYBcIfmbAK
         sqJQ==
Received: by 10.42.158.71 with SMTP id g7mr17510207icx.38.1331588512794;
        Mon, 12 Mar 2012 14:41:52 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ba4sm13506636igb.14.2012.03.12.14.41.51
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 14:41:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m38vj5zeo5.fsf_-_@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192954>

Jakub Narebski wrote:

> A'propos, there is git-archimport script, last modified (as an
> individual script) in 2007.  Is anyone using GNU arch nowadays;
> isn't arch-fast-export better solution anyway?

According to [1] (see the green line), it still has some users,
or at least people who access the file now and then. ;-)  As long
as the script works, why would we want to cause them trouble?

For comparison, here's the corresponding graph for people using
GNU arch[2] and participating in the same survey.

Hope that helps,
Jonathan

[1] http://qa.debian.org/popcon-graph.php?packages=git-arch
    http://qa.debian.org/popcon.php?package=git-core
[2] http://qa.debian.org/popcon-graph.php?packages=tla
    http://qa.debian.org/popcon.php?package=tla
