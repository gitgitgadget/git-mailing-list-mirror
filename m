From: Paul Tan <pyokagan@gmail.com>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4]
 t7601: test for pull.ff=true overrides merge.ff=false
Date: Sat, 16 May 2015 20:33:28 +0800
Message-ID: <CACRoPnTQCKJbuFcoTBAvJS8X+b7Yv35MKgo+HhAhfOvuyMWJ-w@mail.gmail.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
	<1431510740-9710-2-git-send-email-pyokagan@gmail.com>
	<2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
	<xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
	<81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 16 14:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtbId-0001sB-71
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 14:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbbEPMdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 08:33:32 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:33833 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbbEPMda convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 May 2015 08:33:30 -0400
Received: by laat2 with SMTP id t2so158721184laa.1
        for <git@vger.kernel.org>; Sat, 16 May 2015 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cRYZxlY7dkdV91tU/NEidzltd1rojPYyhaeMFFHwm6c=;
        b=qYWSyT/t7gBZIhrGS6UjAnhhG2uMD8rubMpnlx7DZ6tNrYk3c6+I4060zfCc6lRWoN
         sp63PFJcaPHCBsfrxK8Lkd2FE+xmySYCE2to797uuElfz8SwMKSYRJhroFfI818AesNX
         I0E5iR2EX5X0JJI/oPYGd6kMa+qnhQlyTQohIDNJKTKOxz88suNL9EMsbpU95evb7TOJ
         xw93Vf0togWeDwHm1CNzPEFbE48DDhPFSrxucYLFyTzyYhjMUMzmPU5kny2BNGRS83rX
         IaXVi1SQtREC/+43lqZdhGcHi70MheH5kDGUFVshacFdK6xCVisOV0sxi7Ril3KQ+x/+
         tNbg==
X-Received: by 10.152.4.72 with SMTP id i8mr10962380lai.32.1431779608821; Sat,
 16 May 2015 05:33:28 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sat, 16 May 2015 05:33:28 -0700 (PDT)
In-Reply-To: <81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269195>

Hi Johannes,

On Fri, May 15, 2015 at 12:53 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Asketh and ye shall be given: without running the tests in parallel, our Jenkins would take *even longer* than the three hours per test suite run (which is really painful, still, by the way). And as you know, running the tests with "-v -x" is awfully useless if you run the test suite in parallel.

Would the --tee option work for this case?

    --tee::
        In addition to printing the test output to the terminal,
        write it to files named 't/test-results/$TEST_NAME.out'.
        As the names depend on the tests' file names, it is safe to
        run the tests with this option in parallel.

Thanks,
Paul
