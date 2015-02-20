From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] --disassociate alias for --dissociate clone option
Date: Fri, 20 Feb 2015 17:01:13 -0500
Message-ID: <CAPig+cTGZohqPRL2OHcaF5bBwED-bhCsZJkp9g00uqJKWfObaA@mail.gmail.com>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Matt Whiteley <mattwhiteley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOvdP-00021C-1X
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 23:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbbBTWBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 17:01:15 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:54319 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbbBTWBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 17:01:14 -0500
Received: by mail-yk0-f175.google.com with SMTP id q200so8488666ykb.6
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 14:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Yc2hYV7GuA89M3pwJ2TgIhCRpZvTQwdx7P8pk2XxOXA=;
        b=SPofpNVVoORWUJgW7D6zPb37BVQ3kIcDxJp+QBFQ/sQSQ0OekmKMeFKMNAzzFBMDxD
         d6PG9IipYuQEk8gL5DL35Yg54e7q7+U7gAyLzU0mebo7SmyfM+HWz3CkZ44FAJ0ICwo2
         UCD4UW2wnKZ8BFvF7Mk24GHgSw/LcSuRPTsdFafQSJ9dnawnypmZtyqsyqW/uL6Wzad3
         L4JfLoQ3LhOllkcdDM6+P/Ol7feuU0jun/VVorARb6Nl7LF7wdJd0+4FE4ZPZlmn4f2i
         9fkHDY1hkq4BRcD9+Zs9HGlt2Ra8b8oB/oZrxiDrD5WGJ7Tgsb26G4/GSaJCHLWyaThz
         TK8A==
X-Received: by 10.236.45.106 with SMTP id o70mr8688546yhb.180.1424469673703;
 Fri, 20 Feb 2015 14:01:13 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 20 Feb 2015 14:01:13 -0800 (PST)
In-Reply-To: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
X-Google-Sender-Auth: XIx4Coh9jauC4GLKEUAvVQ3WdOY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264187>

On Fri, Feb 20, 2015 at 2:10 PM, Matt Whiteley <mattwhiteley@gmail.com> wrote:
> I find the new --dissociate option for clone very helpful but I have a
> hard time with the spelling. It seems reasonable to have an alias since
> one exists for --recursive.

You may be undermining your own argument for inclusion of a new
--dissociate option by citing the aliased "recursive" option.

git-clone's --recursive-submodules was added (see ccdd3da6) for
disambiguation long after --recursive; and not the other way around
with --recursive being more convenient or easier to remember or spell
than --recursive-submodules. The implication of ccdd3da6 is that
--recursive-submodules is favored over --recursive (and perhaps the
latter may some day be deprecated).
