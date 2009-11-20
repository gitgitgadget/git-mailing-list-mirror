From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: Name/documentation on git-log --full-diff is insufficient
Date: Fri, 20 Nov 2009 09:19:00 -0500
Message-ID: <32c343770911200619i38009e2fy5067a301be3fc313@mail.gmail.com>
References: <81f018ac0911191526o1cfa8e56r79f8db33256a4e9c@mail.gmail.com>
	 <20091120140138.GB23718@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Miller <mille121@illinois.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 15:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBUKM-000609-L8
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 15:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbZKTOS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 09:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbZKTOS4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 09:18:56 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:56819 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbZKTOS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 09:18:56 -0500
Received: by fxm21 with SMTP id 21so3721063fxm.21
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=yIS/ld0jXF0KSTSF2EHRf/LfMKEc50QmU8e5YrhJDFk=;
        b=dDXDBgsTW3XeYXx7h3RNIvc/GXPej8wfznKjnEEt7g6h3yYy5OKfDIpmJJ+J3zIqH1
         FaDE4Y/nBPDjAarDfZUBpGrzTVTGqy1tkJlV3mPr/70sPanEWJR168HrkrSkPQlAmZZm
         gpKA9OnziYli1pt5e3464rTZeNlxF3S5xef3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=D/ls5Vt+3yp57HXLV7WgmJDWLjZnmFczKEiR6bL4uBdLxOJ8kiqv8/XkIqCPlgBURd
         Nig/88VccPekwaET05xDJtuVoV2PmxnmzTkREUFJQIpAyAAoIvUSNuJ/mpR1UaMlXUQj
         O1BdlcjZFaqS9iWKZQCRldsoVpWFmsxTav9jw=
Received: by 10.216.90.74 with SMTP id d52mr448631wef.51.1258726741296; Fri, 
	20 Nov 2009 06:19:01 -0800 (PST)
In-Reply-To: <20091120140138.GB23718@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133347>

On Fri, Nov 20, 2009 at 9:01 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Thu, Nov 19, 2009 at 05:26:33PM -0600, Phil Miller <mille121@illinois.edu> wrote:
>> PS: I sent in a patch for git-cvsserver a week ago, and have seen no
>> response or action on it. Is there something I should have done
>> differently?
>
> From MaintNotes:
>
> "If you sent a patch that you did not hear from anybody for three days,
> that is a very good indication that it was dropped on the floor ---
> please do not hesitate to remind me."

...also as noted in 'Documentation/SubmittingPatches':
   - Patches should be placed inline in your email rather than attached.
   - Patches should be addressed to both:
       * gitster@pobox.com
       * git@vger.kernel.org

You should also double-check your patch against the rest of the
guidelines in 'SubmittingPatches', to be sure it will apply cleanly.
