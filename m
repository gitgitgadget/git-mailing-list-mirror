From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Cleaning up history with git rebase
Date: Sun, 31 Jul 2011 21:33:51 +0000
Message-ID: <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br> <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>,
	git@vger.kernel.org
To: Ricky Egeland <rickyegeland@linea.gov.br>
X-From: git-owner@vger.kernel.org Sun Jul 31 23:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qndeb-0006JN-De
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 23:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab1GaVeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 17:34:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44402 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab1GaVeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 17:34:21 -0400
Received: by iyb12 with SMTP id 12so6136866iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=corFaC0Kh8E9eGg8OvqHd2xr9uJlXvJAa/DLf/O4vG4=;
        b=HlZCcKuaHkJccgl9cl2QDfZcKhOvJWU30vy/xgYrWkHgc90DE8Rs39Wcc8/QPdRbXM
         ysuNmBlLZKYncAtLMT9ajkrAvS9ERkkV4EpfUnxwimN+ZImC4alx46b4lG+3fCFzx8OK
         IlTWrBfylpsZbwrycSZwEYqHiL4/VgOQ8LIcA=
Received: by 10.231.117.35 with SMTP id o35mr2289123ibq.160.1312148061217;
 Sun, 31 Jul 2011 14:34:21 -0700 (PDT)
Received: by 10.43.52.136 with HTTP; Sun, 31 Jul 2011 14:33:51 -0700 (PDT)
In-Reply-To: <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178280>

On Sun, Jul 31, 2011 at 20:21, Michael Witten <mfwitten@gmail.com> wrote:
> Why are there conflicts anyway?

Oh...

I guess there were conflicts when the merge commit was made in the
original repository, and these conflicts were resolved by the merge
commit itself. Hence, when rebase tries to split up a merge by dealing
with just the non-merge parents, you end up having to deal with the
conflict again.

Shouldn't rebase take this into account?
