From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 10:19:24 +0000
Message-ID: <200702151019.25409.andyparkins@gmail.com>
References: <200702140909.28369.andyparkins@gmail.com> <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfy98snus.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 11:19:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHdiF-000277-W5
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 11:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965777AbXBOKTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 05:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965776AbXBOKTc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 05:19:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:63324 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965773AbXBOKTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 05:19:31 -0500
Received: by ug-out-1314.google.com with SMTP id 44so101163uga
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 02:19:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PBKtyCUGNdp7pZ66JEnnvK/U3aVb2p/hdY4SGPmmPf1+JszGlp8/GiZUYgun49it77RaY2pdUW9NrXjvRG7Sw4CH7PtSSMvamz3QEMlkGgQrRNbvyaVA9OFqlnuM47HLjd+A8N4YwkDLz3NF0aI6EGiaM6dmO5G65/y/IwLdzL0=
Received: by 10.67.28.4 with SMTP id f4mr1313831ugj.1171534769369;
        Thu, 15 Feb 2007 02:19:29 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id s1sm1957900uge.2007.02.15.02.19.26;
        Thu, 15 Feb 2007 02:19:27 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vfy98snus.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39808>

On Wednesday 2007 February 14 16:30, Junio C Hamano wrote:

> Site-wide configuration for options that are potentially
> compatibility-breaking is a bad idea on a multi-user machines,
> and it was certainly the case back when our machines hosted many
> diverse set of people.

Isn't it more likely that on a multi-user machine all users are sharing one 
install of git - in which case you do want the upgrade of facilities to be 
system-wide.  Otherwise you have to tell every user to edit their .gitconfig 
to enable the new facilities - users shouldn't have to care about that sort 
of thing, that's what admins are for.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
