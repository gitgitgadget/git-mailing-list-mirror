From: Haralan Dobrev <hkdobrev@gmail.com>
Subject: Bash completion: merge --abort
Date: Mon, 19 May 2014 11:36:54 +0300
Message-ID: <CANu1nikzk-rGjzKv6R-OR6Et-fB-JYnt245+P6NY-RQiihzXyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 10:37:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmJ4e-00054r-9T
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 10:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbaESIh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 04:37:27 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35561 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbaESIhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 04:37:25 -0400
Received: by mail-qc0-f181.google.com with SMTP id m20so8420813qcx.12
        for <git@vger.kernel.org>; Mon, 19 May 2014 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=vdiZSrE3JNmMjEh92xdOPzqHKX7DScyxnsJA94BpUag=;
        b=DrrD5I+8FFBlmZKj2Hjcffu8D00E4jECr7zOadZWdEzZklw7FYkPKzPhRGNkhEcmYH
         Ua3AB8HNl+nBq22hRSQqsJHvp39pvUjxGF7NeuOmy0XQYJQ2ziD5RawsP51O2PGhVUka
         41KWgA6VTYe9F9+Paoyttu5MV38k1nc13XSeCDt+tF0VoLGhl31R5HoeKY/6xLlu2xG+
         Giqglqd+XHERABeTKqou1mdLYVtdKQ91TPWmXnXmIi51LgtP+AaL28Mpz7/620d8XKZp
         CUAvob3B0a6YeBpot/9oI/uLKNt/psWq1Y8bTt5JeR6I8fQAWqUZ5s4fofmRLEOMYYV7
         B7PA==
X-Received: by 10.229.97.71 with SMTP id k7mr47519330qcn.4.1400488644631; Mon,
 19 May 2014 01:37:24 -0700 (PDT)
Received: by 10.229.70.72 with HTTP; Mon, 19 May 2014 01:36:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249566>

Hi all!

The Git Bash completion script does not complete the `--abort` option
for the `merge ` command.

It correctly completes the other flags.
It correctly completes the `--abort` flag for `rebase` and others.

`git merge --abort` is considered another form of the merge command
instead of a simple option.
This could be the cause of the completion to be missed from the script.

Cheers!
