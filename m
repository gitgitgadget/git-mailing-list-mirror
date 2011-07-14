From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: How to provide authentication along with git command itself ?
Date: Thu, 14 Jul 2011 20:53:42 +1000
Message-ID: <CAH3AnrqR=xMa6KYWBmybXdudo8C8FoeioCs2PgOVZezAE5BWiw@mail.gmail.com>
References: <20110714161508.2378c155@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 14 12:53:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhJYB-0001xo-V7
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 12:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab1GNKxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 06:53:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54385 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab1GNKxn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 06:53:43 -0400
Received: by vws1 with SMTP id 1so79006vws.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zCFfMW60TIe9FA7AUAZUnFkvi9LKc6FB2eA5Mu3jphA=;
        b=DKWN7EiSljVdY4PrpTENG4ezVz+yMLAD7fkqK+UC1tbIyyuNpc0o+05weUO4Pz3u84
         eb+1uwbNPxr3Z42Y36BbF/g+crOWPQemPXgJ9kDI2mOZLL0yyvqLZYfvP8ZkFqecY+wQ
         OZmcRfVHBGfd53JDb/w/ppIFU7q/1dgjP2hck=
Received: by 10.52.187.197 with SMTP id fu5mr2333966vdc.387.1310640822386;
 Thu, 14 Jul 2011 03:53:42 -0700 (PDT)
Received: by 10.52.114.8 with HTTP; Thu, 14 Jul 2011 03:53:42 -0700 (PDT)
In-Reply-To: <20110714161508.2378c155@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177112>

On Thu, Jul 14, 2011 at 8:45 PM, J. Bakshi <joydeep@infoservices.in> wrote:
> Hello list,
>
> During git push or fetch over http , I need to provide username and password every time, as protected by apache htpasswd file. How can I provide the same along with git command ? Or something so that It save the authentication info somewhere within .git
>
> Thanks

You probably want to create the client setup section of this:

    http://kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt

Personally, I prefer to use an ssh hosted repository in such cases,
then use an ssh-agent to cache an SSH private key.

jon.
