From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Sun, 11 Apr 2010 19:34:13 +0200
Message-ID: <w2lfabb9a1e1004111034n1aec73f2h3cf5f1d8468b6036@mail.gmail.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> 
	<k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com> 
	<cb4ed5763e71bd84b4e80109923494ca@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:34:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O113R-0002kO-JT
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab0DKReh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 13:34:37 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:56844 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab0DKReg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 13:34:36 -0400
Received: by yxe1 with SMTP id 1so2165604yxe.33
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=4ltjDt8jFtgMZW9r48NkT7zqu2jWCpR5u32BSdumF/0=;
        b=VSpYEWUVIbqdt1az7CNW4GJn+AAet0BDV23OlO0wmI6XQc7q2Ixqoad6qyc9sy12mI
         5144kgHvg6+o2Kr+PooRHVWjimCA/BqsfKYLcXWfsJtevi8HJKCtSANK3IuaVL0AEBDx
         ymVWG4UOPhHVzhxmxifzrffolhOKqCYgEXgbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Vau0G0pjA70SST0m7+YneZa8aLYK/DVrUGSIbe195urHRGKL9cdauqFlM/nzgrecGI
         oMNNwcb5gr1uJkDRYK7BgtoqnnTWQ0OrDLa/qpbD07ZOK3NlTNx0UwTfsYKODotpEGiC
         u8Br8ROqdcCj42+aKcU41vcu8fFh9MGmSnEW4=
Received: by 10.100.206.13 with HTTP; Sun, 11 Apr 2010 10:34:13 -0700 (PDT)
In-Reply-To: <cb4ed5763e71bd84b4e80109923494ca@212.159.54.234>
Received: by 10.101.186.16 with SMTP id n16mr5200577anp.152.1271007275566; 
	Sun, 11 Apr 2010 10:34:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144663>

Heya,

On Sun, Apr 11, 2010 at 19:30, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> you'll have to tell me what you think.

The patch does look fairly simple, but I worry that not all commands
will be so simple, that is, they might not all have such an easy point
where you can hook in a different output method? Or am I seeing bears
where there are none?

-- 
Cheers,

Sverre Rabbelier
