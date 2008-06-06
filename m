From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 6 Jun 2008 20:36:01 +0200
Message-ID: <bd6139dc0806061136o3830c826va416edca16550fa9@mail.gmail.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
	 <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>
	 <alpine.DEB.1.00.0806061911300.1783@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paolo Bonzini" <bonzini@gnu.org>,
	"Cedric Vivier" <cedricv@neonux.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 20:37:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4go7-0003rv-Py
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 20:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbYFFSgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 14:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755666AbYFFSgG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 14:36:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:18748 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063AbYFFSgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 14:36:04 -0400
Received: by wr-out-0506.google.com with SMTP id c48so531923wra.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mMXMaaqJ9MPtYYchFggwUpwoVxZHL0zayZDgcRWaWuw=;
        b=huxu1DLoxHAnI8rvUB78+UL42YiXChDOetDIffYKXt80euFReMzTb7PCz04D5pZV4z
         LQ8oE0Zb5A9OBXfd5F68TJpHMnxPDBS1xkdciTb7nAnssyAimjyTgadTe3I0rLa5/8zV
         SH40iIPaIXD+fSFc8t1V2r3xk+rPG/YkOLWDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=hy+m9H2GFwQJXcleV/n8GgVZmOu5FNO2ST8FkC6rwkwWVr/nIBOLOV3IfIfWXdaZ7z
         9v4kbx7aAdyHs+2ry7gQNtSAaT/Dj12rrcvS7N4ikhw/pc8G9Flsb4XJNGV9NSMqXWz/
         auQxL43hy09ADxpk90jN9bWGKp2l/Gx1P907o=
Received: by 10.142.82.6 with SMTP id f6mr149956wfb.43.1212777361905;
        Fri, 06 Jun 2008 11:36:01 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Fri, 6 Jun 2008 11:36:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806061911300.1783@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84097>

On Fri, Jun 6, 2008 at 8:11 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Except, of course, if you have a script that wants to override whatever
> the user set in her config.

I think this is why stuff like GDB has both a CLI and a MI. In order
to keep the CLI clean you have to make choices, similar to how we
already separate plumbing from porcelain. I guess in that sense our MI
is the plumbing, and the porcelain is our CLI. Of course, in that case
there needn't be such an option in the porcelain, as long as there is
one in the plumbing ;).
Conclusion, go for the config option but make sure there's a switch
for scripts in the plumbing?

-- 
Cheers,

Sverre Rabbelier
