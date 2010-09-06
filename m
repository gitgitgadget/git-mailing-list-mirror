From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Should git-citool be in mainporcelain in command-list?
Date: Mon, 6 Sep 2010 21:27:13 +0000
Message-ID: <AANLkTi=Hn_GG1y3gkVxgnsKyVD+VutG5SU5HhmhRfktH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 06 23:27:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsjDk-0002jQ-6B
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 23:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab0IFV1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 17:27:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62886 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741Ab0IFV1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 17:27:14 -0400
Received: by iwn5 with SMTP id 5so4609883iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ag8mngM8iF+/4AiNo9OZMicwGgenvGzA7WO2ADc5t+s=;
        b=WY5I+hinIB7LmpSyShHyphPNYgwsamC17PhfEag/fM8qdf61fLgwAJBgEssoHEvK6J
         K5f6JLlkB5OTpl6lSI/puA2uNR8zm4nqFhMr4l1z0Y6EnQbsV/Y5LtiwCHsv8uDVHDmX
         +4cnISLJhRf/bXt0epFlEOcAa8GpBFYDYD91A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=legpK8215PW4BXH6TfFnuUsuabNoPzm7BN3hIZIFvHKQTbM8IOyoOFjF6pXxL8mE5a
         8rXa6zFr8NRzLNTm+R3NH4adGQmvsLcVFAY5yRIl3PIfdBtq3brQOsl09pnmeouqtbFt
         PJum9GdiHhJNaslyqnuKRPYC5SW7IS+AJzlt4=
Received: by 10.231.146.134 with SMTP id h6mr6809203ibv.170.1283808433498;
 Mon, 06 Sep 2010 14:27:13 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 14:27:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155626>

Maybe there should be an aliases category:

    $ grep -e git-gui -e citool command-list.txt
    git-citool                              mainporcelain
    git-gui                                 mainporcelain

A very minor nit, just something I ran into while gettext-izing and
wondered "what's that".

But I'm probably the only one that's used command-list.txt for
anything non-Make related in a while :)
