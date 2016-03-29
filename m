From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git difftool help
Date: Tue, 29 Mar 2016 22:45:51 +1300
Message-ID: <CAFOYHZCS4McTJoFzBGDq763-ZNO==3H98sWLHmquZ8b=xek6hg@mail.gmail.com>
References: <CAGZFCEEYYwc=7z5+TRCxE=gR0od2X1oe1WgyhjvO6edb9yyM1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: ratheesh kannoth <ratheesh.ksz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 11:47:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akqDp-00049O-6P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 11:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbcC2Jpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 05:45:53 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36049 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbcC2Jpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 05:45:52 -0400
Received: by mail-io0-f173.google.com with SMTP id q128so15154161iof.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=oxtC/yzQBibJ0wFoG2FLLTDSON7rBalu6PfvUN65OWI=;
        b=qmG2LAd5H9LTjEcM91q04zNt7QT8o8ZK0RQI5UGXmDqN4iPRg9Q8LsieH7HVusUg0B
         yWwsmyVZxHPT5Qxessa3meF1Mv5psZ8W9KV075Phup0Uy4bRdFPHELZPs7srUlt72gSA
         xsIl0ZAyB2+yIrlNce5LYslyVTAteTXvUmc9qdyt4evM4Llbk7j73x9kGTw3TOpKIo4t
         LYXRSfCjwluAc1gP0PUxu0NCTWE8AvltU0hNx92EmbZ5ggzHFKJw3hdjkrJ4hjND4zqL
         u3CAfezfA9ULyesffXzhNR9GwDq1OZZXE00ZP/3FQk8yl43UX8gIySntPjOquoTLF+gZ
         82OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oxtC/yzQBibJ0wFoG2FLLTDSON7rBalu6PfvUN65OWI=;
        b=J32x5RSbgNcesJBCjZyM1xehdjbgCvhegqffgD8yjeV6V7tb384B6YRZeFjAmCIjZu
         AOjf5EXr4Jp8z++VHL6w6DXbjJDuumZGD6soVP0b3ibHn6nW+yyEE3be3B7lah9/42xd
         sBy614Gm2HbgqULPeLsRxCcoTnZVm2ivQyvX6muFXux+H5wD4Prfgw2KKy3pPJ1oIGyD
         QKuKs0xXe/QGa4mEzqGUO0/E7Fx5GvjVtvWj/0AgW6ls64VW+B0fIsDF0TpGlnMwSFWE
         Ip9FwBWlVP1sQkZlbXX5pQnjXk03ztSTMf1dc1Vxtnn2K9lao2TYnYDhFxQ2tgVS1QBE
         ddAw==
X-Gm-Message-State: AD7BkJKqeyRoB1RjMTNirwJmIJS1zdJF8sbfEuMwU3wN7mkxu02Xh/TSks+So5tyDp72IS/ASww4QyhBPAh5vQ==
X-Received: by 10.107.130.138 with SMTP id m10mr1922778ioi.34.1459244751079;
 Tue, 29 Mar 2016 02:45:51 -0700 (PDT)
Received: by 10.79.110.1 with HTTP; Tue, 29 Mar 2016 02:45:51 -0700 (PDT)
In-Reply-To: <CAGZFCEEYYwc=7z5+TRCxE=gR0od2X1oe1WgyhjvO6edb9yyM1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290111>

On Tue, Mar 29, 2016 at 3:07 AM, ratheesh kannoth
<ratheesh.ksz@gmail.com> wrote:
> 'git diff 'is opening in meld. I could not create a patch using -  git
> diff > ./patch-01
> i did not make any change to pick meld, by  default it is picking meld.
>
>
> Which "git difftool" will help to create patch ? i do want to  use
> format patch as changes are not yet committed ?
>

'git diff' is the correct command to display a difference between the
worktree and the index (staging area).
'git difftool' is used to invoke an external (usually graphical) tool
to display the differences.

Perhaps you have some odd configuration causing meld to be invoked
(diff.external maybe). Could you post the output of 'git config -l'
and 'git --version'
