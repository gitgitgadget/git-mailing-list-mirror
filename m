From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Add svnrdump
Date: Thu, 15 Jul 2010 12:28:33 +0200
Message-ID: <20100715102833.GB22574@debian>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100714153206.GH25630@jack.stsp.name>
 <20100714160149.GA7561@debian>
 <4C3DEA4B.9090507@collab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Sperling <stsp@elego.de>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "C. Michael Pilato" <cmpilato@collab.net>
X-From: git-owner@vger.kernel.org Thu Jul 15 12:26:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZLeZ-0005Ch-GF
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 12:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998Ab0GOK0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 06:26:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60151 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932984Ab0GOK0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 06:26:49 -0400
Received: by eya25 with SMTP id 25so119805eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=spsvxKPOBTQqXnUwHC8Y49p3ZUY0cvtj4UsxV1Cgdos=;
        b=L6S8DR5zDRy/wahqQUj3J4wQ+JXHZTnmcNo1mdUKOapSmrmzTexGP2kz95sYk4VAX5
         P7s6yGtuJp5qEq8/gYxMxXwdniKaSKzVj8Bv+a8Um9mKfzbnwkbtV6vOB42Uh9V5jguU
         Dlh3I1gz9jdIgoDIJVky4l4nvkWNI4A/xhD/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c6D/L1KeC7acAJ9qtrJ8WULKDFLJSKg8q4tO9tM6IB6ss4zt4sG+a7XmdWyR2gMBVO
         wUJlQSoGXiHunoyMU1wQrqFfDSMKG4cb7vxUMmvkZwhYqcg4q7F9mFchzE+EAd5vSIKO
         MiP+jSbSz7XZIJh31a8zpr6ugodZTRBd+iMvc=
Received: by 10.213.28.130 with SMTP id m2mr12567857ebc.21.1279189607306;
        Thu, 15 Jul 2010 03:26:47 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm6927550eeh.5.2010.07.15.03.26.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 03:26:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C3DEA4B.9090507@collab.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151072>

Hi Michael,

C. Michael Pilato writes:
> You fake it, just like the code behind 'svnadmin dump' does.  :-)
> Seriously, Revision 0 is nothing but a revision header and revision
> properties.  There is no node data to transmit.

Right, thanks. Will look at the code behind `svnadmin dump` :)

-- Ram
