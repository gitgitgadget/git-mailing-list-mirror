From: Shawn Pearce <spearce@spearce.org>
Subject: Re: question on service commands in http-backend.c
Date: Sun, 5 Sep 2010 14:20:05 -0700
Message-ID: <AANLkTikjvWpKmf6MP3-=US06XiWkR5cOwHVfVrNUme3w@mail.gmail.com>
References: <AANLkTikH5yzHBA_KO_aMFn6bp3LnMS40S_c3P1QQO4gj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 23:20:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsMdj-0005DU-7Q
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 23:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0IEVU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 17:20:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61674 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0IEVU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 17:20:26 -0400
Received: by iwn5 with SMTP id 5so3571065iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 14:20:25 -0700 (PDT)
Received: by 10.231.77.155 with SMTP id g27mr4556704ibk.195.1283721625241;
 Sun, 05 Sep 2010 14:20:25 -0700 (PDT)
Received: by 10.231.179.143 with HTTP; Sun, 5 Sep 2010 14:20:05 -0700 (PDT)
In-Reply-To: <AANLkTikH5yzHBA_KO_aMFn6bp3LnMS40S_c3P1QQO4gj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155490>

On Sun, Sep 5, 2010 at 8:29 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Short version: can I assume that, of all the service commands [I
> assume that's what they're called] in the services[] array in
> http-backend.c (approx line 530), only 'git-receive-pack' represents a
> *write* attempt?

Correct.

> And yes, I do notice that these new ones are all "GET" so it is hardly
> likely they'd be writes -- just wanted to make sure...

Right.  :-)

-- 
Shawn.
