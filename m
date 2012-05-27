From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v7 8/9] submodule: fix handling of denormalized
 superproject origin URLs
Date: Mon, 28 May 2012 08:57:53 +1000
Message-ID: <CAH3AnrpTgwHDDLKM=OraEZfBRDyKzf1jjgqaBCJwkudDvsWkEQ@mail.gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
	<1338132851-23497-9-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 00:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYmQ2-0000Do-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 00:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab2E0W5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 18:57:55 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:51372 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab2E0W5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 18:57:54 -0400
Received: by weyu7 with SMTP id u7so1614326wey.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 15:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=puOk2jRfu3/jrQJbFPPBGeN5t1u1WaTpN/K8BDmZnBM=;
        b=E4EMOMV8tNmciuRIl4pjpvs74tKRUNqTygAwtMpOFotbbKtBkxY/SMgYUXsTu1+SIl
         QdCFt6PdYPVgsR6HojUwZvEjPubuqtg6X+09La+zoCVad2+XE/zedpw5dXcl7P3L0ZtU
         lp8lrJpOwW9PBFVBfOyRbvdj8qg/afstG04opz3CmfrKit+CAx+UkfW5dQuqd5LdvIbp
         0QZIA8Vn64oUZ/JmEKE57oJHU5i6FskSRhG74wVIUqG5NNSDAAnApvhJsXzgXlf71KRI
         iuDl2kQtxopEmWAtgulvam/6s0KmG8Pu2RGZ8Mx3bjQlz9/wi6RieMWk/8R5WVudGBJC
         Elqw==
Received: by 10.216.216.148 with SMTP id g20mr3199379wep.187.1338159473551;
 Sun, 27 May 2012 15:57:53 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sun, 27 May 2012 15:57:53 -0700 (PDT)
In-Reply-To: <1338132851-23497-9-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198619>

On Mon, May 28, 2012 at 1:34 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> This change also fixes a subtle error in the setup of some tests which was
> masked by the denormalization issue that is now fixed.
>

I guess this patch could be improved by moving the change to the test
setup to a separate, earlier patch and also including a separate test
which demonstrates the
flawed behaviour described by the commit message. Anyone disagree?

jon.
