From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: import determinism
Date: Sun, 7 Nov 2010 21:46:57 +0100
Message-ID: <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com>
References: <20101107202535.GA18766@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 21:47:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFC8n-0005YG-6f
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 21:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab0KGUq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 15:46:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58357 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab0KGUq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 15:46:58 -0500
Received: by fxm16 with SMTP id 16so3585048fxm.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 12:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=woED8+Lyl646SR2hEZIfzpRYHPv6BHbsvIKpUQbcrAE=;
        b=BrwzqWOcxQShgGz7zj1gYtupprRWAJ6ADCqgvxLx/3f83RFSbV5OC9VhWmoiNdILwh
         r6brtAb2lA0lAw+MchCVwgj0ctqY+SizkJR8/SK1dul49pAvnZeduZzQnrZur2pBSyrp
         MxoYTp65ohOEZXOxYKl0mP35hl3TswFOu5gWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=szX+IIr793JTgLizn8YvYSRhgZA25amBk9NvTS2fnmiuhgpsr8fU7mwZ7RHOvpAMXp
         r7Lr/8EWvwCMIRRyXmovtqB3w60dRe+omG6d2j7wLwg/JUh7x+z5VhsWfOmqnSo9Fj4t
         /4KyFqMP8W4TPhFmtSakH3VfanzffnEhB33gg=
Received: by 10.223.79.2 with SMTP id n2mr3184585fak.133.1289162817072; Sun,
 07 Nov 2010 12:46:57 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Sun, 7 Nov 2010 12:46:57 -0800 (PST)
In-Reply-To: <20101107202535.GA18766@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160900>

On Sun, Nov 7, 2010 at 21:25, Enrico Weigelt <weigelt@metux.de> wrote:
> I'm curious on how deterministic the imports (git-cvsimport and
> git-svn) are. Suppose I close the same cvs repo twice (assuming
> no write access in between), are the resulting object SHA-1's
> the same ?

No, because the committer dates will be different.
