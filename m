From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Unable to remove git branch
Date: Fri, 29 Oct 2010 03:42:45 -0500
Message-ID: <20101029084244.GD26290@burratino>
References: <201010290943.13177.sasch.pe@gmx.de>
 <4CCA7DA8.3020607@debugon.org>
 <4CCA7E42.7080906@debugon.org>
 <201010291031.42305.sasch.pe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathias Lafeldt <misfire@debugon.org>, git@vger.kernel.org
To: Sascha Peilicke <sasch.pe@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 29 10:42:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBkY6-0002OB-Dc
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 10:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab0J2Imx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 04:42:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40854 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760638Ab0J2Imw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 04:42:52 -0400
Received: by gwj21 with SMTP id 21so1805692gwj.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kI6lVX/Jp2NMn4RwA+b+xzqn24SaBYuzLXF5Ptt3ZwM=;
        b=WsOpuQsrZgU7sjmUpcBazDfCgFQoqiWFmBlZWwTYnN1n9cygBvLt9MC6LWEhiR9/PO
         u7Ao+3CEEm3/P1GLDwRRUbTwLErqR1Hu4UmCgd4Migl+fHuUDbBeFXqMp/ANq12DWuxU
         0a0f/WPTIAWseFLq4AjNsuIBi0iH9HuL1Bof8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UpmHPOHELlWSukPLVUf/v5jKMCnSIK+ZJe2cgBNW9xcJaeumPOVqR7rIkNmMGs7ufL
         jTCUuydW7Wat0TUaDpzx+L1gfD45ZBITf47exq6f+6C3CEZp9GhB84cwx0t68insGvyl
         hoZE+2kpfCo5k+/PIR4ptojQkjwTML0KbIp4E=
Received: by 10.150.228.7 with SMTP id a7mr5189675ybh.121.1288341771520;
        Fri, 29 Oct 2010 01:42:51 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q41sm1553757ybk.13.2010.10.29.01.42.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 01:42:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010291031.42305.sasch.pe@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160322>

Sascha Peilicke wrote:

>                      Maybe '-' should not be allowed as the first char in a 
> branch name?

Heh - see 6348624 (disallow branch names that start with a hyphen,
2010-09-14).
