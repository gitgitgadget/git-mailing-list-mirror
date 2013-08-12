From: David Jeske <davidj@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 12:40:39 -0700
Message-ID: <CA+CP9O6KQ8vB1k0necmKx3daekmybx5k11sUw4n+b-9SygM5nQ@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
 <CA+CP9O7--HXQdZXH9MJEh0VqdwpYqb052KYrvZqYhbfajpPG0A@mail.gmail.com>
 <CACsJy8A-aSjNdSkiBUBSH43G_FBMnShfpkcwQqM9-6d41rfCUA@mail.gmail.com> <7vk3jqzush.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 21:41:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8xzY-0005Ni-QY
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 21:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab3HLTlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 15:41:20 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36927 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab3HLTlU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 15:41:20 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so9582326obb.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fYsngwhTzin8b8PrDsUgV2kE6Omrapz2XTybpZ3Dg8I=;
        b=jqnfD4AG2V06HyNqRosf7/4Xhn4kN92wr4ehkYMq5PYsSg9agyKO4UJRCosOw2wIHu
         Jbdw3UfsnKFlRA1cqNhH72Tb0xtKzpB/D5Bu/8xj0Q487pj4xw0d/PYTr3pwDvD+9JBd
         i+ur5gspGoOJxBGKC8gBSUUT3EF7tYRMUejr8y166dthwIs9iHywHUhCws19KqUZNExj
         Wks7QwhIzUVTQOUruY9QUJxvZMWrFrzV5Fu4TOhyRLeJ4ao4ZUv5uAdYUkb54DXQmNVv
         tCunE5UD+1c8q7u+TqaAsXd/Ay3ypo5ZljLLUfwvBPXvqgA0o3/nhdHXfeDFgXZLZwq/
         affw==
X-Received: by 10.60.164.33 with SMTP id yn1mr599093oeb.5.1376336479363; Mon,
 12 Aug 2013 12:41:19 -0700 (PDT)
Received: by 10.60.120.65 with HTTP; Mon, 12 Aug 2013 12:40:39 -0700 (PDT)
In-Reply-To: <7vk3jqzush.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232205>

On Mon, Aug 12, 2013 at 10:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Don't we already do that?
>
>     Warning: you are leaving N commits behind, not connected to
>     any of your branches:
>
>         ... list of commits to be lost ...

This only shows on checkout... not reset, not submodule-update, nor
any other ways you can clobber a detached head.
