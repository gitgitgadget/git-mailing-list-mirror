From: William Swanson <swansontec@gmail.com>
Subject: Re: New User Question
Date: Mon, 17 Jun 2013 09:51:50 -0700
Message-ID: <CABjHNoSfLGW_D8RM8+LghP8kKYsYhZKi=7k4kEJSNEX=PDe2XQ@mail.gmail.com>
References: <F201B6D6-7A69-4DD6-BDF5-5AE12E3A176C@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joel McGahen <vin4bacchus@me.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 18:51:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uocer-00062p-7f
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 18:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab3FQQvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 12:51:52 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:61745 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab3FQQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 12:51:51 -0400
Received: by mail-wi0-f170.google.com with SMTP id ey16so4282173wid.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4qMa4+qc4ubccz8ntXNna5V3EbcRlst11NbWBXNJXVo=;
        b=e5JanjbcW5mXGNFZtHfnKsoQBwd5Oki0hw+iNlluDx0UbuVojksIhLGMzDlLHTL1w2
         rDQdgMCvJG/++NGscRceC723Tbk7Foj6pYupJT8lDFsEf5GBdlyEkXBo5bDAWue63fT1
         6c9U2zAmLl/2h59nY+G4D/JDv81rTTsQgHGvvL5PfL9gRGxWdge41xms28KzCh5qay7j
         4J3YW1irWIGKFOnNxIr3DnMSo6aa0jE8E6YeDAYEkNtNSHNdGZ269IAn7Vf+EmGIK+3L
         M/vKgn9cXmmkZm0tJbbxSUW4wW4V3ne/94MpSb8xVQvYDcj2Npy7vYzghmrLJSJwRUP8
         coqw==
X-Received: by 10.180.189.68 with SMTP id gg4mr5328284wic.27.1371487910287;
 Mon, 17 Jun 2013 09:51:50 -0700 (PDT)
Received: by 10.217.93.68 with HTTP; Mon, 17 Jun 2013 09:51:50 -0700 (PDT)
In-Reply-To: <F201B6D6-7A69-4DD6-BDF5-5AE12E3A176C@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228083>

On Mon, Jun 17, 2013 at 8:39 AM, Joel McGahen <vin4bacchus@me.com> wrote:
> What I need to understand is how to
> a) Connect my developer's VM local repos to the new remote repo I created so they can continue to work.
> b) Once the contractual issues are resolved reconnect the developer's local repos back to the original orgin/master repo and merge all their changes.

Git stores information about remotes in the .git/config file. You can
either edit this file directly to change which URL "orgin" points to,
or you can use the "git remote" commands to make the same changes. You
can read the documentation by typing "git help remote".
