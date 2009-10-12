From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: git log --graph
Date: Mon, 12 Oct 2009 07:08:36 +0200
Message-ID: <28c656e20910112208y5eb843eex41e928e04a465396@mail.gmail.com>
References: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:14:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDEz-0004fB-8t
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbZJLFJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZJLFJO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:09:14 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:39383 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZJLFJN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:09:13 -0400
Received: by ewy4 with SMTP id 4so2180216ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=yCEpEZyN3wOw0mkjdGz9S+7HqnjstxZHrCYLNc8CdeQ=;
        b=iuYJLefWrJbNfPMeYHmXoRE7nR/SqpYuAbWDBjYEG6O1MpplbvWDQgg5MpMuTRon6F
         SGID3Zm9yW9f8dFVSKxxIUxUIDAyIJWC4fgD2enWxxe1lj5I5/RqRuidJBKwXV8+P1bc
         V52fgxT4RIWh6ZZIRvHxFbRrxHcVgfww29qtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nlozbPEo/X0CNP5wWSssv42jck25fOwlCw3pMh/bMXjRpnMrFOtBIfLrZrLWu+6sfU
         f7KwCYF4693luvw4cSNtYP0NHXSRznf3ueiGhBKb4g1FgcHWZ+3R+ZCHBCRsh6aS5a8z
         sLJykSXrD7dJ7GGN2zCDvlz6aKkR9eqnXYl0w=
Received: by 10.211.171.6 with SMTP id y6mr3460983ebo.91.1255324116727; Sun, 
	11 Oct 2009 22:08:36 -0700 (PDT)
In-Reply-To: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129977>

On Sun, Oct 11, 2009 at 20:27, Dilip M <dilipm79@gmail.com> wrote:
> I am using: git version 1.6.3.2
>
> Somehow not getting text graph as mentioned in
> http://www.gitready.com/intermediate/2009/01/26/text-based-graph.html
>
> Any hints would really help..
>
> I am trying git log --graph. (has commits in two branches...). But
> always see one line :(

"one line"?
1 of history? (i.e. the history of the current branch, but not the other)
2 of text?
3 --pretty=oneline?

assuming your problem is 1:

git log --all --graph

//ben
