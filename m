From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Commiting automatically (2)
Date: Sun, 19 Dec 2010 14:17:36 -0600
Message-ID: <20101219201736.GA12653@burratino>
References: <loom.20101219T090500-396@post.gmane.org>
 <20101219150850.GC12136@foodlogiq3-xp-d620.thebe.ath.cx>
 <20101219183619.GB11955@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maaartin <grajcar1@seznam.cz>, git@vger.kernel.org
To: Taylor Hedberg <tmhedberg@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 21:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUPhi-0005YO-Dn
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 21:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab0LSURt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 15:17:49 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33920 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435Ab0LSURt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 15:17:49 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so1040174yxt.19
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fGGJIgQNhdor8UIoeTNN+HhzP7WY6Bo88j7OTt0R7K8=;
        b=dVvQC1uBra1+DB0NM9/ZpD2iWBt92FCJkZHuUstIhvSvZ00PK4u9SjxFOiE8R7JGIl
         DnVmNrLsSfoFnAM5WNMcrQTY9LPWssnQOdroJ9e6746mIkLaIDx+NWgM8nfVYJZBjdbQ
         nDWnhXW7QsuBAmFWOVnxM7/hJ/ci1JwW6flfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l697+Kv202RHUkZMGgDNUpqk1QgZ/7Nrvw5IOZzW+ukAoSGStgruX33hIGOZ69iGh0
         Rob+fB6bKOEAl+alR9uycEg3677ZPUN6GfWc9To0EGWnPVPJP88926k1I4ZvUdhE7fyJ
         O2gP2earEpLSbcJGb0/VtiQx9jgJ9vnVsLBtM=
Received: by 10.150.200.7 with SMTP id x7mr5658579ybf.153.1292789868669;
        Sun, 19 Dec 2010 12:17:48 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id p32sm3774946ybk.20.2010.12.19.12.17.46
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 19 Dec 2010 12:17:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101219183619.GB11955@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163968>

Jonathan Nieder wrote:
>> On Sun, Dec 19, 2010 at 08:29:50AM +0000, Maaartin wrote:

>>> There's one more problem. My script doesn't recognize deleted files, since
>>> git add -A
>>> does nothing to them.
[...]
> Maaartin, could you give an example showing where add -A goes wrong?

Please ignore; looks like Taylor and Junio figured it out.  (For
anyone else who was confused like me: the files in question were
removed with the equivalent of

	git rm --cached generated.c

rather than

	rm -f irrelevant.c

.)
