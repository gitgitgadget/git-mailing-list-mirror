From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 22:08:34 +0530
Message-ID: <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <7vobdfztz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:39:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmR7-0005vk-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab3DOQjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:39:17 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38807 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3DOQjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:39:16 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so6077781iec.27
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=16QOKC71HkAGWfspFR7xhWW75J9Kzv4r3d+0k8W9yaY=;
        b=Hl7H+NoyUgBJ5qyVFcS7KZ7Nu0tkL5+fyLTGa3sMNb1FIpC9PlE8GFYP+5VoQiAkuN
         FFcD48Rc79Ky9Nw3rca4qy9nGCGuAn7oqDLyunZvfDxLAf+oJl+OwQaSnPjAIjX9MZcW
         nAyMKigJT9bwUYGzhXA5zg8hN7hrie/v+yiqZPO+QQNmvVp+r2cAzs6FFAgsFZRoRGdu
         fVpbAQvQ9VcHisFW3Ka2dO6IFUenKgix7bhtzi3EUpO1EocaVKe1pV1AAv4xr+X19ShO
         NSY/eKeqNGQTu8PX6+kZUUFmQqJ3KBdSKxDGiCnCNepsmuX6Fi7lNSBuKwypMNXN06Sw
         ZuXw==
X-Received: by 10.50.17.71 with SMTP id m7mr5843001igd.14.1366043954852; Mon,
 15 Apr 2013 09:39:14 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 09:38:34 -0700 (PDT)
In-Reply-To: <7vobdfztz9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221250>

Junio C Hamano wrote:
>         git-rebase --autostash
>
>                 git commit --allow-empty -m 'index part'
>                 git commit --allow-empty -a -m 'working tree part'
>                 git rebase --onto $UPSTREAM
>                 git reset HEAD^
>                 git reset --soft HEAD^

Why are you rolling your own stash?  What do you have against git stash?
