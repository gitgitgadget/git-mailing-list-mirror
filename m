From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] contrib/remote-helpers: setup ui.username in test-hg.sh
Date: Sun, 11 Nov 2012 13:39:10 +0100
Message-ID: <CAMP44s3cx9EHfM7wEX3zV-MXqX11VusYj8W9cL63mFTUq+_C+Q@mail.gmail.com>
References: <CALkWK0kguFpA3ExSt7YKtugWq-0FvNQ=QFaKUo6uUjt8+=5mfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:39:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXWou-0004Dh-SI
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab2KKMjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 07:39:11 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37366 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2KKMjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 07:39:10 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5417005obb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 04:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=19b7Rfx503flCr7s9Ew8wsywLfpzTZlmbaG0L1PB4Vg=;
        b=FotLiCiXLpP74h9Ncvy0aZ4TulEFm2UfWrpvBJM2a5wEpyxYtMJ3MF5NbI/wfSAlmR
         s9oRju0Z7yYE4ZyzmvFks9Z0paQUx3J1uhcBmDMZd9nmhwrb3lrRlnfHguHJMJSLt3C1
         VYnCI8cLTBJY6W3bjdQqEab1H69zj5s+5bjKeO3g2sSP80m416P5kYJwtmohsKKsSjN6
         AcUf7rc4WN72Gp7JQSe7GFqx/rgrECJG3volCBKd4ibfX/1XoVOzNIahGqsK91mFsaQn
         gEPGUv5jxNL8Xk5HVeJaVxpb2YYEZrNsXje929xt0D00WgtoZ5db6QVzw3bz0pjxAGWs
         WhFA==
Received: by 10.182.235.46 with SMTP id uj14mr12746604obc.40.1352637550371;
 Sun, 11 Nov 2012 04:39:10 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 04:39:10 -0800 (PST)
In-Reply-To: <CALkWK0kguFpA3ExSt7YKtugWq-0FvNQ=QFaKUo6uUjt8+=5mfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209347>

On Sun, Nov 11, 2012 at 11:41 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> test-hg.sh forgets to set ui.username, which is required for `hg
> commit`.  Fix this.

Hmm, I get 'no username found, using 'felipec@nysa' instead', but
everything works fine.

Doesn't hurt to do that though.

Cheers.

-- 
Felipe Contreras
