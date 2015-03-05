From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Thu,  5 Mar 2015 17:28:09 +0700
Message-ID: <1425551295-28653-1-git-send-email-pclouds@gmail.com>
References: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:28:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTT1I-0003Jm-4R
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 11:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbbCEK2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 05:28:39 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39152 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbbCEK2h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 05:28:37 -0500
Received: by pabrd3 with SMTP id rd3so7979898pab.6
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 02:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SctVUhsHLENL3M/Tw7UToPMBI4vGYD5eHi/k6+Q5/q4=;
        b=U27TFciV2s+sdB1XREMrRSXSeC2bMBZge0O/cAMeE09YJAY6+I7jc8bbNAJ4E+7NRc
         UtHIu9v/AsYS12OliAUucabX49ghCmavwQfmYdnDazAR/aSA1An4Ob2lgtS0Ls7TDSM8
         TqlZpmcMFQys4TMWVcACe6Q6R9tNjFgrZmTWcBu9U6+RxMtd8bqpHHqEKkTa41iOlTPV
         C8Swfj96CmWJiDguiSQD1x8OSQySmej6+rHH7Ul9z3mQXcFVdj+sHzjdobOergxH8TSt
         2SNyXhrKUcdXh5igxzhicXbSTADO4cCIlFS5PEKV4Qldxa+/1mzHq8O0PpaT5uiLqwlr
         nN0Q==
X-Received: by 10.68.172.193 with SMTP id be1mr14837940pbc.64.1425551317263;
        Thu, 05 Mar 2015 02:28:37 -0800 (PST)
Received: from lanh ([115.73.230.115])
        by mx.google.com with ESMTPSA id fy2sm6550162pbb.30.2015.03.05.02.28.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 02:28:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Mar 2015 17:29:08 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264821>

On Thu, Mar 5, 2015 at 5:05 AM, Philip Oakley <philipoakley@iee.org> wr=
ote:
> Given the mention of the GSoC ideas list, I thought it worth writing =
out one
> of my little ideas..
>
>
> A possible idea is to add a date based variant of shallow clone :
>
> =C2=A0'git clone --date <when> ...'
>
> in the same vein as the existing depth (shallow) clone.

I do have plenty of topics to finish up. But I wanted to see how this
feature would look like. I needed to write some code for that and for
straightening my thoughts. Totally untested, but I think it looks cool =
:)

I think this feature is feasible. The protocol and UI are still up in
the air. Plenty of work for any student who wants to pick this up.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  upload-pack: move shallow deepen code out of receive_needs()
  upload-pack: move "shallow" sending code out of deepen()
  upload-pack: remove unused variable "backup"
  upload-pack: move "unshallow" sending code out of deepen()
  shallow.c: implement a generic shallow boundary finder based on rev-l=
ist
  upload-pack: example code to use get_shallow_commits_by_rev_list

 commit.h      |   2 +
 shallow.c     |  65 +++++++++++++++++++++++++++++
 upload-pack.c | 129 +++++++++++++++++++++++++++++++++++++-------------=
--------
 3 files changed, 149 insertions(+), 47 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
