From: Chris Rorvick <chris@rorvick.com>
Subject: Re: git push tags
Date: Sun, 28 Oct 2012 14:59:01 -0500
Message-ID: <CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<508D7628.10509@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 20:59:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSZ0u-0002KD-Av
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 20:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405Ab2J1T7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 15:59:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48023 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab2J1T7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 15:59:02 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2622866lbo.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=xnqv93bOKAzO2lwmDegBg3/MP/wXQScq4t9zoiBO2J8=;
        b=XsnaaiA4tImY7OEQLeXg7XnJv5Zs4M1jYCP4mszqzLk1bKDolCu0NxhaYf2qk5vhSq
         UI0ffBh75weFS321uW+pEYuKBdB7BQbIbHTB3N6zsaQDDUhqIJhtRWrjXOave+315cpz
         uJFMubClOtbZE17wiUz7HxRA7v66xqW1mfHNXHgDox8jOSQaR1hOlSIb/70UwVH0sLhT
         MQ2BJZ1j6NnvgFApYMS7kygylTkOqmZSPkbFff2NyWFnp54ujF7fDfRvaT8m7wFFpVnd
         +NrJvC29tAUaD5gXG4Do+yyAWEh2GBestn78/ww3h3gezCPVFKcInPr9j0TGKOh6zA4j
         9rgQ==
Received: by 10.112.11.35 with SMTP id n3mr9376923lbb.79.1351454341364; Sun,
 28 Oct 2012 12:59:01 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Sun, 28 Oct 2012 12:59:01 -0700 (PDT)
In-Reply-To: <508D7628.10509@kdbg.org>
X-Google-Sender-Auth: jeWiJA_o3tgmyMGQ4NsXkKh9SVo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208562>

On Sun, Oct 28, 2012 at 1:15 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Tags are refs, just like branches. "Tags don't move" is just a
> convention, and git doesn't even respect it (except possibly in one
> place[1]). You can't reseat tags unless you use -f, which is exactly the
> same with branches, which you can't reseat unless you use -f.
>
> [1] By default, git fetch does not fetch tags that it already has.

Also, git checkout <tag> puts you on a detached HEAD.  This seems
pretty significant with regard to Git respecting a "tags don't move"
convention.

Chris Rorvick
