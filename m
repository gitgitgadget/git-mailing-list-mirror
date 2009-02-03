From: Eric Kidd <emk.lists@randomhacks.net>
Subject: Re: [PATCH] filter-branch: really allow running in a bare repository
Date: Tue, 3 Feb 2009 14:31:32 -0500
Message-ID: <431341160902031131s63f34665ne9db25d8a4d1f0f9@mail.gmail.com>
References: <cover.1233684552u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0902031910001.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 20:33:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUR14-0003LC-Dk
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 20:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbZBCTbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 14:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZBCTbf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 14:31:35 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:18016 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbZBCTbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 14:31:34 -0500
Received: by an-out-0708.google.com with SMTP id c2so856724anc.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 11:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=qZ5MWLlomUwLazQmWgvrSJW4olHvJSZLN9wYOSZzE+8=;
        b=FKl2dghlH62uAGFWNDhfBkXAh0IF5e31YZOcRyUvKPAZr7Rs+VJBsvkZRJ2+wR5IuR
         9FxgQ9wyZwG+i89nb8+cYn/ZU2wupHp4eNgJflUwfOBzjp18Wf7s0WihF9Wt0ftddXqY
         Oce28tzJUsyuCQgzIEerceimJBxhkJ4dV1Phg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=w1nbw3zAQITLTKjFLA+VKl5wGHSlgk9Tyh6OBsO5NlmkwuDIvSfbg95OYXoiaFX7Ek
         nhXcvUQni0zdrvBQ1FI5fqduPRaQOC8uQ3HWVvIXkh5DP7bGL5oHFkQi4NgFqGyuBVX0
         lYcO4SD8W/yu1EiSCYiI+gOfk+2E1l4WqAllE=
Received: by 10.100.227.6 with SMTP id z6mr2412045ang.120.1233689493143; Tue, 
	03 Feb 2009 11:31:33 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902031910001.9822@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 59b8efe7c11ed1c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108244>

On Tue, Feb 3, 2009 at 1:10 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When checking if running in a bare repository, the work tree has to be
> reset, otherwise we will be checking the temporary state, which is
> always non-bare.

Just a few minutes after you posted this patch, I posted a
nearly-identical fix for the same issue:

  http://marc.info/?l=git&m=123368695831812&w=2

(My patch includes a test case, too, but it's not very important.)

This raises another interesting question: Why doesn't 'git
filter-branch' actually check whether subcommands succeed?

Cheers,
Eric
