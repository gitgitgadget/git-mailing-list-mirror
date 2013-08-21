From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Git access to Bzr repository fails for enwc
Date: Wed, 21 Aug 2013 15:16:49 -0500
Message-ID: <CAMP44s0zMbgt8snc=HkDqYHCWGZ3b4_oFZs64K48RjoXVR+1Tw@mail.gmail.com>
References: <jwvbo4ygbo8.fsf-monnier+emacs@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Wed Aug 21 22:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCEpr-0001Vm-7O
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab3HUUQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:16:51 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58599 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab3HUUQu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:16:50 -0400
Received: by mail-lb0-f174.google.com with SMTP id w20so997214lbh.33
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DWBCfBRk2+ZT9iGvp+gJd5ErN1ZsYpZsuouzmIK97Qk=;
        b=Nxd8FLE0dBr8UQFBX5amOddZ19zIN2SaY7yShMtBxbkPWrnN8q3XW9VzBA2lfzcRb7
         8LCJSL5YrZ8RnhWLxxJH/rNbw7M6X8yyEgjmsvtuCnNfrAqVmJklRUYdfyNM7AilmCu/
         MYyzP0xawNR/o/I0mgKfxDK3OYkLxlyBS2TT19tV96ATmMSH3XBt7twaqfJoH66+bFGs
         pB2+UQd+4sl0lafXi3Xk1nICmcwOuB5m5MPK2tydZNlHf6RLo6RD0DvvaHSA/JZ4V3Xo
         GGauSoq2FXJu+8Ond+HftrKV81+w5wIQhgSXnKTYZ0fV6cU3Co9beAnZTuT20IC8BUhL
         1clw==
X-Received: by 10.152.37.103 with SMTP id x7mr7352857laj.28.1377116209404;
 Wed, 21 Aug 2013 13:16:49 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 21 Aug 2013 13:16:49 -0700 (PDT)
In-Reply-To: <jwvbo4ygbo8.fsf-monnier+emacs@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232724>

On Thu, Aug 15, 2013 at 11:31 AM, Stefan Monnier
<monnier@iro.umontreal.ca> wrote:
> I've had good success recently with the git->bzr bridge, but the
> following still fails.  This is on Debian with the git from "unstable".

Which version are you using? The latest version works fine here:

https://github.com/felipec/git/blob/fc/master/git-remote-bzr.py

-- 
Felipe Contreras
