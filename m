From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Interactive staging not functioning properly?
Date: Thu, 4 Sep 2014 16:54:17 -0500
Message-ID: <CAHd499CdEORortwMWE5eLiKuiYV=yd=sZ4cny8gYe+HCzK4D5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:54:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPez0-0006Ul-6U
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 23:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbaIDVyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 17:54:18 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:34243 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbaIDVyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 17:54:17 -0400
Received: by mail-vc0-f170.google.com with SMTP id la4so11607140vcb.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=rUOrLzPwY4ZT1pdvfAZhpgJVgRGMggDtvyXDO3qjI1w=;
        b=gQZVe/kGrHP9V5rimROKAC50Sx4sBNwMbdNR6snUEi7i+PiYsrRslmNi2qK3VRtUfh
         3Aj+8VYLxH4C53nJWvbwplJGdmcXUGBvAJzaVJSVKFwEp68A0V8K3dIQpbkXgZX+OTI1
         58JAWRwnAtrGxBxJUYzBTK3qImJLTMVqZrVvnpWxWCrVdKVg8ZCUu+GdbwDw+I0K2mHW
         plz1AW2p5UBbDrULXVSqACpfNGoNDE0UdutJvUO9BEZQynSnRQwi52kOubRgJyXh7Efg
         DfjckzLgC3VkkXC2Vi8KycMjCn9t2IkUhwlxfCRGsHUEzppHV4CWOgryhmnisGWtCWD9
         jvbg==
X-Received: by 10.220.74.10 with SMTP id s10mr4289646vcj.61.1409867657067;
 Thu, 04 Sep 2014 14:54:17 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.3.200 with HTTP; Thu, 4 Sep 2014 14:54:17 -0700 (PDT)
X-Google-Sender-Auth: IHVxRsOz28exOA7AwiqO1oiDkeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256488>

I run the following:

$ git add -p

I skip the first hunk by typing "n". At the next hunk, I try "k" and
"K". In both cases, it shows me the same hunk I'm on again and says
"No previous hunk".

Is this intended behavior? I expect to be taken back to the previous
hunk that I did not stage.

Running Git 2.1.0 on msysgit Windows.
