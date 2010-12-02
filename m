From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation: escape '~' in git revert
Date: Thu, 2 Dec 2010 11:50:13 -0600
Message-ID: <20101202175013.GF3962@burratino>
References: <1291311393-31843-1-git-send-email-sylvain.rabot@f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain.rabot@f-secure.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:50:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODIc-0007B2-Be
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703Ab0LBRuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 12:50:25 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62179 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab0LBRuY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 12:50:24 -0500
Received: by gxk1 with SMTP id 1so1333518gxk.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 09:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DeoEGJM5fSzMZLaHtWtJNJFHobLJ1raeDFjee2NN7p0=;
        b=KvPqaCB/guHvNKfYP/vu67KauNzspp4I+1VtYzt9PDVTwCBF8fRHswShrZnP6SMU/j
         U2CGtB/FQtbOlQdYe3xE3J68QpMgZFwQuJYBTdlJtYoSvzfuCDD+SSkGDTP6oVoLz7kU
         +rRG0UjKjZkgugGYrcvAqjSxf4f4tkhmXMKL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wYANw/Vgy2BwRpF62wTtadHpVPUd1uLEg7AUxth2GluLMcNZUfy1XWRRdyMhlCshVg
         gDl8jfkKyd77WQ2Rh++ngOklM+LwiGJBtbyqR8m9jiYrhDKSUJo9AR+ieTmNZ5uMjGTa
         2qxfINWE5vVF53v9H7lvruyyYHHmRo1ouN1B8=
Received: by 10.151.14.7 with SMTP id r7mr2118368ybi.19.1291312224154;
        Thu, 02 Dec 2010 09:50:24 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id v10sm455756yhg.45.2010.12.02.09.50.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 09:50:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291311393-31843-1-git-send-email-sylvain.rabot@f-secure.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162719>

Hi,

Sylvain Rabot wrote:

> backslashing '~' characters do not have any effect, quoting with +++ has.

Odd.  The first example already looks okay here.

> +++ b/Documentation/git-revert.txt
[...]
> -git revert -n master\~5..master~2::
> +git revert -n master+++~+++5..master+++~+++2::

Please use the {tilde} entity instead of +++, since the former (1) does
not make text monospace and (2) works with older asciidoc.

Good catch, thanks.
