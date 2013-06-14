From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 19:22:46 +0530
Message-ID: <CALkWK0kOJTVOC01_uygdSRaAPMBsSBo4+2WZUi4mqNt3F6D8LA@mail.gmail.com>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
 <20130614131629.GA1086@paksenarrion.iveqy.com> <CALkWK0nyNXsyzoTVz9vE5c5FP5k-KnPpzW2LryuCtmLP4WLXZA@mail.gmail.com>
 <20130614134833.GB1086@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:53:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnURW-0002gj-EK
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab3FNNx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:53:27 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:57315 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab3FNNx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:53:26 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so1438537ieb.24
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rgkX1TjrBZgN0tb7Cdi/UoP/sugnH4WgjrKac/lRQzY=;
        b=bFOMqzaTpfUoMxweMpAAU7A70wmytIRKXoSNdCr4z39pJJfUAR2NcZF4EjwkqljcGb
         +aqPLfnewbVB1hlZT1aMYmQ35wQ6z1DU9U+dAs7iDeqaTrytTC4rydXvP4jufqmlYIn3
         Fe+Y2Ag8YbEUUKB5C8DGs5undyqqcDCvxm5xY0JqaJg4NqRjCdNleNAPrTB1KjQ5pwvC
         QRgKl3kLI458XYZIrtJET2ltkFSd1xo2eZz9xD421pBPYCgoFwWRdN978UgQXgkSmhCq
         CcvgfJZX5WPa+cKtp5LMAn7nBjA6PRZvJc7wuMZfXNmEcuSe0L2zawyvF6tDBkYNUeeY
         2GKg==
X-Received: by 10.50.154.106 with SMTP id vn10mr1099928igb.0.1371218006572;
 Fri, 14 Jun 2013 06:53:26 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 06:52:46 -0700 (PDT)
In-Reply-To: <20130614134833.GB1086@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227864>

Fredrik Gustafsson wrote:
> git format-patch always creates a new directory like:
> .git/outgoing/[patchname]<FROM commit short sha1>...<TO commit short sha1>
> and possible runs a custom command afterwards. Like cd to the patch
> directory, open the cover-letter in your editor etc.
>
> git send-email without patches specified gives you a list of
> patch-series from .git/outgoing to choose from with the latest generated
> patchserie already selected.

Excellent.  I like the idea.  Let's see what the others have to say.
