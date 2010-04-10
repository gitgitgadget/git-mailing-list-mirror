From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 1/9] Generate unique ID for submodules created using 
	"git submodule add"
Date: Sat, 10 Apr 2010 20:41:20 +0200
Message-ID: <m2rfabb9a1e1004101141g3712cb1fl69bc3e0f8f91abf0@mail.gmail.com>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk> 
	<1270923830-11830-2-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Peter Collingbourne <peter@pcc.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 10 20:41:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fcs-0005Dn-KO
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab0DJSlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:41:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33480 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab0DJSlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:41:44 -0400
Received: by gyg13 with SMTP id 13so2199436gyg.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=+oUe8fgz7oXGJlEaRBKZBpfcyKJNqLPDboNcM2U6X8w=;
        b=kcZBuVfBGU3ZXlhOfLPrVGdV8cvBJ2ym1fKFaRA25yhZK8YwWacNB6BLM18Bgnukxi
         eiWN/baFFRTjK/MWLuJOKT/F/Y2M3Xc4aIBRIXPx8ER81+DY5qaRfryctYhD+P3zBtGL
         NVkRN1ymryYZ4P9ONq8l0gCh+Gsq9dJMOB22U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ieT0R6Hnn0h2Rtxqqaranmhpenuh8VnyOlVBB58/tJaaZje11cx3qsiUcXuKFb5Id9
         129IPHXvGJVitsquyS/CA6m9WcM1fgHugz1+kTT4yL4WaZXSWW/QdLk2eT+39moLfe6p
         2ExFvm/FjqQbDmKJrFpc2EL8LNMrg9r1+Sdmo=
Received: by 10.100.206.13 with HTTP; Sat, 10 Apr 2010 11:41:20 -0700 (PDT)
In-Reply-To: <1270923830-11830-2-git-send-email-peter@pcc.me.uk>
Received: by 10.101.202.17 with SMTP id e17mr3272153anq.73.1270924903504; Sat, 
	10 Apr 2010 11:41:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144574>

Heya,

On Sat, Apr 10, 2010 at 20:23, Peter Collingbourne <peter@pcc.me.uk> wrote:
> ---

I think this commit message would benefit from having an example of
such a ID in it. I think I understand the idea, but an example would
help me to verify that the idea I have is correct.

-- 
Cheers,

Sverre Rabbelier
