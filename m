From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git unpack-objects on Windows
Date: Thu, 13 Jan 2011 13:40:03 -0600
Message-ID: <20110113194003.GA20855@burratino>
References: <1294916875939-5917819.post@n2.nabble.com>
 <4D2EF04B.20108@viscovery.net>
 <1294926881696-5918228.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	users@cvs2svn.tigris.org
To: Kevin Sheedy <kevinsheedy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 21:03:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdTOA-0001Z6-JU
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 21:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359Ab1AMUDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 15:03:04 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56987 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933341Ab1AMUDB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 15:03:01 -0500
Received: by wyb28 with SMTP id 28so2083351wyb.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 12:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Q5IURFbn/2TBCUAuFEnBFqP7im21ke8ddpT5cQTHrxw=;
        b=TQ1gLWmoSGl/px/vF1MnExNy/9oR4gjd1LPHHJNi2EXVmvRrQw0DapMaelLUKE/M6g
         RooAxOa7WpDbmnzMGIzmE9NsbkGn8sFUaoWF7G/W//WGhZ2NMftHrNCe35StGBqAGnTM
         w3lylHflrDdGomkOxTZGolYII7iqqCDCZ4h60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sp+Znkl7QzVmZpBV4jMKLEWx7wA7V0d0SvBWF7yJAftR8sfzAvKRs/6Pimmku4UcZm
         Vp+mBsUl22Xh7X4lqWE0ZrH0uhN4dwND5u1aylGyFyg+lEHqg0/zRnWwIhoUwWT1n8O8
         nN2uRNGHmiQ5seqMzGrlUMNWyWx+2+JE61sjE=
Received: by 10.227.129.83 with SMTP id n19mr2751662wbs.99.1294947622766;
        Thu, 13 Jan 2011 11:40:22 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id 11sm313704wbi.6.2011.01.13.11.40.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Jan 2011 11:40:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294926881696-5918228.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165065>

(+cc: users@cvs2svn so the web page can be improved)

Kevin Sheedy wrote[1]:

> git init
> cat cvs2svn-tmp/git-blob.dat cvs2svn-tmp/git-dump.dat | git fast-import

You're almost there.  I'd suggest two steps:

	gitk --all;	# reconnaissance
	git checkout

Hope that helps,
Jonathan

[1] following http://cvs2svn.tigris.org/cvs2git.html
