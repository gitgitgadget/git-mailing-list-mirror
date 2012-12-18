From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Mon, 17 Dec 2012 22:34:07 -0800
Message-ID: <CANiSa6h3Qf=6hw6fzHVw=CeuhnNeq+cuEvwwmVhUaSOcVgCSBA@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
	<7vlir6brjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 07:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkql0-0001KU-LS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 07:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab2LRGeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 01:34:08 -0500
Received: from mail-ia0-f175.google.com ([209.85.210.175]:50443 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab2LRGeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 01:34:07 -0500
Received: by mail-ia0-f175.google.com with SMTP id z3so225733iad.6
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 22:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IssRvM7kvX/AYjkKdD+ldTfNs/N/6xSlaTJiNlwM+zY=;
        b=HQCp0cL7WDt97PgMbG/PiMdihy8k+AytUaTwF6m4xVrCq7rK/Juw8QkAtcWSCdLHwX
         KEp2KQuL80Wh9xew8bi5oyjt3CkjZfObY/MsPJpEUxCDd737xGqYtKgU4MZ0ttYl47i8
         YaGOPQdMiz5NNsTOT9rj7KY+fLtjhMld8zlVV1zZcmL8FTpL4QmQVE+RrVU2S3ehChxE
         Ihs0tqvQLXCkY694yCchvgErvR8HsWuYHKery8nBDZxvofPkY1yJdiImMuM9y7LiWYdr
         7seln5c09I0E9dluzhKC12dcuVO2GWvFBfR61Lx0mT9iZmhkKNhB2LON6kemvGGr85+/
         B+4A==
Received: by 10.50.214.68 with SMTP id ny4mr981792igc.65.1355812447100; Mon,
 17 Dec 2012 22:34:07 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Mon, 17 Dec 2012 22:34:07 -0800 (PST)
In-Reply-To: <7vlir6brjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211737>

On Wed, Nov 23, 2011 at 10:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I am guilty of introducing "git reset --soft HEAD^" before I invented
> "commit --amend" during v1.3.0 timeframe to solve the issue "soft" reset
> originally wanted to.

I do use "commit --amend" a lot, but I still appreciate having "reset
--soft". For example, to squash the last few commits:

git reset --soft HEAD^^^ && git commit --amend

or undo "commit --amend":

git reset --soft HEAD@{1} && git commit --amend

Maybe there's a better way of doing that?
