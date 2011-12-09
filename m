From: Justin Johnson <justin.johnson3@gmail.com>
Subject: Re: configure git to not push all remote tracking branches
Date: Fri, 9 Dec 2011 10:07:50 -0500
Message-ID: <CAPD5EOgeKpV1bWJZmdUR6ZQuA=objSAApVrz1W9W8C_ij+XN9A@mail.gmail.com>
References: <CAPD5EOjsu-9=CCUJut_bGqv=asp8FeGqL2GhKewgw3SQsArk_A@mail.gmail.com>
 <CALkWK0m0f-AGLwKqiKx9Aozwr5oN6FrH5ehG03mmEpB7Di8PWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:08:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ23d-00033N-GP
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab1LIPIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:08:12 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52837 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab1LIPIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:08:11 -0500
Received: by ggnr5 with SMTP id r5so3388274ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6wb9VOo4PYLN6ah9kxEXdCx+pfNyMAcIsORe2nKfGR8=;
        b=ijXeLpskjsuodc8BfaFhmbLmlL12rzXoHoKaD+/yDqC9E6GgeNBFtgsS801628b5qd
         KN8y1qAMmw8oF8z8S3E4iKlIsH8TSNtFSHZoAkWXgQNZjqaRFW7UWcU7QjwB5BTcnGdq
         2EFaaAMZTs264HXp+uFrhBei/vLZGULpX6eXs=
Received: by 10.182.86.229 with SMTP id s5mr528123obz.37.1323443291184; Fri,
 09 Dec 2011 07:08:11 -0800 (PST)
Received: by 10.182.114.4 with HTTP; Fri, 9 Dec 2011 07:07:50 -0800 (PST)
In-Reply-To: <CALkWK0m0f-AGLwKqiKx9Aozwr5oN6FrH5ehG03mmEpB7Di8PWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186637>

On Fri, Dec 9, 2011 at 10:03 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi Justin,
>
> Justin Johnson wrote:
>> git push alternateorigin
>> should not do anything, but
>> git push alternateorigin mybranch
>> should push just mybranch.
>
> $ git config push.default nothing
> Note: push.default defaults to "matching"
>
> Cheers.
>
> -- Ram

Thank you, that's exactly it. I saw it in the docs for git-config but
wasn't positive that's what I needed.

--Justin
