From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/5] Dangling commas in enum is not portable (resend)
Date: Fri, 12 Mar 2010 11:18:47 +0200
Message-ID: <94a0d4531003120118l2a5c69ebh7e62ea8630f94738@mail.gmail.com>
References: <20100311163235.GC7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 10:18:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq11G-0007y1-G4
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 10:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab0CLJSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 04:18:51 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57299 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043Ab0CLJSt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 04:18:49 -0500
Received: by gyg8 with SMTP id 8so414494gyg.19
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 01:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ehBF3ZKtPw1RAjnSPjOE9KW4/Ps9WkEyZJ5m+1TIpKY=;
        b=LruLPttsgZxmYUzTTb2Ve+f3VkiwrUcXeDBMy7VBE4GMTw0TyO4tsSH+6tKm4vvRAw
         xoLFLIHrPqbR1oMUaxLHYTPV6Tix2dMJRwd0XnqD6fZvidK8y/wwtW41ujr4uLwcmWbP
         kQV8PfRz1v/QFHuI8OBAj0vOPywY/pXYoBmDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LrgKSAG9ILxxhprkfzweL/On9NxsFMrTAtXmGdTCFW0OOVPWfI0vhAu7w8KmNhRVmc
         8p1mBZviaVvEJsb10oSVkqL3mxnl1E92qUX5M92rVErF+FJqFGuoDdGDIjiRH5r7Dt03
         AE1hVw/zDsMp6VUIAzTNVLM+eOM5zRPPRX/zM=
Received: by 10.231.169.145 with SMTP id z17mr870023iby.83.1268385527833; Fri, 
	12 Mar 2010 01:18:47 -0800 (PST)
In-Reply-To: <20100311163235.GC7877@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142035>

On Thu, Mar 11, 2010 at 6:32 PM, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:
> Unfortunately there are a still a lot of vendor compilers that choke
> when the last entry in an enum has a dangling comma (irix is one, and
> I can get you a list of which of our particular platforms exhibit this
> problem).

I would appreciate that list if it's not much trouble.

-- 
Felipe Contreras
