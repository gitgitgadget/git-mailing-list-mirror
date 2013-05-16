From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 03:56:53 -0500
Message-ID: <CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:57:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uctzg-00068q-64
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317Ab3EPI44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:56:56 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:33586 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122Ab3EPI4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:56:55 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so801561lab.10
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Ibw+YHYMQpXvlcnIyrp/LvFPmOhXD7EQWZUiyENIhi8=;
        b=ZsPeUApMRkUa7QPqQ8KJtZhHstrqMRIPNhxcnGDNmsWp6qFcTM30P429l+N8NZnDIz
         QO2STuewz1Xvr7WXuNRgX2jBfS0y5bmWUla+sG1JAOK9fHTPadzXKVUdBY6LzOYQiVif
         KGxMrmBIAc/WJACK+l3R7jb2zHP+sfjrJYaETrVYV/x9gMiXRBZYymhfO/LK103oyrhH
         n9QIuaX/gNvwjxmME41f8z9SxLNpnuLJw4TosuiDaueBahbYml3B/XMWmFiw4Xy+5MhS
         Gr02LBkCgu+qWCz3xMq1WkEpH/vrZipVyI6RIluuvzEfoH7Cc++fEFUHc7PiZh3AWWQw
         dIsw==
X-Received: by 10.112.166.101 with SMTP id zf5mr19203843lbb.59.1368694613582;
 Thu, 16 May 2013 01:56:53 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 01:56:53 -0700 (PDT)
In-Reply-To: <CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224513>

On Thu, May 16, 2013 at 3:29 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>  git-pull.sh | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> This one obviously looks good.  I'm not sure why you sent it along
> with the other two patches though.

Because this patch depends on the previous one.

> On a related note, I'm interested in fixing pull.  What I have on paper so far:
>
> - pull.condition = clean-worktree | ff-update | no-local-changes |
> always | never
> - pull.action = merge | rebase* | reset
> - pull.resetType = soft | hard | merge | keep
> - pull.autostash = true | false

I don't understand that. But my only concern is that there's no way to
do something like:

% git fetch backup 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'

-- 
Felipe Contreras
