From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v6 7/9] submodule: fix sync handling of relative
 superproject origin URLs
Date: Sun, 27 May 2012 23:55:07 +1000
Message-ID: <CAH3AnroV7yWoTp4EW6smmX8T2H1vj8de4dH2Q2y9qiZgBnDS4g@mail.gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
	<1338126210-11517-8-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:55:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdw9-0002Xi-PD
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab2E0NzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:55:10 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43352 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab2E0NzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:55:09 -0400
Received: by wibhn6 with SMTP id hn6so955456wib.1
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=UM2WvPd2fNWENO0UFIZUO+dw2ytARlaFs7L/Qeo+Z+Y=;
        b=j3oOil0eNBMinrCVJ17OUb6EkyHAYVSVxpT0w85oCmMFJA/I9XHBb2+QTeU3q6wmqE
         /eP+r+SburJNX1yiuZSvMLg95q5aeaEAenTD1FcwG6W0Ac38FqLjy0JufbIYlHeF3ykZ
         3OKyf2IntlocxAfKoxQZKc6mLKFuDZgGdJbWQrV3caf9GwDqsBzEKqbOsHSZl8z/LIyB
         o/NoM4uEM36MDW6Nduc90Bq6GpYJR+jFGa+SBcD4tvJAfxNQM32NHse4lTXkxe3rX2bz
         qYmsqZvG8hfCs0xSw1N/7iaYuKjafrlTklpE3pYewa+cIW6qU/9UKtIHV5nRP+jg8DMw
         dswg==
Received: by 10.180.84.6 with SMTP id u6mr1387104wiy.11.1338126907857; Sun, 27
 May 2012 06:55:07 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sun, 27 May 2012 06:55:07 -0700 (PDT)
In-Reply-To: <1338126210-11517-8-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198602>

On Sun, May 27, 2012 at 11:43 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> When the origin URL of the superproject is itself relative, git sync
> configures the remote.origin.url configuration property of the submodule
> with a path that is relative to the work tree of the super project

sorry! super project -> superproject

> rather than the work tree of the submodule.
>
> To fix this an 'up_path' that navigates from the work tree of the submodule
> to the work tree of the supermodule needs to be prepended to the URL

sorry! supermodule -> superproject.
