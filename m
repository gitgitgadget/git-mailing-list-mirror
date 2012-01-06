From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Why usage function exit with code 129?
Date: Fri, 6 Jan 2012 15:15:07 +0800
Message-ID: <CAMocUqSbiO2XC3PUEciyV3HxgqDPW_rTW-hYH4P=C=BFCSrQMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 06 08:15:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj41F-0005nl-9W
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 08:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab2AFHPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 02:15:11 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57658 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2AFHPK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 02:15:10 -0500
Received: by bkcjm19 with SMTP id jm19so247018bkc.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 23:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=5Ek+Xnk9w7AEsupktPv2qswC9y7CFed8Vm4j5na+i04=;
        b=a/NzszyunovZXHViIRIpN/U8898yyWRSqnjG92nuvfdaFx51yQMvHfai5NHDg/znek
         Far42Xjwh9qX/m/uW5yMxh8wt063FTFXH8zoI+mgS4RF+fsKa/Q7GIUiCdheATc531sc
         bhjFv4dVKY5lqHv/2nR44jZPjVVrQNAKvF3Q8=
Received: by 10.204.143.136 with SMTP id v8mr2066805bku.91.1325834107777; Thu,
 05 Jan 2012 23:15:07 -0800 (PST)
Received: by 10.204.200.74 with HTTP; Thu, 5 Jan 2012 23:15:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188012>

I did like this:
$ git add --foo
$ echo $?
what I got is 129, should this code being used as program terminated
due to a signal? Cause it's 128+1. According to this[1].

[1] http://tldp.org/LDP/abs/html/exitcodes.html
