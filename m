From: Morgan McClure <mcclure.morgan@gmail.com>
Subject: Feature Request: Support logic or shell execution to control values
 in .gitconfig
Date: Thu, 8 Aug 2013 08:09:22 -0700
Message-ID: <CANY-LFJZazieg-7gLq1=pv=nkED81Gck4=95ffgZ6tGVgX5ffg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 17:09:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7RqB-0007Bj-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 17:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965752Ab3HHPJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 11:09:23 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:55469 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965742Ab3HHPJW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 11:09:22 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so3268389vbg.39
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mNz/BcBmzPEX4N9V044Mfu+NzgHyimsXuDH4cxWN7iQ=;
        b=HylEL61NgA7NQ+Vw/EnPEroVWPM+dPOmzXG1HHgEId3fec/QB/Yz7FUnNlWPpcMx1/
         WC3Nx0Fl6BlZC7WoB4G69FwEq2sg0NSVJU2vm5ZZSV0t6NSUiNmlSlFwjnX83uHWg9Vb
         S4pv/BCFVJuvCiZsEzaxZk5730YGyQm+S+P3Z0d0G9I+AYTBbZkxy8E2FJ4A6NZycuV5
         mJ4CHFOJfBJPnidVk4BoJ7wYLymYn35YdInKZXIBwVo7zUDdEXLRcv18sq04fqreUqJY
         sRfkQ1+3Q1wLIxyVFtRZY/f++PVdngWvPEKVdzXbazyZAUOg5Sdon/gAvl5UmMjBvy5v
         9tcw==
X-Received: by 10.58.135.167 with SMTP id pt7mr3331059veb.75.1375974562273;
 Thu, 08 Aug 2013 08:09:22 -0700 (PDT)
Received: by 10.58.94.14 with HTTP; Thu, 8 Aug 2013 08:09:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231893>

I sync all my dot files (including .gitconfig) among several machines
and it's currently not possible to put conditional logic in many
fields (any that aren't considered strings to be executed as shell
commands ie aliases, editor, etc).

My specific use case is the email address. Normally I want my email
address to read:
mcclurem@$HOSTNAME  <mcclure.morgan@gmail.com>

I use this to track which machine I'm committing from etc.

I propose using something reminiscent of bash syntax, either:
value = $(SOMETEXTTOEXECUTE)

or

value = `SOMETEXTTOEXECUTE`

Is this a feature others could get behind?

-Morgan McClure
