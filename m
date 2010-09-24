From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multiple checkouts active for the same repository
Date: Fri, 24 Sep 2010 08:57:37 -0700 (PDT)
Message-ID: <m3hbhfgmo4.fsf@localhost.localdomain>
References: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gustavo Narea <gnarea@tech.2degreesnetwork.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 17:57:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAeh-0002iY-Eu
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 17:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab0IXP5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 11:57:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53922 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab0IXP5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 11:57:41 -0400
Received: by bwz11 with SMTP id 11so2060440bwz.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=LoSYv65JicC15vyKyU2nN7JJuBOqIwCIcasrH/JnHfY=;
        b=bXFJCZ4l/6dVntjLLHaUBNs/UFgMx07kmd0CTGsSArMWH6n/wXxKzSzKsKbbpUNDzY
         TYlSduJBDsbRgxd2++pJi92aGMC9udcJck6Kp8SrK/eAxE9hLec/51j4gPUNiUWMYQby
         SSyuH2m4/YW2B1aStM79rP0baik4qVOE/DUHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=masXyP3MmuqVU4fkRGqOHrX4u9M43kG4tf7OutA+fcy7rnGHORH1/OsDqgnCBQrM2V
         IPu8lda4efipcCFaLQMHKQi4boX9rmdo0lOVHE6xXN+Zmq1hg0V/URQbVk2V9gg4DngS
         CgApYWW8zhBEMYNpVu9fPpBzEBCXATs6tDelA=
Received: by 10.204.47.214 with SMTP id o22mr2290517bkf.17.1285343858405;
        Fri, 24 Sep 2010 08:57:38 -0700 (PDT)
Received: from localhost.localdomain (abwq206.neoplus.adsl.tpnet.pl [83.8.240.206])
        by mx.google.com with ESMTPS id f10sm1710478bkl.17.2010.09.24.08.57.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 08:57:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8OFuxJo000586;
	Fri, 24 Sep 2010 17:57:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8OFuhXS000582;
	Fri, 24 Sep 2010 17:56:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157000>

Gustavo Narea <gnarea@tech.2degreesnetwork.com> writes:

> Hello.
> 
> We're currently migrating from another DVCS, which allows us to have
> working copies of each branch in separate directories, so that their
> code can be used simultaneously. However, I haven't found a way to do
> this with Git, at least not an easy way. Can you please help me?

Use git-new-workdir script from contrib/workdir/ in git repository
http://repo.or.cz/w/git.git/blob/HEAD:/contrib/workdir/git-new-workdir

-- 
Jakub Narebski
Poland
ShadeHawk on #git
