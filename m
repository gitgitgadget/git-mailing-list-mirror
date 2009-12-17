From: Pat Notz <patnotz@gmail.com>
Subject: Re: How do I show only log messages for commits on a specific branch?
Date: Thu, 17 Dec 2009 08:04:03 -0700
Message-ID: <1cd1989b0912170704m4b95849agf2baaa131a1bff7c@mail.gmail.com>
References: <20091216101647.GB27373@bc-bd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: bd@bc-bd.org
X-From: git-owner@vger.kernel.org Thu Dec 17 16:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLHto-0006k2-SB
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 16:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762459AbZLQPEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 10:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbZLQPEK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 10:04:10 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:38260 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762457AbZLQPEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2009 10:04:07 -0500
Received: by pwj9 with SMTP id 9so1332386pwj.21
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 07:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2zDvyxXz/d5I5j0hzVhzLMupr+4HgPSDHTPp+zY9M20=;
        b=JmmiqoBHq+4YrNAYLkjLcOwWtw1jm7Q6kKLjy3D9TkKR52sWpGrksp6R3ELeQCNEOz
         GB3gJeIvXaRrDqSqGgxu6AeIch+aNZo4pST+aavwUjq34iyFBqSa8ZdiAnXMW2MkQKas
         v69kji5yWFNSLt9ZX832KNwy3UymAYy8AbelE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h9et+L8ERUxmN+f4sHQ8AIXXRXkGVsGLlIKakKOQwiOAdxqPx7rUbJJAsFuegPR8Qb
         hGgtt7brjQTqclcXtgKNvedGf7WZyQj7TWxjpkR8jvxVI9ErnBC5Ao3tKrdwxJTfAeKe
         ZFly0nImd3gYIb+nBNkIaARVE8zMrmq7ek3mM=
Received: by 10.142.6.20 with SMTP id 20mr1721340wff.262.1261062243250; Thu, 
	17 Dec 2009 07:04:03 -0800 (PST)
In-Reply-To: <20091216101647.GB27373@bc-bd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135373>

> So how do I:
>
> =A0 =A0 =A0 =A0git please-tell-me-the-branch-I-started-this-branch-fr=
om new
>

You may also be interested in the git show-branch command.  The output
may be unintuitive at first but once you grok it it's pretty useful...
especially if you have several branches.

Aside from the man page, here's a blog post the describes the output:
https://wincent.com/wiki/Understanding_the_output_of_%22git_show-branch=
%22

~ Pat
