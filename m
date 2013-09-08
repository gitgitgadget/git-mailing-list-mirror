From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Sun, 8 Sep 2013 17:49:41 -0500
Message-ID: <CAMP44s3p_DRTvBhKbM0ejKgea9hauSCzahPux4jCWL7JP4nxKw@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Rahul Bansal <rahul.bansal@rtcamp.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 00:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VInne-0006ce-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 00:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab3IHWtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 18:49:43 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:50631 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab3IHWtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 18:49:42 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so4363767lbj.41
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/Ywp6ibTIKKH7hLISVEDsXcV43fXdhQZ6swIAer/tjU=;
        b=ls4mYO3rWqu8Gonsfr1EANcKUo61o2O/O9Sia5lJ3rmMlZ7BG6xozf1e3IyVIr9kpc
         seFQ/YsahIwdE6CGY6VdEJize42zlWibfl1jzTqM7H1BVdUmCIpxWu3duhcgSXd2fhzW
         7512bpc35+cUATEARt5kHD4LSLUyEnGOeulvGEITFtrz0hClgSeYGkOCZ187lqycvJiL
         k6MlyBj5hIhnA4/opb32bfHlPdI8sTZinO1B8UGOqAJsif62f4m+oRMGOziPnUGrQrZv
         UksPN9vMDiV+lKnaI4u5yPkg0lzoA/uevluyVhMzDUCDnG/jke++UCXOcMr6zJH6AFv3
         2r9Q==
X-Received: by 10.152.29.103 with SMTP id j7mr13207520lah.7.1378680581665;
 Sun, 08 Sep 2013 15:49:41 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 15:49:41 -0700 (PDT)
In-Reply-To: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234276>

On Thu, Jul 18, 2013 at 10:27 AM, Rahul Bansal <rahul.bansal@rtcamp.com> wrote:
> I am posting here first time, so please excuse me if this is not right place to send something like this.
>
> Please check - http://stackoverflow.com/questions/6091306/can-i-make-git-print-x-y-z-style-tag-names-in-a-sensible-order
>
> And also - https://github.com/gitlabhq/gitlabhq/issues/4565
>
> IMHO "git tag" is expected to show tag-list ordered by versions.
>
> It may be case, that people do not follow same version numbering convention. Most people after x.9.x increment major version (that is why they may not be affected because of this)
>
> Another option like "git tag --date-asc" can be added which will print tags by creation date. (As long as people do not create backdated tag, this will work).

I completely agree, and there was a proposal to an option like this a
long time ago:

http://article.gmane.org/gmane.comp.version-control.git/111032

-- 
Felipe Contreras
