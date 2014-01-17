From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] .gitignore: Ignore editor backup and swap files
Date: Fri, 17 Jan 2014 13:20:55 +0700
Message-ID: <CACsJy8DcrR0Rgp0cE+Va2ZBfvtvEJiFxkoXMrkwPj9bn621m9Q@mail.gmail.com>
References: <1389907164-13400-1-git-send-email-alexander@plaimi.net>
 <xmqqtxd3y43b.fsf@gitster.dls.corp.google.com> <20140116224334.GS18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Berntsen <alexander@plaimi.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 07:21:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W42oU-0005Px-2q
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 07:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbaAQGV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 01:21:29 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:60925 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaAQGV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 01:21:27 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so3277398qcq.32
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 22:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1TOxozOdJS6SkgIIl4i54GsZbQrYYEgmc+I0A77K2DE=;
        b=kDXgxKToW+SKlwOP0YJ3l9cDERHmtKMbCyzN/pFu9cnt1Vv/i10eZi3JOkoFh0se04
         LBgExaZcu+Rl409qpb1c+SjeS9J/pni1qkhfjY160yvM2Co1FTdtt7Uy10CL4HXkK0KK
         q6I2/tT6wbHCPjnljM15BQn3tiJqOZ/Vdl+tZ7jfu/2eKmsTIX8f+SwIZeLE6l41VeVX
         U/YtuODw30YgYoo/6uKXBKPi7dzn570ino1p/41jSwuFUQMvQKo94IHy7DB8KFIzKDdW
         dHvpdjGuvakPwZflR1eGwhRw9ICx+y+TeRyfU5d2NX/buToYtTl4Azp52sk3+VvZx+Ui
         QzRA==
X-Received: by 10.229.14.1 with SMTP id e1mr266073qca.15.1389939686924; Thu,
 16 Jan 2014 22:21:26 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Thu, 16 Jan 2014 22:20:55 -0800 (PST)
In-Reply-To: <20140116224334.GS18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240575>

On Fri, Jan 17, 2014 at 5:43 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Subject: gitignore doc: add global gitignore to synopsis
>
> The gitignore(5) manpage already documents $XDG_CONFIG_HOME/git/ignore
> but it is easy to forget that it exists.  Add a reminder to the
> synopsis.

Yes! I knew about the xdg thing but was not aware about
$xdg/git/ignore. No more updating .git/info/exclude on every newly
cloned repo..
-- 
Duy
