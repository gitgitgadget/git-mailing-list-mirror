From: Pat Notz <patnotz@gmail.com>
Subject: Best way to get number of insertions and deletions from a diff?
Date: Wed, 13 Oct 2010 13:21:27 -0600
Message-ID: <AANLkTinJuuxOZ2DvCSc2Nb0DAjwmJEyJXeGLHsLkyM1B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:22:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P66ti-0007tj-2y
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab0JMTVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:21:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59627 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0JMTVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:21:49 -0400
Received: by fxm4 with SMTP id 4so1911924fxm.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Lof7bqhGa0kCsXMG6xUItSEd4VLxqPMK1oyFLDwttiU=;
        b=PxotggbcOC1YieErzAH1mGPLUr9owZaWvO48AYoxmhqU3rHp6AwOmp7um4mbyeJttM
         Q4WhMuBeNstQvlFlSwhVi2572ZFMK4P7epdjiadsl6zsZzrtMuLxGeZrPrWvr76w+qnP
         pqmiOQ22XlXyA6FUEP1m2fML/QdsNl5MHbkek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=TQXikaxgwKwqjo6lJ7OeNipt/TXreCg9NcZppZRZkEkcJqf7wMPvfhxedsEFU2sr4r
         PneF3qbhIoB7bffFMbDwz46+fEBpKTnG2xLsrjmptW6bQTKXIEng2FHbTcpenzHwBLyE
         WVOfWVgAI/5lcLuk/iGChgdxf5DrtR8DpEpgs=
Received: by 10.239.163.67 with SMTP id o3mr481496hbd.207.1286997708024; Wed,
 13 Oct 2010 12:21:48 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 13 Oct 2010 12:21:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158961>

I'd like to probe various commits to see how many lines were added or
removed.  For example,

$ git diff --shortstat HEAD HEAD^1
 3 files changed, 5 insertions(+), 5 deletions(-)

That's great but I'd like to do this from a script and parse out those
numbers.  Is there a more plumbing-level way to do this that would be
more robust?  Or, should I just parse this output?

Thanks ~ Pat
