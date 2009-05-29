From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git Confusion
Date: Fri, 29 May 2009 16:28:43 -0400
Message-ID: <32541b130905291328wd17339n1a8d1f572099502d@mail.gmail.com>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com> 
	<20090529125853.GB11785@sigill.intra.peff.net> <m3d49sauru.fsf@localhost.localdomain> 
	<20090529135242.GA30926@coredump.intra.peff.net> <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, yury239@gmail.com
To: Paul Tarjan <ptarjan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 22:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA8jF-0000Ay-G2
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 22:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbZE2U3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 16:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbZE2U3D
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 16:29:03 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:41159 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387AbZE2U3B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 16:29:01 -0400
Received: by yx-out-2324.google.com with SMTP id 3so3473352yxj.1
        for <git@vger.kernel.org>; Fri, 29 May 2009 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8wDIFDerhJlmwQ43WEuE7b+j73o+nUFeafgJuhRQggE=;
        b=g2CtZIZ7RA+uhhOqfLUdCosTLdL+hyX+FzBTYL69OJZRvitox0qrLWoPSTWtgo41al
         0xsuoM8gO2wfblu+r5Wab5oBOARo7tglss6fY7UPvGS0aSTGyLd5nCd3nL/BABeVgKuj
         ecFP52DNqkaKQFIsnyV1cyDt/6GCsf9bGD8KI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qdyRib10hD00mZE1TlN2lK9eAhCJ/n5ndWmCVFg1n58x+y4aZIrfSKB+wjDauHUfnr
         CG58lUhwQurSb9wdPoPIfCVvVP2CP+/AsxxVtZL8AIKFDBwZM2bmc9dypG5YIDHqXLf/
         tffpvuRlV1vgwxDV57Jidg+MwHaiwEc6YjfBw=
Received: by 10.151.130.13 with SMTP id h13mr5986641ybn.122.1243628943053; 
	Fri, 29 May 2009 13:29:03 -0700 (PDT)
In-Reply-To: <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120312>

On Fri, May 29, 2009 at 4:24 PM, Paul Tarjan <ptarjan@gmail.com> wrote:
> The reason I need http is slightly convoluted. The remote machine is
> shared hosting with 1 ssh login that I don't want to give to my
> partner AND I don't have root on that box. And as you correctly
> guessed, that box doesn't have the git demon. The local machine where
> he is doing his development. The only solution I saw without giving
> him my username + pass to SSH was to do http cloning. Any better
> solutions?

It dosen't have the git daemon, or it's not running the git daemon?
You can just run it yourself from your user account, and it's kind of
weird that it wouldn't exist.  (You could build it or copy the binary
from another machine, I suppose.)

Have fun,

Avery
