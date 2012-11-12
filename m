From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Candidates for sequencer?
Date: Tue, 13 Nov 2012 03:16:51 +0530
Message-ID: <CALkWK0n0tTZ3EgzeesOr2B1LjeEUjTnWQh5dDfW28jA1ia0-gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:47:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY1qo-0007eP-OP
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 22:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab2KLVrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 16:47:12 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49484 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab2KLVrM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 16:47:12 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6751248obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 13:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=DixwQ/sQ0CK7JN9025CLRi9wr8eEKkWgCrrIk3Ponps=;
        b=Jjdb8klC8qBO1CLPVfIPP+RqbjnC2KfsKxDAYCebLhC/GY1S+9v503vF36fvYWyf3e
         72YqjvOryc08JvkTldm8IVX3S+m+eCLDDDH0mWoG6hhnYRvVtvI7twzPeayxHI9Y09LA
         4k7xvBQU92RQ66IW+YCdLc57Mv9x067In9HKbU9rhY2rfsFzIuSEblHU/kIAFSerPy/Q
         kCcqzYicb0DQSRm2faltGY5YBzdl2sEzdMnNQ3u1dP/iSCA5ATTCU4lRpqcZlldlNFrv
         EM3AdhTj0Opy3V2ejxWr2sdxWsKId2hJjaJGI7Wr/ljin7tNXKwMnNY6BISxyCeNRbeU
         6p0w==
Received: by 10.182.240.109 with SMTP id vz13mr12761919obc.81.1352756831730;
 Mon, 12 Nov 2012 13:47:11 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Mon, 12 Nov 2012 13:46:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209532>

Hi,

I'd like to get more commands to call into sequencer.c, so that we can
(finally) implement a sensible `git continue` and `git abort`.
Currently, am and rebase come to mind, but they are shell scripts and
I don't see how we can make them call into sequencer.c.  Is there any
way to make sequencer.c more useful?  Should we implement a `git
continue` and `git reset` anyway, lifting code from 83c750ac to check
the tree state?

Ram
