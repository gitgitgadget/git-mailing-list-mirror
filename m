From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH v4] git-clean: Display more accurate delete messages
Date: Thu, 10 Jan 2013 12:01:00 +1100
Message-ID: <CAKJhZwRxkR=W8a3tmnL7P_BgpYzdHRYMEFsCp+QLcpO8Bz4YaQ@mail.gmail.com>
References: <1357514219-16102-1-git-send-email-zoltan.klinger@gmail.com>
	<20130106234022.GB3823@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 02:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt6WJ-0000jC-MS
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 02:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438Ab3AJBBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 20:01:03 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:63430 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab3AJBBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 20:01:01 -0500
Received: by mail-la0-f51.google.com with SMTP id fj20so820lab.38
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 17:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xlpm3ci2n37IdpSli/uStmToq/ICroNHH2vST7mulhc=;
        b=Xxk1pcM5NnDtbj1nKoE7VD1NfJ0j5kW4CvDgni2Ifm6V4uEfCM/rDum5b5S7j2KCpM
         EstCwwggaRFCuyhebpKHCI/zlamOvs+HBBtrB1amgVYZY3IrJAluXVRaij1jsCvGTnBO
         V+l5PgZIX1Tcu5xxRQIoqzi7zIHd95Le18Fx2tQtNMsonQtUvrWAjUd+YubAdQ2P542t
         nmwMo1EcxjshrHAmr22Fdyx1QsNnqnf+ckRJNkfLUo4KDehfch2AKozWNUAfZKlRe/gK
         6HsC6WU55l3q3rzpm8qRitCbxkvPucXM1SQvHAIq5YAeZukWhVU2acQAqirNIkGQd5rE
         JuQg==
Received: by 10.152.123.77 with SMTP id ly13mr11632356lab.4.1357779660109;
 Wed, 09 Jan 2013 17:01:00 -0800 (PST)
Received: by 10.112.80.98 with HTTP; Wed, 9 Jan 2013 17:01:00 -0800 (PST)
In-Reply-To: <20130106234022.GB3823@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213118>

> I wonder whether it's possible to make the output more consistent,
> as in:
>
>     Removing tracked_dir/some_untracked_file
>     Removing untracked_file
>     Skipping repository untracked_foo/frotz.git
>     Removing untracked_foo/bar
>     Removing untracked_foo/emptydir
>     Skipping repository untracked_some.git
>
> or similar.  What do you think?

Agree, the output looks much neater printed like that. I am going to
update the patch unless someone feels strongly against the proposed
output.
