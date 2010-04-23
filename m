From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Problems with file name case on Windows.
Date: Fri, 23 Apr 2010 11:48:16 +0800
Message-ID: <g2lbe6fef0d1004222048m5527be2fw8283d080c82733e8@mail.gmail.com>
References: <1271969657620-4947131.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: martinvz <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 05:48:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O59sS-0006sf-8O
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 05:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0DWDsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 23:48:21 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:44365 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0DWDsR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 23:48:17 -0400
Received: by ywh32 with SMTP id 32so5357703ywh.33
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 20:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=IZwNGxEh5sqvWJ2mBC0ytxUPqvjgm89UXUq2WbnQjHk=;
        b=ZkiQP6Kw9Xx+KyIOXKWQvDEqtu2f920vMpS5Cv5BXE0oLhpzudvVqqXk6k2pC4E5tS
         bVotHIpwdwFFSusPdQFHJTKBiz66KCeHfSfMN7EBAAwfjH5scgGrEYw00BchPjvdakrZ
         yDEIhrWD9CVDupTses3R3nq3dfMsoC5ZdkvWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ROHUGS9jovfibAxTUEenFyTZUuNRtRYzBaD1DcjZdCL7U/OmbSGkYE/E2CDll5sx66
         j5fzNyzToRdv+DsMDeKVgczHQA0zr0QrgseQOXNsK3/Octd3pQFWqh39oZ1B1veHYTUz
         eyFpeI6qZQPppge3ekk28tKzOORRAZdovn6iw=
Received: by 10.231.36.201 with HTTP; Thu, 22 Apr 2010 20:48:16 -0700 (PDT)
In-Reply-To: <1271969657620-4947131.post@n2.nabble.com>
Received: by 10.101.184.14 with SMTP id l14mr23695960anp.108.1271994496617; 
	Thu, 22 Apr 2010 20:48:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145583>

Hi,

On Fri, Apr 23, 2010 at 4:54 AM, martinvz
<martin.von.zweigbergk@gmail.com> wrote:
> git init; git config core.ignorecase false; touch a; git add a; git commit
> -m a; mv a A; git add -A; git commit -m A

Have you tried

  git mv a A; git commit -m A

instead of

  mv a A; git add -A; git commit -m A

?

-- 
Cheers,
Ray Chuan
