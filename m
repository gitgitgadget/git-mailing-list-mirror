From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 13:02:25 +0200
Message-ID: <CABPQNSZyaW13pigA8eEnGo-7+-suVfDdvsGLj_04xTgaKfg4eg@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
 <CAGK7Mr62y4-fTFzuLGmuOd+zLkk+h1Q-rCb30TW3dWd8VLhhAw@mail.gmail.com>
 <CAH3AnrppdYOC_Z4PWnzNLWXPSSQMBvHd9KPnQyAt40=FTn2dFg@mail.gmail.com>
 <CAGK7Mr5byhUOZ1vZTOMWWBVs4rXdE8RH+SS2ppz2QP1e-MiG0w@mail.gmail.com>
 <CAH3AnromoeSc=34H14j92kFg3FjWbdg+XuZcd72Aq04zScvD8g@mail.gmail.com> <CAH3AnrpsG_XL1OpAtwu_rrMX8t5TRVGsp8yD14na1ktvKTDHDw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:03:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgwDT-0002vc-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 13:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab2FSLDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 07:03:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45700 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab2FSLDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 07:03:07 -0400
Received: by dady13 with SMTP id y13so8243482dad.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Dri+nCKWBiArMaB5cSJ9bn64mhMeKYIdEzOk3YulspA=;
        b=JO1qsWjOF9Uwl+LYCs5thP17heVTiFkF7rS+sUPZ43c88viSzhp0t4BQEdecuPuMkM
         AhUXEVLn2cfgAIVlCSu+Vc/z6uOEiKkE7twHv1ejslb9IgtRfg20cVv/D1Xgtd7vojNz
         zrrfc5TMcD9m4HRkWONjjdvSos7C4K4z+4LVZRJ8CaD5k+q5HN90WsF3B/I/ESevjVVn
         ADlfFAP8ysMcADUaaeiOPVjpQZffwnZPgYm86ZVuXljT8zuIQipZrPZDmEdVvM+J5VV7
         pdwfkJRZr+2twOj7iG8vhkzIvhWc1JdcKgiJqNtqKsUzWFoaUqadRGr6dlHVv8fwYW8M
         ypnw==
Received: by 10.68.194.105 with SMTP id hv9mr2868609pbc.126.1340103786095;
 Tue, 19 Jun 2012 04:03:06 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 19 Jun 2012 04:02:25 -0700 (PDT)
In-Reply-To: <CAH3AnrpsG_XL1OpAtwu_rrMX8t5TRVGsp8yD14na1ktvKTDHDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200195>

On Tue, Jun 19, 2012 at 11:57 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Would I be correct in assuming that Git For Windows doesn't support
> "git svn" because of the dependency on a perl implementation that is
> available with msysgit but not (perhaps?) "Git For Windows"? Or is
> this an incorrect assumption?

That's an incorrect assumption. Git for Windows ships with perl.
