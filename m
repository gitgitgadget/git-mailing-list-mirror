From: Adam Monsen <haircut@gmail.com>
Subject: configuring cherry-pick to always use -x?
Date: Mon, 14 Feb 2011 09:19:49 -0800
Message-ID: <4D596435.9020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 18:19:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp25f-0003Gd-Gz
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 18:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab1BNRTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 12:19:55 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61186 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab1BNRTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 12:19:54 -0500
Received: by ywo7 with SMTP id 7so2156242ywo.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=GuNh0tc4i3E5Y9QEUNcFZEg2EFclog6k3vfbIViTkIs=;
        b=NDn3Ru8W0kHm1LQHvdy9uySdIxhEetAIuNPmexXWyrT8VnvAXwLrBM80SdoEdWx9BU
         KfUunghTZjvykwXfYllrfWMXAzdfFR8+UZ9KPLs50eRxdH1eJNoXeDLZAurJw+AIsdSm
         3f9kB8nVMN/Mufm8HeguKlyJ7pxcrc44KhAFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=Y2MKvXKpperFco+uCy+2YR4DV/ZbHnIk/nk3yn0UbrqgjnOhMhB7hEt7YQOJg7LyFA
         zl+bvFEy0Hm3BY2Q9zPULA8VaJnC5+BWrZV3j3Jw6gu4nwYVYWeKJCPldAu3V2V3PA/e
         3TwALKASSSiJVbaddVIjWOkIIZv9ykmt+2TP0=
Received: by 10.90.54.14 with SMTP id c14mr4823518aga.14.1297703993286;
        Mon, 14 Feb 2011 09:19:53 -0800 (PST)
Received: from [192.168.13.8] (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id c34sm3806450anc.10.2011.02.14.09.19.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 09:19:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166737>

Is there a configuration option to make cherry-pick always include the
source commit hash in the new commit log message?

e.g., make "git cherry-pick" always behave like "git cherry-pick -x"?

My most frequent use case for cherry picking is between publicly visible
branches.

I have the following configuration option set:

  alias.cpx=cherry-pick -x

but I rarely remember to use it.
