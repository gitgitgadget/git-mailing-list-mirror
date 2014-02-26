From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] commit.c: use the generic "sha1_pos" function for lookup sha1
Date: Wed, 26 Feb 2014 17:53:58 +0700
Message-ID: <CACsJy8BQKHuvLpCQMuVK79owdoTbHkS0k3yNJ_9fyvDiJooJgg@mail.gmail.com>
References: <530DBCF3.9060801@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Feb 26 11:54:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIc8H-0004Zt-LN
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbaBZKy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:54:29 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:63339 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbaBZKy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 05:54:28 -0500
Received: by mail-qc0-f181.google.com with SMTP id c9so1024356qcz.12
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 02:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/NY/exIljtNttBxgbVlhRpON2MofxKLza8Q/dY3zr1c=;
        b=vGnRDnBzKwkMtKDifOsL7j5DrzWMGwCJ7wMc+0t+zgkhx7ltyuGUbJiq148Zlb8/lY
         qvL7URBqGiY4mTyjMsejYXynqwqluCcZFWva6w5SqWLFggeRF2whUil4T4YBbu1qN+dy
         OHlMbMS6NzmrmxK/bTxSfUHIYkRx8mk6OADpcO23DmJ0lpwq4MIekB8oKxm19tkVtu0S
         LdoEkX6o20f/itJ8SKpttX7MuoD1COEcQ4wkBYxIsCpcWDRw/3n1tbM+Qu4HFYStkJW7
         /O/fxuvpeb1jpn69P7/c8BP02J/E8gDW8XVC7rXJCRl3ydjeJx/T8goFZ8kF3iklLbwL
         OFkw==
X-Received: by 10.224.19.199 with SMTP id c7mr6916271qab.78.1393412068303;
 Wed, 26 Feb 2014 02:54:28 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 02:53:58 -0800 (PST)
In-Reply-To: <530DBCF3.9060801@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242714>

On Wed, Feb 26, 2014 at 5:07 PM, Dmitry S. Dolzhenko
<dmitrys.dolzhenko@yandex.ru> wrote:
> Refactor binary search in "commit_graft_pos" function: use
> generic "sha1_pos" function.

For fun, try to break your changes deliberately then run "make test"
and see if the failed tests can lead you back to this function. I hear
some people gather in irc. I think they could help you faster when you
need to track this code. Else get support from this mailing list. If
the test suite does not detect it at all, you can add new tests to
cover it.
-- 
Duy
