From: Tobias Preuss <tobias.preuss@googlemail.com>
Subject: wish dies when ibus is restarted
Date: Thu, 28 May 2015 14:33:36 +0200
Message-ID: <CADEaiE_EezCYRmjcB9eoadHkS92HWZEtk=x5EOg=xDkSUE8O-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 28 14:34:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxx0m-0002en-PK
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 14:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbbE1MeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 08:34:01 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33426 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169AbbE1Md6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 08:33:58 -0400
Received: by wicmx19 with SMTP id mx19so122072569wic.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=V49/woA2sCSZCdhVpG2AbG2M/2/+L9KQ2857lhYEXu8=;
        b=c7FgFzXynfSa6lvm1sM2GcOvY38ghPLfrzujEX2N0kMSr2GmDGRMUaW+LRExdvVPcG
         vtAG8oW3J8OyVaf0IPzR4KQ7nPcH0g2IajaBdbCSWRGrFiwDB/xGvdPc5gQjP+WTa66E
         9AKMVspI4eaM5PO+weI4xcphp7V2bkfwecn/OEGxZPRVK0I0xI3sGA57ITZu8ogZ+uN7
         T7ScFqze0YQ6SCFEQ0F37l5N1mzRJ9ZtE3MPToOwE+LaTnQeyGTHBR3zl2R+zJEVrrTb
         tTtIOBomRXgnZSC3N8Ijbnmzr9OX7FhIg0tttVDv5u3l78K/pbI4zDOU4UtZa0srSKLg
         FHng==
X-Received: by 10.181.13.198 with SMTP id fa6mr61417553wid.41.1432816436658;
 Thu, 28 May 2015 05:33:56 -0700 (PDT)
Received: by 10.194.74.195 with HTTP; Thu, 28 May 2015 05:33:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270144>

Hello.

Recently, the guys from Google have to deal with an issue in Android
Studio where the user can no longer type in the IDE.
Their workaround is to restart ibus via "ibus restart", which works
more or less [1].
As a side effect I noticed that wish and therefore gitk and git-gui
die as soon as I execute the command.
I want to let you know about this in case you can do anything about this.

Best, Tobias

______
[1] http://tools.android.com/knownissues/ibus
