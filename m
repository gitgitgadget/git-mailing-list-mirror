From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] use cache for function names in hunk headers
Date: Mon, 20 Sep 2010 21:15:29 +0200
Message-ID: <AANLkTi==Bcc8kkCXX1qN1QnpMF7U7DRhUkdwaStmkQ66@mail.gmail.com>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
 <1284890369-4136-4-git-send-email-drizzd@aon.at> <AANLkTikArADX8XviB99VtkkmKmVbs9jHPHw9PNSmiOc3@mail.gmail.com>
 <20100920173605.GA13057@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 20 21:15:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxlqF-000696-EH
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 21:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198Ab0ITTPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 15:15:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62651 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172Ab0ITTPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 15:15:49 -0400
Received: by gwj17 with SMTP id 17so1406673gwj.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=1iwl7S+RJptZo4MUA2a2K6Wx/zDNPha2e+eL3j61kpk=;
        b=upM3Q3+ma8Z0urZfKSweX/2MKCrzmAun5/1NRA3Qpi04pQO7RouM0eohq7+vSlMAq4
         V7eLpwcWGye8lE+H5R9C8CWAaDRIEKmJAFdFE8dOpRIKt6MzFzeQ2wIBXHOxI+09zSQ4
         L2qV34jpvzec9JvkYckGu0aeZ4iSR/UoMrkOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NBYDA880uwRBN3OPBMzYciBz5BtFFUJ67Ce6H3LpyfqbrqwF0DiTzc1hOGkW+wRaqr
         R2PcPHh0u1FqfwBeQJerVnSiLnb63Tyfm73ACRT7GVuaspI2jLeWbBTfcxkADNCwNyf3
         TS/7CssR/oSxabjCjDdHCUbFVbFQS5qPexgpg=
Received: by 10.150.12.10 with SMTP id 10mr8270730ybl.30.1285010149093; Mon,
 20 Sep 2010 12:15:49 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Mon, 20 Sep 2010 12:15:29 -0700 (PDT)
In-Reply-To: <20100920173605.GA13057@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156651>

Heya,

On Mon, Sep 20, 2010 at 19:36, Clemens Buchacher <drizzd@aon.at> wrote:
> The test creates a file with 50000 lines and a one-line change
> every 10 lines, i.e., about 5000 hunks. Since none of the lines
> matches a function definition, previous to this optimization, the
> file was searched 5000 times.

Ah, that makes sense, please add (something like) that to the commit message :).

-- 
Cheers,

Sverre Rabbelier
