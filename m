From: Ain Valtin <ain.valtin@gmail.com>
Subject: Re: separate-git-dir doesn't work with mapped drive
Date: Sat, 19 Oct 2013 14:45:46 +0300
Message-ID: <CADgy817rrg0s9icaT_QdAWGiRsb6T5eg4LJAc+Q7CdM=Csexkw@mail.gmail.com>
References: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
	<20131019111137.GT13967@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 13:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXUye-0001rE-Jl
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 13:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab3JSLpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 07:45:47 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:41291 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab3JSLpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 07:45:47 -0400
Received: by mail-ve0-f182.google.com with SMTP id oy12so2629857veb.41
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NP6vtivZ6pbvZzUdmbQhx1WgpWQpa38yyAhjlBeQNn0=;
        b=aiee4SIaesFa0daodNksL0/PeNKwh6x9Yba3rvKnO+x5YUBtjOjr6DFc7r7kcD2eTh
         E49/kf1ZjrFK5tB3DWyn/IVaf2wcK4MTf3TAlfvhs1P/fwWpkM7GM0rCqPcBmtuwBdc9
         QiXHKHI7YJNfaukIORTvd/BegmMLp7YSte/2BbmbAd2EKnq5XFSKxQ3UbH+bZ6WKsbcU
         0ObA+YAqMNcQ94/XyH9lZRmFu+PYgFws7Oxq6Cn1aJy9vJeJ46GTZK/av+7jY6gOtIal
         FgY9KdQUOSmLpTjNGoyLjJP0DCae9o3Gt0knCbZGDFPFyu0ZDh1m8UvWCGi4VwIRsKeZ
         C7UQ==
X-Received: by 10.221.64.17 with SMTP id xg17mr4974451vcb.5.1382183146348;
 Sat, 19 Oct 2013 04:45:46 -0700 (PDT)
Received: by 10.220.215.74 with HTTP; Sat, 19 Oct 2013 04:45:46 -0700 (PDT)
In-Reply-To: <20131019111137.GT13967@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236397>

On Sat, Oct 19, 2013 at 2:11 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>
> Git has a bad history with mapped drives in windows. It's also usually a
> bad idea to use git over the network (and most mapped drives are over
> the network and not local between virt. machines).
>
> I would advise not to use this setup since for the past two years that
> git has sometime worked and sometimes not with this setup. (It's not
> just seperate git dir, a git dir at all over a smb share have been
> problematic).

That's a shame :(
As I wrote I want to use git in a virtual machine and as a extra
precaution it would be nice to have the repo outside of the VM, on the
host drive - should the VM not to start up for whatever reason I
wouldn't lose my repo with it...


ain
