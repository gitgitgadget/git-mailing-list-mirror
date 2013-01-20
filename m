From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 15:17:53 -0600
Message-ID: <CAEUsAPbDTUXhz2BoDOwKCjcLS6BQA=jZ6DME4ZDfTDXRL=ZMqA@mail.gmail.com>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
	<20130120125838.GK31172@serenity.lan>
	<CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
	<20130120152857.GM31172@serenity.lan>
	<7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
	<20130120192412.GA7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:18:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx2HQ-00072C-R1
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 22:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab3ATVR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 16:17:56 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:64748 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab3ATVRz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 16:17:55 -0500
Received: by mail-lb0-f175.google.com with SMTP id n3so3577982lbo.6
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=b6qkCOqC0fMq9YAvcEYyA3jLSn/WTZgCzT48j/wZ4dU=;
        b=vMCoN4jsastKbs562KkoUzYoC7Ae4ujeBVPqhxCqk/0q7X6XqBnL7SAjJlhZB/L/yv
         uBEy4OnTjF5oFJLndGT5bIcrtEg72Apk0CPv94EouCSHa1CC+GtiilQMuYX22Op3dLtO
         w0VXZBUKsfr7pDYHeBoxz0CyYMGuICmOlKbIQ3KoG1yySdX2u1m2ABRKeixadiCfgws8
         G/sb/y4NH6NypC5lANxUGukHQBUKhORmJ2pyqbLnooY7r6hzMCR4XUIufQYx5ZPtfPPA
         mK2qH/Uph8Zq3mhGfpcBl6+keYLS+1zDh29bCM4+qnjwcKiH2JMo/Cf7/VKDtr9eUYi4
         F0cg==
X-Received: by 10.152.144.103 with SMTP id sl7mr15154325lab.23.1358716673669;
 Sun, 20 Jan 2013 13:17:53 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Sun, 20 Jan 2013 13:17:53 -0800 (PST)
In-Reply-To: <20130120192412.GA7498@serenity.lan>
X-Google-Sender-Auth: lM_TkKOTuAgsdKXVMpZtvmClfCU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214051>

On Sun, Jan 20, 2013 at 1:24 PM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Jan 20, 2013 at 10:57:50AM -0800, Junio C Hamano wrote:
>> This is not a noise, though.
>>
>> Chris, how would we want to proceed?  I'd prefer at some point to
>> see cvsimport-3 to be in sync when the one patched and tested in
>> Eric's repository is proven enough.  Will Eric be the gatekeeper, or
>> will you be sending patches this way as well?
>
> In this case the patch was to the C portion of cvsps, not the Python
> cvs-import, so not relevant for this particular case.

Oh, I think I misunderstood the question.  The only time I passed a
patch specifically for git-cvsimport.py directly to Eric was before
the his patch was in Junio's repository.  Unless I'm mistaken, only
the second patch Eric sent was actually imported.  Subsequent to this
I would have submitted any patches for git-cvsimport.py directly to
the git list.  I just didn't have any--cvsps had several problems that
needed to be worked out before it made sense to look at the importer.

In other words, I don't think Eric should be a gatekeeper of this code.

Chris
