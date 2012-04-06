From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v3 5/8] gitweb: Use print_diff_chunk() for both
 side-by-side and inline diffs
Date: Fri, 6 Apr 2012 10:34:52 +0200
Message-ID: <20120406103452.1544e88f@mkiedrowicz.ivo.pl>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1333569433-3245-6-git-send-email-michal.kiedrowicz@gmail.com>
	<201204060126.38337.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 10:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG4dT-0007Lu-4w
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 10:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761Ab2DFIfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 04:35:05 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39684 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2DFIfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 04:35:03 -0400
Received: by wibhj6 with SMTP id hj6so355426wib.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=eNt8FK40mw/jGDulM8LjOHOexDuSs9o91/Jw9BB7qh0=;
        b=CBSbYZsHeos5sc1Ngu5K2UKD3nH+6Zx/D7K25B8IYjOktp+NkSj0heOW+iCeMKtIlW
         r9MT+ZsZl3ShfIqQkZx1nOlEHv3GkOH9nVDyAwJstqp3St+Ru9IIvPKK1aLnzo9ms/p9
         beQ8tCNo1tFA/MJEHpku2RYd8GnI7+bddktc+cG/hormm319Pp5FgGdmUQAkmO64s5NK
         pD8tmHQn6OHbamKDbbzV9Gt9yVHOjxwiqOuGvLU4ar28SLiWFNmNZDo7fCXRy8jgoIv+
         P5VkHQ0mcoCTylOZ9aXkYke2uOP6WmJ0L2nt4X9EYOR5w6/RVTKQuEe1jYaD8C/JcQHf
         pd1w==
Received: by 10.180.95.129 with SMTP id dk1mr11105541wib.3.1333701301671;
        Fri, 06 Apr 2012 01:35:01 -0700 (PDT)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id b3sm4406049wib.4.2012.04.06.01.35.00
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 01:35:01 -0700 (PDT)
In-Reply-To: <201204060126.38337.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194860>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz wrote:
> >=20
> > To prevent gitweb from reordering lines, print_diff_chunk() calls
> > print_diff_lines() as soon as it detects that both added and remove=
d
> > lines are present and there was a class change.
>                                                  , and at the end of
> hunk.
>=20
>=20
> I think it is worth adding the above to the commit message.
>=20

OK, will do.
