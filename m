From: Sam Cates <sam@samcates.com>
Subject: git-rebase doesn't forward --quiet to git-checkout
Date: Mon, 27 Apr 2015 12:05:41 -0700
Message-ID: <CAFGg4-hsRY9S4ok0-KSUWN7AWS=Eptk4E5B-LZcPFPsKrOP-_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 21:06:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmoM8-0003lw-M4
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 21:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbbD0TGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 15:06:06 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33591 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932946AbbD0TGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 15:06:03 -0400
Received: by igbpi8 with SMTP id pi8so74515242igb.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=TPq6PZj6IuT8OtZLcVZ45Q9LY4SHr+MvqdkXtBTdK20=;
        b=WkPw/vekTssgR9nRLcgdmDSPkWJQT0UDUav+66hqrydjzWz/VR+ySLMnsXuQnfwxec
         c6WZwBVzbc/00fGHmc2hJ7QshETNyTjgg2Z9mYzGue6JL1I/64zo9DxK5WeF3DLJJqZV
         ybQLOdjDKofJrWF3tf5SKN4Wiv4sphliyRs94Uw//6zySf5OujiGq9JmSyVArHmY0kQp
         4iV1s6spUHfVp+Bfl7CZcYDnpchA8K0FLOqh7jYdJz+L+dKckwYCSVw00r6gbowUP31T
         EX/MgyCZvDho2rG607ZDhfGddimGiAa9APWL8QFA3bgwkmEGtlS6SCBvoPUGfjJwfSSN
         MjIA==
X-Received: by 10.107.19.213 with SMTP id 82mr15398006iot.34.1430161561668;
 Mon, 27 Apr 2015 12:06:01 -0700 (PDT)
Received: by 10.79.9.68 with HTTP; Mon, 27 Apr 2015 12:05:41 -0700 (PDT)
X-Google-Sender-Auth: -PhvK6iri9YUpBWRJhx1WQpdh-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267872>

STEPS TO REPRODUCE:
1. git checkout master
2. git rebase --quiet master topic

EXPECTED RESULTS:
The checkout and rebase occur with no output.

ACTUAL RESULTS:
The output from the checkout is not suppressed.

Thanks,
Sam
