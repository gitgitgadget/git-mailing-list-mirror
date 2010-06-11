From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC 2010] The 3 week
Date: Fri, 11 Jun 2010 23:39:04 +0800
Message-ID: <AANLkTikyyM5smnYNHZYYLQY0Tj23EMmYQsRUR4qpjNRU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 11 17:39:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON6KB-0006Fa-QK
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 17:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab0FKPjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 11:39:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49272 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab0FKPjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 11:39:08 -0400
Received: by pwi1 with SMTP id 1so565807pwi.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=hIc2TlRVYXLgJWSawe6nLD5L6t1mYk7voEznQr5hQvc=;
        b=poC83I2zMJLe0eyiujExjDLuUiD8kUO+vEPPOIPf6i9+A/sGG1OHGr6J6kOwyFett5
         GOyxTnMD3emJv67JOiyd8YJHF8LX58M9JVgE1l/bvIZOSO2YgOwinmMptdWghGWpcKcP
         IOVSZkRK2H4T5Y+PTb+XdMhNQysjCjlKiXC2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=C5YCLaNhhXeWJO2og/K/P7+Yu9rK4+sQ12VxeoYeO+/aH/TNo46fR7/Wan6mChBHB6
         lWoDgrhFO6O+P0nKjah1hMLNyqysHzpJR9mGTz0Sf1mENBuyYNafg1U1zDn/cRDC60Dq
         9fL+98HZx/QhKA5OOROic8fLduWS7mbAik6tg=
Received: by 10.229.233.17 with SMTP id jw17mr1141132qcb.219.1276270745031; 
	Fri, 11 Jun 2010 08:39:05 -0700 (PDT)
Received: by 10.229.98.70 with HTTP; Fri, 11 Jun 2010 08:39:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148956>

Hi all,

    I try to put off the update post from Monday to Friday, because I
want to complete a draft version of the line level history browser
before post, but I should admit I failed. :) Although fail, we are
very near to success. Anyway, in the past week, I have spend all my
time on line range assignment and line diff printing. And now, the
line ranges assignment works well for unchanged part and some of
changed part, for printing stuff, the header output is done, the true
line diff code are in heavy debugging. I think it will cost 1 or 2
days to complete the draft version if everything goes well.

   For the coming week, I will complete the draft version and try to
add parent rewrite code into line level to make it works well with
--graph.

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
