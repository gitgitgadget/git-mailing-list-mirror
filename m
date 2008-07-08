From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Tue, 08 Jul 2008 06:08:56 +0200
Message-ID: <4872E858.4080607@gmail.com>
References: <200807080227.43515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:09:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4WB-0004mF-7U
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbYGHEIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbYGHEIe
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:08:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:47494 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYGHEId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:08:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so727197nfc.21
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 21:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=wZL5q47msP/6NXfkqH80066FA9eeEGGElLG1fUDMI9I=;
        b=bIcaE7ubsC4bp+sLiceHb8QLva4jN2GGdrcj87VI4RoSxanU5EsB2eHXEWmnxTRIoD
         RJXWGVGj1VHHwXX8d8JAEcFYpJbde3wxGOkeX0judzT6ys/mQS8exyELpHoGkZEbHS1T
         raMM1k2C4YI27Tw8KDrJ3ze6NTOJMiClFyxq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=QNiP68n29iZY4lfKeYz4tDa2Ohhvzj0lDiWL8j77pW2ZtLqPg/JxSG805IC/Txcpua
         jUBebP1P2eX9ogzAfP2uG9mgjTFCs9hEvosiCLiq4TIJBPA//ZjY5NGPhkZHer8GrX0T
         QxvhfkIsBW+7u7Gt39GrLeTQ7jzGirKDF5R1s=
Received: by 10.210.114.15 with SMTP id m15mr3670730ebc.82.1215490109476;
        Mon, 07 Jul 2008 21:08:29 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.220.244])
        by mx.google.com with ESMTPS id c24sm7954471ika.4.2008.07.07.21.08.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 21:08:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807080227.43515.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87700>

Jakub Narebski wrote:
> 3. Gitweb caching

I'll post a complete status update in the next few days.  And three
large patches (including the mechanize test). ;-)

> Lea has chosen caching data and memcached as primary caching engine,
> and is working on object layer on top of Git.pm, namely Git::Repo and 
> friends, which will be used by gitweb.  If I understand correctly 
> caching is to be done, or at least helped by this layer.

That's correct, except that I'm not using Git.pm anywhere; Git::Repo is
independent of Git.pm.  More about that later...
