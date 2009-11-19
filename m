From: Tim Visher <tim.visher@gmail.com>
Subject: Using `git tag -l` to get non-matching tags
Date: Thu, 19 Nov 2009 12:49:13 -0500
Message-ID: <c115fd3c0911190949x2f32d1cbw26f3260f12d43a6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 19 18:49:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBB8a-0007y2-2m
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 18:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbZKSRtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 12:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbZKSRtb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 12:49:31 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:43000 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbZKSRt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 12:49:29 -0500
Received: by yxe17 with SMTP id 17so2193278yxe.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=W8WhCDo3e8MrqC7oNLN8/HmDb0EyaNOCPgdGTeJCSCQ=;
        b=FASWI5Wzea6zdbvYOeGboDkHVdub5bTzqp2qd76G4zqFA1TuVxdWEOzqplFB0W3tI/
         UeQekw/7W/xxzGey5kRYAzX/egbHd8kP+IvBrM8lZ7wcfZCiDSIi2xEDRvF8fcd+SB9t
         DA7gChzCfQYF6X/MwRTd2WnQmxVE8zQe86Bzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=GaZkHl8sDqonZnRVF3FN/cSABXQXvr6k+iZr8wR9PARUikjJSTs3kooyfhNPoARDo+
         Fq2xN0PDiAOEM9r6UhxOGbm3QX3FvmmGmZzI1tyjUQBDANrK4zk1GfNKoceQgR4c0/Sb
         AxfeZSmziJADPJoI4XK0gbuNcuUR6hedaQKC4=
Received: by 10.101.18.10 with SMTP id v10mr540555ani.148.1258652973215; Thu, 
	19 Nov 2009 09:49:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133238>

Hello Everyone,

I'm trying to use `git tag -l` to get non-matching tags.  I can't find
anywhere in the documentation describing what is allowed in the tag
pattern.  Brief testing leads me to believe that it's only basic bash
like pattern support.

Thoughts?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
