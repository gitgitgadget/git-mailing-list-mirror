From: Chris Leong <walkraft@gmail.com>
Subject: (unknown)
Date: Wed, 15 Feb 2012 14:12:57 +1100
Message-ID: <CAJ6vYjcefsPUfibnySpwFk2bGTC1mpBWF6Tjv5AgyyZcn0-d3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 04:13:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxVJV-0007D4-E2
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 04:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761438Ab2BODNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 22:13:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61147 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757661Ab2BODNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 22:13:18 -0500
Received: by bkcjm19 with SMTP id jm19so559745bkc.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 19:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=j7ggnoT+0K4vxWzltO32hav92ZLGkMqD7K+c1XgNR24=;
        b=u7WlF4SxaQm2h+3dYqg3kdmPe2qk4X1jqKGNac0T9GputiCsKB3HzWejlEg3L4qnOb
         hvFs+6OSK8FG14QsWB/EnDKXS/q0HW/327y0Ff/7zGrfXoiGQWrtdPYXXneP+6ExvpER
         DJULVIiv1CPzHbztRPzDU6h4iIM5WcqLlmbmo=
Received: by 10.205.120.10 with SMTP id fw10mr395114bkc.94.1329275597252; Tue,
 14 Feb 2012 19:13:17 -0800 (PST)
Received: by 10.205.34.200 with HTTP; Tue, 14 Feb 2012 19:12:57 -0800 (PST)
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190807>

Apparently setting merge.conflictstyle to diff3 will display the base
when diffing an incomplete merge, instead of just ours and theirs.

Is there a way to run this command without setting the config, so that
I can switch between normal diffs and diff3s easily?
