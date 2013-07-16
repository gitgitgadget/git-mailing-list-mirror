From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t3032 - make compatible with systems using \r\n as a
 line ending
Date: Tue, 16 Jul 2013 11:59:33 -0700
Message-ID: <20130716185933.GO14690@google.com>
References: <51E591FF.7030600@gmail.com>
 <1374000592-31845-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzATP-0004lb-Kj
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295Ab3GPS7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:59:39 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:57705 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932984Ab3GPS7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:59:38 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so1011755pbc.26
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ECEoDE+DSOyR8aRoR5WJazMsNECroOs0tBn7Rq88AcY=;
        b=zjCCAZrtOjUEyEz+IbpFJgR7GrXzYbY4wgtdMbWIoDIwFVy+HF3npbpS4HAeltTa57
         QL0QJmO+5FFFCaYKekp3hbmTWRsKvjkFXfc0ErKej8DzPLqDiAjQICqVwrri3DqqGi1K
         cqW/te/v45igc89K42LgWPY6ilwq0w7NUCA5P/sHFG1dKXK/OMAS2f0JJya8pXLUhgUB
         COI37LkWGKszPItmXlhoP5dNudgEMBoVsUbvqkUPNcYQg+4Rp6li0n3Ox21li9C/eXFN
         /Wkkn/KFanpaHBOv0QTszHpQU9ACn9fXepuemB232cDpFYIJdSNXrcf1ZwgF6qZnzf/Y
         fQMA==
X-Received: by 10.66.51.102 with SMTP id j6mr3991131pao.80.1374001177349;
        Tue, 16 Jul 2013 11:59:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vi8sm3324018pbc.31.2013.07.16.11.59.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:59:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374000592-31845-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230577>

Mark Levedahl wrote:

> Subtests 6, 7, and 9 rely test that merge-recursive correctly
> ignores whitespace when so directed. Change the particular whitespace
> sequences to be ones that are not known line endings so the whitespace
> is not changed when being extracted by line oriented grep.

merge-recursive needs to be able to deal with \r at EOL, too, so if at
all possible I would prefer to see the test fixed to pass on Cygwin
some other way.

Thanks.
