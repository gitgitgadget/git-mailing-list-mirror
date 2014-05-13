From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Tue, 13 May 2014 13:25:44 -0500
Message-ID: <537263a8d872d_7774d392f83b@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <CAAhxitED0iV+Pcird2kZzt3nSnr83+isBDZF2Czmh0LzNzQf8g@mail.gmail.com>
 <53725eeb1cab5_7774d392f87c@nysa.notmuch>
 <CACPiFCLOGc-6M-boSonGHuxKR6OaoosoEiybc=xfuT73C7dS6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 20:36:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHZG-0002a3-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbaEMSgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:36:43 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62445 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbaEMSgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:36:42 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so871198obc.17
        for <git@vger.kernel.org>; Tue, 13 May 2014 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=frVxEgryA/7eoOfGc9ux9IHPeWcAaCBhzb5HCx4+bpU=;
        b=I3V2xOtHOXGlb+KcGUKoURrkxppUAna+JuxirH3HDmOVon8nWClH4QDttz4a5tVpTQ
         fP8pVQIaZ3R3D9xo7SuCJA90+phjdwls9yTw4B2o2P8w8dCglMwImCz0WBMlGRlxF7wH
         Iur+fsOUkRvPy0iTwXCQsP31MCtIwJ9ZTi89HepdE5IMDOv7npG4+7p9jtMS77oJ2++q
         SvSMmKYSktrFgRUcmd7ZxHnD/h4Kh3SsYaGOizQMUG5hbFOumXOKvOMVv3pvXJ3C94Gp
         qBfLA537KVumpv+VW9cSKMHlAhb+/4ylNdnrVozADsroRRhoobRniYvRsMUMf0Zfxh6x
         FtvQ==
X-Received: by 10.182.104.71 with SMTP id gc7mr43349560obb.34.1400006201663;
        Tue, 13 May 2014 11:36:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ml9sm62228421oeb.2.2014.05.13.11.36.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 11:36:41 -0700 (PDT)
In-Reply-To: <CACPiFCLOGc-6M-boSonGHuxKR6OaoosoEiybc=xfuT73C7dS6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248801>

Martin Langhoff wrote:
> On Tue, May 13, 2014 at 2:05 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > This tool doesn't even work anyway.
> 
> It doesn't? Bug report / more info please?

Show me that it does. The documentation is lacking, and there's no tests
at all.

So it's hard to say is anybody supposed to use this and verify that it
works, but I ran this from Jeff:

  tla register-archive http://www.atai.org/archarchives/atai@atai.org--public/
  tla my-default-archive atai@atai.org--public
  mkdir repo
  cd repo
  git archimport atai@atai.org--public

And the command threw hundreds of errors and the result seemed to miss
tons of commits.

Does it work?

-- 
Felipe Contreras
