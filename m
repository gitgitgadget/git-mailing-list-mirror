From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] gitremote-helpers(1): clarify refspec behaviour
Date: Sat, 6 Apr 2013 11:15:14 -0700
Message-ID: <CAGdFq_jrYu23yyQyDEDD=72f7UrhWBL0bnmZ7XLtBM=F4Hwzug@mail.gmail.com>
References: <505914600ac7f4afc26f8b29fbece26156c87519.1365272021.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:31:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOXei-0000gT-4X
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 20:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab3DFSPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 14:15:55 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:44489 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab3DFSPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 14:15:54 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so5555266iee.11
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Bf5wMhVuFa+ujCX4lvzqd5LYI1h/NxEC71wyYTqU/AM=;
        b=1D1vlxEudwaYi13LwK7MUSL2bqnYk3/gwnt/yT3lr7DHXFDJsPR2eTMuFAF3j0CPir
         zYhJfWAT8ZEN3FHgoBtCSymu60SiSgOg0gqZxOFhcOVlpirBmHnn+QAuNWWYr99qSKq+
         iuTo8ZRMwgHKCBLY6bGuk7nGPK3kPznbOsKdi2rJAQ/Zc5LxGQ4c7Tc1FbYAEeAZm7FU
         tqaN7O+9YnEt15jirS9dPa0hX3Z0lPIXx6tz6t0Q7xIiAiWJJrxuTT31TqJg85o+/RVB
         /dHbGnpSb2jJIAzZXJhiBk+CRaCM+YqBCIxdhvlI7ZHEzovM2i3EeRrzqm9Y48J7d495
         VfVg==
X-Received: by 10.50.219.168 with SMTP id pp8mr2535985igc.57.1365272154439;
 Sat, 06 Apr 2013 11:15:54 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Sat, 6 Apr 2013 11:15:14 -0700 (PDT)
In-Reply-To: <505914600ac7f4afc26f8b29fbece26156c87519.1365272021.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220265>

In Sat, Apr 6, 2013 at 11:13 AM, John Keeping <john@keeping.me.uk> wrote:
> The documentation says that "If no 'refspec' capability is advertised,
> there is an implied `refspec *:*`" but this is only the case for the
> "import" command.
>
> Since there is a comment in transport-helper.c indicating that this
> default is for historical reasons, change the documentation to clarify
> that a refspec should always be specified.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

--
Cheers,

Sverre Rabbelier
