From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Fri, 4 Jul 2008 22:55:45 +0200
Message-ID: <200807042255.46949.jnareb@gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <alpine.DEB.1.00.0807040237580.2849@eeepc-johanness> <486E540D.8000008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Adam Brewster <adambrewster@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 22:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEsKr-0007Ld-U5
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 22:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbYGDUz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 16:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbYGDUz4
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 16:55:56 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:48567 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbYGDUzz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 16:55:55 -0400
Received: by gv-out-0910.google.com with SMTP id e6so255739gvc.37
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AjR5r4Fr/kkpF9+0gAIifnHna/6r5+jU9wwpvYA9jmc=;
        b=qtBJbX4W7TvwTOBZaLpVMHbzOIbqSGqSuiSGLjchyZC5odL63qRAsfyZIDIqeuFz2U
         2v25VR8FdOuTmz19sZ5ZDdgljLnfz5Ef8LLrMyhjftF6HC8c58jDVoQ6nRRCtX3FZq9g
         CkmI4t2ifafM+VWqKwdTZrbaZi0PvjHv+iSFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Zri88tbsOOue0NX9wz/+mMTdEegDW6/quWOqt9xn/s+XfC9wkDW3Gqh2AGbt9t/1/V
         d3PxYxevZu5F3jIq+ObrrS/fC69isCFJJ4+L3uCmUzVs3zlyr2133GecnZswUaDqsLx6
         4NmAEkqbJ3Ypnz6VQKS14PEwCBWmxV3jerW34=
Received: by 10.103.176.2 with SMTP id d2mr507074mup.134.1215204949696;
        Fri, 04 Jul 2008 13:55:49 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.201.69])
        by mx.google.com with ESMTPS id j9sm3030768mue.5.2008.07.04.13.55.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 13:55:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <486E540D.8000008@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87418>

Mark Levedahl wrote:

> We should have "git push bundle-nick"  create the new bundle, updating 
> the basis refs kept somewhere in refs/* (possibly refs/remotes, possibly 
> refs/bundles?).

I think that because "git push directory" (local push) with error in
directory name, which otherwise would result in error, can be mistaken
for "git push bundle", that we would want to either use pseudo-protocol
("git push bundle://path/to/bundle") or some extension...

-- 
Jakub Narebski
Poland
