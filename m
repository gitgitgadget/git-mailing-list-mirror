From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 19:35:57 +0000
Message-ID: <200703021935.58992.andyparkins@gmail.com>
References: <200703011206.47213.andyparkins@gmail.com> <200703021200.35069.andyparkins@gmail.com> <E246B7BC-9C82-4F4E-93F0-60B3F1CA54F1@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 20:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNDae-0005ax-OQ
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 20:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbXCBTit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbXCBTit
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 14:38:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:51262 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964852AbXCBTis (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 14:38:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so795426uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 11:38:46 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j5o5CfmbWaFP709tbj2WVGaJoOPW1ijxZt9fmJ8T6E8bXSKP3juVaCB084sEJoxQws0srZgBYvgB2P5rfUk3ZDPGDyo7nfc1efitjYQF9GgNb2garzi6Mk/64F+aouiCXkn5zVuPShgYEFzu/X0I3tMpD/Os5TlSqaiHq9WDI1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Iq1NZGDzz3gvplAdQf1uHEL6vfwlKjMgDiR7GMZ3zaaUdhJWID9Bu3bDNnOS1hE4Y9FwUCPHV2RepXWoHUBUCfxar9UtpTUr3PoPKB6OiIZES2i9REwsA7NPi9oqsnR2epFDVab+NVu6cX1Wx0B/zk4I+H6QDU0bjwCZNsgT2zU=
Received: by 10.67.119.9 with SMTP id w9mr3858746ugm.1172864326882;
        Fri, 02 Mar 2007 11:38:46 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id e23sm3390715ugd.2007.03.02.11.38.44;
        Fri, 02 Mar 2007 11:38:45 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <E246B7BC-9C82-4F4E-93F0-60B3F1CA54F1@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41240>

On Friday 2007, March 02, Brian Gernhardt wrote:

> I'm sorry, I was assuming that information on what to do with each
> attribute would be in the config file while a majority of the
> attribute information was in an in-tree file.  I was actually
> assuming:

It's definitely in the .gitattributes file, but is also optionally in 
the config as well.  This means that a user can always override 
something locally - i.e. they're always in control of their own 
repository, even when they disagree with upstream (perhaps).

> .git/config:
> [attribute "image"]
>     show = ...
>     merge = ...
>
> With the ability to have additional "path =" entries for *local*
> overrides/additions.  Storing the handler information in

That's almost exactly it; but it makes the assumption that each 
attribute will have one unique handler.  Separating them means that 
multiple attributes can use one handler (or set of handlers).

> the .gitattributes is one of the worst things you could do, IMHO.  It
> assumes that people will have a homogenous environment to develop in,

Oh definitely.  This is one thing that everybody absolutely agrees on.  
The in-tree file /only/ adds attributes and never says what effect 
those attributes have.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
