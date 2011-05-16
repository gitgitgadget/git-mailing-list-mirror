From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv3 6/9] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Mon, 16 May 2011 15:09:34 -0700
Message-ID: <BANLkTimge=rPe6K3rYRqYDGQTN_wbi3a2A@mail.gmail.com>
References: <201105151942.29219.johan@herland.net> <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-7-git-send-email-johan@herland.net> <7vaaenm957.fsf@alter.siamese.dyndns.org>
 <BANLkTimUWHiUdxbBfvvcomqmzQxLPhUsZA@mail.gmail.com> <7vhb8ujo4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:10:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM5zZ-00016a-W9
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 00:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab1EPWKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 18:10:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50814 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321Ab1EPWKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 18:10:14 -0400
Received: by qwk3 with SMTP id 3so2512636qwk.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OFFgapG8k9oraoGp1+k4WJHBRcIQd3v3TA0aeLU02do=;
        b=LeuZGDOxmLOTBsNrVdwn2lyKY+cXPLiPc18q3DoPz6KJn8KBxj4kOUg4DXfz4eoOpy
         7dSXR0NzgBh1bhCzWbMRGCQH1iHM6G6PmUyhe2WeCslRW2AbgkIGeFMq1x0Z0Wp4XFez
         w/jx96b2VXIaQFdFAbMl9mrOP23QxKhOWWV4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=E4BgR/XpJFPz7Qqowuqr3KdXNty6mXdYjpdjILQQp7BWG4W/hXEw6FdBG1iLc8LFI5
         ICfyZgo8Z4kFVbIr3zb+w3f8TCpZqU+0D3V9pwPftSDOdNChkmdSaVYbXqsPfxKCtNHw
         hk77oKiaehvXkVrmQIVCU6uDkWj0G6NgyYPuQ=
Received: by 10.229.48.74 with SMTP id q10mr3758732qcf.141.1305583814171; Mon,
 16 May 2011 15:10:14 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Mon, 16 May 2011 15:09:34 -0700 (PDT)
In-Reply-To: <7vhb8ujo4e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173769>

Heya,

On Mon, May 16, 2011 at 15:07, Junio C Hamano <gitster@pobox.com> wrote:
> The old clients treat it as SP separted list, e.g. "featurea featureb featureb",
> from the beginning of how capabilities[] code was writte, so I do not see
> a point. I would expect an arbitrary string values would be encased in
> something like base64, base85 or hex.

Right, that's my point, do we want to leave it up to each individual
option to decide what encoding to use?

-- 
Cheers,

Sverre Rabbelier
