From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 0/2] ls-tree: exit with non-zero status on error
Date: Tue, 26 Jul 2011 08:05:13 +1000
Message-ID: <CAH3AnrrsWLTn7iCCrp29L9UJN1qbU5SX++6BidenJUQDyJEWNg@mail.gmail.com>
References: <1311631391-12842-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, schwab@linux-m68k.org,
	gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 00:05:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlTH7-0000Tj-3B
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 00:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab1GYWFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 18:05:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39632 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1GYWFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 18:05:14 -0400
Received: by vws1 with SMTP id 1so3301725vws.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O/+NlwhIqsqrqj8NZLYa6fG8tvYAu1+TyPc78tBr5Xo=;
        b=Y8dgLyQMkeu9sOT1uyaB3ofG8MB/OmfAZkkE0wekXCu2fvcnh7hQoPqu6aRhHiorwO
         clrj6Eh38Fk25i/F0vJbwmQndZjDcseVSlL744ztmbu6zZ0tqonXdayukC+5YwdXedip
         MM9rD2jlJ+LMJkVo6Jaegb+8ljjUAmKpDNovk=
Received: by 10.52.112.42 with SMTP id in10mr4795268vdb.106.1311631513187;
 Mon, 25 Jul 2011 15:05:13 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Mon, 25 Jul 2011 15:05:13 -0700 (PDT)
In-Reply-To: <1311631391-12842-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177828>

On Tue, Jul 26, 2011 at 8:03 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
>
> This patch uses the return code from read_tree_recursive instead.

Sorry, should be:

This change sets the exit code to 1, if the read_tree_recursive returns
non-zero and 0 otherwise.
