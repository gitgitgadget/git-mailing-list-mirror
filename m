From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: Remove all files except a few files, using filter-branch
Date: Wed, 19 Sep 2012 00:25:23 +0900
Message-ID: <CAFT+Tg_UbG8C9o2E5P1E2a9GXgLhn2fmE8sMA4un0Kai2HrOeg@mail.gmail.com>
References: <CAFT+Tg_ipyPgNQxx8XsXySzmA3YM3mKe1gB5GyTNqN++gdphnQ@mail.gmail.com>
	<m24nmxkibw.fsf@igel.home>
	<CAFT+Tg-4q0mzD6rdY74WBP-0OM_SaZ_wkCAn+Gz2_eDte2a4Nw@mail.gmail.com>
	<50588ED7.4090501@viscovery.net>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:25:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDzg5-0002UU-1F
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 17:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab2IRPZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 11:25:24 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37254 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab2IRPZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 11:25:24 -0400
Received: by oago6 with SMTP id o6so6174724oag.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DW9s4PNzxAYG8JzvLxvH4RyznEbB8bpotxpAkkgM6Ls=;
        b=l1x+lElSEvXBtY2KpXP9ppbEMk61t2lTf+SiOEpecloAj1RUsp0WIjV0Cf9kolp7oX
         p0XQdLIgoaEgsiRnSqWU7POHgV0VLR5D0YDhrZ/DuI+rFEZp5pg77DhQsbgaAzTaNyg6
         P8n6EA4pN6hrXfHu7YLzLoZKmLy5xC5YtUHB53EMhl96N+P49TPQZIlZh43YzmmiBGwq
         T2XlMLkZmyJTjy5mPzWrrueSLj89BQB9kIT4DVs3mLXQgsHuAahfuajkppfnm8BWKMhO
         rBqn2xPne2xDf6qyhxibjq8UbRUSw+ijDCLqzMi2hwHkjnKn6OshRn9e0Gr5alvdo2Vc
         n5aA==
Received: by 10.60.0.169 with SMTP id 9mr234233oef.94.1347981923368; Tue, 18
 Sep 2012 08:25:23 -0700 (PDT)
Received: by 10.182.41.97 with HTTP; Tue, 18 Sep 2012 08:25:23 -0700 (PDT)
In-Reply-To: <50588ED7.4090501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205835>

> I think it should be '... && git reset -q $GIT_COMMIT -- filename'

It works! Thanks to Hannes and Andreas!

On Wed, Sep 19, 2012 at 12:10 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 9/18/2012 17:01, schrieb Yi, EungJun:
>>> --index-filter "git rm --cached -qr -- . && git reset -q -- filename"
>>
>> Hmm... I tried as you said, but it seems to lose history.
>
> I think it should be '... && git reset -q $GIT_COMMIT -- filename'
>
> -- Hannes
