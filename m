From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] rebase -i: in-editor documentation nits
Date: Sat, 15 Jan 2011 19:59:41 -0600
Message-ID: <20110116015941.GA28137@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jan 16 03:01:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeHvT-0003eP-GY
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 03:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab1APB75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 20:59:57 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59587 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab1APB74 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 20:59:56 -0500
Received: by gxk9 with SMTP id 9so1568785gxk.19
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 17:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zGzar+xnbmRkYnukeuYBo9bluWXTznkJd0xCBz2BK78=;
        b=Jfu2pfD/LJsKTcqsMoMbB9TQnvVr27Oi/+NA5KjmS6Qzkhz5VveEol16eR7G/q32y3
         n+uouXtmQ81jxGvosreMb6V67IMhn0KAYLzfaGQj2nvwPUm8P5XDBShqOn1cY5E68u16
         qrEHAW4HX8b6FjPhycFhz+iCkJ0jdGOZqchbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Jp1ghAiZzw2GSqRnzooWFwuzc/79GMfuv7ayqa0QEG4IP5BV0aThlrCe9ebQ7NJxlk
         YSGRAyk0wLCW37rOwaeOXi4Y/Xz7C6kyWPW8EMh+lia8Nid1fmjUiEqkjAPkeuEH1RZm
         vrfgBYGA1wA1evIUsov0G7945g9lFStwV6uk4=
Received: by 10.151.26.5 with SMTP id d5mr2948760ybj.179.1295143194117;
        Sat, 15 Jan 2011 17:59:54 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id j3sm1805378ybe.11.2011.01.15.17.59.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 17:59:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165150>

Matthieu Moy wrote:

> +++ b/git-rebase--interactive.sh
> @@ -957,6 +988,7 @@ first and then run 'git rebase --continue' again."
>  #  e, edit = use commit, but stop for amending
>  #  s, squash = use commit, but meld into previous commit
>  #  f, fixup = like "squash", but discard this commit's log message
> +#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
>  #
>  # If you remove a line here THAT COMMIT WILL BE LOST.
>  # However, if you remove everything, the rebase will be aborted.

Nit: the "exec" command is formatted differently from the commands
around it, making it stand out (which I don't think is intended).

While we're there, patch 2 adds some brief documentation for the
"noop" command.

Roughly based on [1] (which might be a nice patch to revive, by the
way).  Sane?

Jonathan Nieder (2):
  rebase -i: reword in-editor documentation of "exec"
  rebase -i: explain how to discard all commits

 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/161120/focus=162079
