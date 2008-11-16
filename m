From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git rev-list ordering
Date: Sun, 16 Nov 2008 02:27:51 +0100
Message-ID: <bd6139dc0811151727k605a3575hf409fed32a3a4baf@mail.gmail.com>
References: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ian Hilt" <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 02:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1WSC-000601-7s
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 02:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbYKPB1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 20:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYKPB1x
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 20:27:53 -0500
Received: from hs-out-0708.google.com ([64.233.178.240]:51068 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbYKPB1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 20:27:52 -0500
Received: by hs-out-0708.google.com with SMTP id 4so882672hsl.5
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 17:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FzzRB4Xexds4lRkwKUEfVuVaTH+C944v+o6Y8f9C92U=;
        b=X9l5zYE4n4cyhkbzMQ7yeOhvMRjKcqOQeHBM5BXTuT/GKuYJb12ov5s+2Cle/i1SfT
         1VZsSrmhS3CUfRIwhU4w/5AJeMN4xdvYErE0w8qIOzxHjWJwVYyN7rQ5YMbephw49gkc
         dLjV7Mi0QexhB9zv4EJma0m5WrjJohEhDYOoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=qrz+5Cke94J7+r9ugCLemIn/hx5fu97PadGfSoWewRxH1jbeN/pAsZQ7GCOTHa6fIV
         aX1CUf8gEsMfqimCSH2fiRnwyF3hzHFd8JkVoaD61bIHKU6ce8zZpDaXPzb8rS7YcqPt
         7eovwr70n5d9/85frQUi+gBbXvlgmNH3v9b/o=
Received: by 10.150.12.5 with SMTP id 5mr4905401ybl.124.1226798871409;
        Sat, 15 Nov 2008 17:27:51 -0800 (PST)
Received: by 10.150.149.14 with HTTP; Sat, 15 Nov 2008 17:27:51 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101108>

On Sun, Nov 16, 2008 at 01:44, Ian Hilt <ian.hilt@gmx.com> wrote:
> Why is it that this command,
>
>    git rev-list --reverse --max-count=1 <branch>
>
> results in the same SHA1 as,
>
>    git rev-list --max-count=1 <branch>
>
> So far, the documentation and the mailing list archives haven't helped.

The --reverse is applied after the --max-count, so you are seeing the
reverse of one commit ;). For comparison, have a look at:

$ git rev-list --reverse --max-count=2

-- 
Cheers,

Sverre Rabbelier
