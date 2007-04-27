From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 27 Apr 2007 16:21:48 +0100
Message-ID: <200704271621.50257.andyparkins@gmail.com>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net> <200704271019.56341.andyparkins@gmail.com> <alpine.LFD.0.98.0704270938000.6186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 17:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhSGy-0001dP-Sj
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 17:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885AbXD0PWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 11:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755938AbXD0PWJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 11:22:09 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:42510 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885AbXD0PWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 11:22:05 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1004723muf
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 08:22:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RcfrbRic96719/U6SoxE1TzuKhNCb4OGoeWvgDMMceq7ehje5c3fGBXdE9HjfnNxTlnE/OlE/TpbnN5/fBgY6+uFxojLbFgMx+8AdFCa+7E1dyvm5xyST/ZCIudQm1Rll8NGOMrxZbS/koGIJkNWyExDtFJkf38qp1D9Z5Y2tNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WC3gQX6msPp+ZUn+AnGAXhqpl88Yxg1W1zV9wVF9nWGc3I5RPkYc5rlL772+4R8vQmJGRKiUMT784byJUufuHTAH36mOrzFya5A2/+0hAFvusPhThuIckXPnVtpT7MnuLJcq6zC/GqGafu6gVL2ut254mnNVO4HKaMtA2BJIw+I=
Received: by 10.82.173.19 with SMTP id v19mr5785602bue.1177687323124;
        Fri, 27 Apr 2007 08:22:03 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm342750ika.2007.04.27.08.21.58;
        Fri, 27 Apr 2007 08:22:01 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.98.0704270938000.6186@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45723>

On Friday 2007 April 27, Nicolas Pitre wrote:

> I think it is reasonable to say that if you intend to work with a repo
> that contains references to submodules, then you need to upgrade your
> Git version.  It is not like if the Git licensing fees are really
> prohibitive.

:-)  Absolutely.

The case I was thinking about was when the server hosting your project doesn't 
have submodule support and isn't under your direct control.  For example: 
kernel.org and repo.or.cz.  The same is true for those people for whom the IT 
department manage their central server, and aren't very helpful.

In those cases, that repository is being used as storage, it's bare, doesn't 
have an index and doesn't ever checkout the files.  If submodule support were 
capable of being stored (not checked out) by an older git, then people can 
use submodules merely if they have support on the client side.

There's also the distributions to think about - taking Debian as an example - 
a lot of people stick with stable only (especially for servers) - and stable 
is stuck with 1.4.4.4.  It's going to be a long time before a 
submodule-capable git hits Debian stable.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
