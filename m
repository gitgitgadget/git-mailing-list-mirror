From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] t1509: update prepare script to be able to run t1509 in
 chroot again
Date: Fri, 3 Apr 2015 19:14:18 +0700
Message-ID: <CACsJy8D3Rk51JVvwivj8BwTjprhYC7aEbfY4vF+4Mo-cn5taLw@mail.gmail.com>
References: <20150331191420.GE22844@google.com> <1428055737-8943-1-git-send-email-pclouds@gmail.com>
 <20150403120109.GB22170@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 14:14:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye0Uv-0008Tw-TK
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 14:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbbDCMOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 08:14:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33545 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbbDCMOt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 08:14:49 -0400
Received: by iebmp1 with SMTP id mp1so82729584ieb.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3EIJkk3hJpIURx75ZYC2payfk0zP0VPySf3MSQTgXLo=;
        b=wNYDcedT958PdmlOBwyyxigaz9IX/RvFwWJUnBrDxzMgVmmLssCCiG3IglOYaw4qyr
         xvLe7O43ogKbzq50KmBJEf78t5CZwNQOH6SRmdpPz17jwH5nRoNR+54Z78uvE4HHPIy/
         QXijbIX2Hy/mrSbJBuV/EOzW+3oI5XHsiGFiU+bk3SXRhGYHE38V65lbosFxo4h23/kG
         oiXsAZesxqQ2tycwW9wd+2oXKvM4xLkEa1llX+vYGTr0Iqeb87YcniqkGjx4O11G021X
         jHs5v0aG/SF3vMfKbl1/PCa/TtE2JfcTS50tdnI6oftWgOEAzEzLKxhdcm+kKrK4URJH
         /oSg==
X-Received: by 10.50.79.197 with SMTP id l5mr27850913igx.39.1428063288470;
 Fri, 03 Apr 2015 05:14:48 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Fri, 3 Apr 2015 05:14:18 -0700 (PDT)
In-Reply-To: <20150403120109.GB22170@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266705>

On Fri, Apr 3, 2015 at 7:01 PM, Jeff King <peff@peff.net> wrote:
> Aside from the nits above, I did get it to run t1509 with this. I can't
> say I'm incredibly excited about the whole thing, if only because it is
> clear that nobody is going to run it regularly (so regressions will
> likely go unnoticed, which is the whole point of the test script).  But
> perhaps it is better than nothing, and it is not hurting anyone to sit
> there and bitrot again. ;)

To be honest, I didn't run it often in the last 5 years. The code it
protects seems not broken during this time and probably so for a
foreseeable future. So I don't mind if you just kill t1509 and related
scripts.
-- 
Duy
