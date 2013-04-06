From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 2/2] format-patch: add format.cover-letter configuration
Date: Sat, 6 Apr 2013 18:13:58 +0530
Message-ID: <CALkWK0kMTt6wDv6sUVe9CbX-WSx=XH+PF6eQ6oXYFjcp_Yi+aQ@mail.gmail.com>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com> <1365239012-15079-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:54:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWV3-0001b9-BR
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851Ab3DFMoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 08:44:39 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:41330 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422847Ab3DFMoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 08:44:39 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so5202892iee.25
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=OMX57Vbycx3wkKA6xz9SFmRIu0jIAh7NvaDZF/0b/rU=;
        b=wT7XW6bY0w+1je4DltZn1Y4pWx3khJvY9qHCUqzKE+8Skdho+0tyOw6EhomKurLiwX
         OnT7tLdEUdl1sAT0L2R8BxjPDYBcBThGxUt4F2s/r89pnrCnE0e18IrYvznkFMQ1GK8P
         x2PHF5tQwYKSaMWGRkHKIcrPYNPBhgcjCve0f0/wVmOhVHh4jNeHUkPdXIkCnHNp/kaa
         F0lWHYyZ2yzvZ0HdtbGl/0YS5KehPuRW4r7B0A3nYPFqHqObSzrBfhxYIh/wBAfsyuO4
         UF47mzNX+bywfhqmyzyONxYkGPJoyl6Fp2KLTf4H1y64ztgFrt5+Dgc+hHDOXf6HKNrt
         nM8w==
X-Received: by 10.43.9.68 with SMTP id ov4mr7794770icb.22.1365252278808; Sat,
 06 Apr 2013 05:44:38 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sat, 6 Apr 2013 05:43:58 -0700 (PDT)
In-Reply-To: <1365239012-15079-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220243>

Felipe Contreras wrote:
> Also, add a new option: 'auto', so if there's more than one patch, the
> cover letter is generated, otherwise it's not.

Awesome!  I wanted to fix this myself, but got sidetracked with the
whole submodules thing.

> +format.cover-letter::
> +       Allows to configure the --cover-letter option of format-patch by
> +       default. In addition, you can set it to 'auto' to automatically
> +       determine based on the number of patches (generate if there's more than
> +       one).
> +

Perhaps you can clarify this: Controls whether to generate a
cover-letter when format-patch is invoked.  Can be true, false, or
auto.  "auto" generates a cover-letter only when generating more than
one patch.

Thanks.
