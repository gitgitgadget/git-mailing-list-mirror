From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [ANN] git-arr 0.11
Date: Thu, 14 Mar 2013 22:42:30 +0800
Message-ID: <CAEY4ZpMWiShOxD=0R4aPSkVcmWoEBJnUepwxQ3Lw_=dh4V5jVA@mail.gmail.com>
References: <20130313234143.GD14686@blitiri.com.ar>
	<vpqppz22luj.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Alberto Bertogli <albertito@blitiri.com.ar>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 14 15:43:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG9N8-0006kc-O1
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 15:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab3CNOmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 10:42:39 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:51788 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266Ab3CNOmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 10:42:32 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so2561128lab.33
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vmlXGb+6X5Cz69VMPSHiK+Aryzc/oWCFz51494jXDTs=;
        b=FWwX1xHD3FOF2Jtc0hurMK4fFAKxHUbi9E0mkgS8xzmWisL5kxPkshNXco24l7sfRN
         mL2q4dqtzefO7Uk7YGLrU1WCQL27U7mRjr5F52JBaOYt91P3vrjFBIOCw3P8ckUzkuZs
         qCYAcgJ+cH3dOUnM2InqDe+29uRK0gE8nZFDOvNGyvLsoIZ1sz6V0jyto7nvwOkBLTPc
         2ItiY5XotcyqPMgBDojIL7XZ5JSUPVfAD0P1oBTfbofMB7aXsZwXxuFZjemd6tKO5Ts8
         jFO6hWmJQO6woNXA+CPPz+9bUPUVmCII/eV2nRfMUKWvyOSb7F+SCyqacFLKOqNcBXTS
         NUww==
X-Received: by 10.112.83.133 with SMTP id q5mr1251555lby.25.1363272150486;
 Thu, 14 Mar 2013 07:42:30 -0700 (PDT)
Received: by 10.112.117.103 with HTTP; Thu, 14 Mar 2013 07:42:30 -0700 (PDT)
In-Reply-To: <vpqppz22luj.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218140>

On Thu, Mar 14, 2013 at 8:43 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Can it run incrementally? I mean, if you have launched it for one
> revision, does re-running it on the next revision regenerate the whole
> set of pages, or does it only generate new pages?

>From the readme (http://blitiri.com.ar/git/r/git-arr/b/master/t/f=README.html):

  The first time you generate, depending on the size of your repositories, it
  can take some time. Subsequent runs should take less time, as it is smart
  enough to only generate what has changed.

Seems like it does!

Nazri
