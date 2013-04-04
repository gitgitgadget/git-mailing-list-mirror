From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 01:34:06 +0530
Message-ID: <CALkWK0n0uKTsPv2d20ESVd5OV5yfK5V1HecGWePYU=UFw5Jkfg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <CALkWK0mQt7cE0zUECDF4ZC2-9Q+pEL=XGPdaOksyWzae2_W1CA@mail.gmail.com> <CA+55aFw+2wgUufJn7BcXACBQqywAGBAcZWS6N_UV8UA91G447Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:05:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqPM-0007La-DR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763582Ab3DDUEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:04:47 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41691 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762614Ab3DDUEr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:04:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so3508883iec.33
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=n/I1ORVw1tP3/XlOR6xf9/YogD11vKT94kEl/I0SJlo=;
        b=S3xcZG1wQ5ghFFjNzC+AIBHN+xjLlHtnxv+wY3Snl5MJVqoJP+gGTc0ugaeAmBOF0I
         78jLe1knbBAuFlGOSbl5QO2qjRbGhkEDilPOvGNqddhigmzDOdODujRmqWCIg2cLToxH
         6FemL6JIaYsf4x84WYHY0cdUxl7V+qj2wuecnReH0ocJluoSYYPAWCw2NsnXnh8lc4FE
         IeMq9Cr+y9swT4u6g0fu6kMgO05qdPiMriafI1g33ytUsWeWdEFCmtVxja59gIj5ouAA
         EBRR29Wkzbl9OF2v+9QDsksoEPqzWQc/jaBMAlzNGasA93PRP9PSrUPs/OPjAs1SzKSx
         FjMQ==
X-Received: by 10.42.204.79 with SMTP id fl15mr3910419icb.57.1365105886820;
 Thu, 04 Apr 2013 13:04:46 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 4 Apr 2013 13:04:06 -0700 (PDT)
In-Reply-To: <CA+55aFw+2wgUufJn7BcXACBQqywAGBAcZWS6N_UV8UA91G447Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220085>

Linus Torvalds wrote:
> Or you could also just edit and carry a dirty .gitmodules around for
> your personal use-case.

I'm sorry, but a dirty worktree is unnecessarily painful to work with.
 I don't think anyone objects to committing, if they can understand
basic rebase.
