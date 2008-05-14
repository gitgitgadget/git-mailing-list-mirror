From: "=?UTF-8?Q?Iv=C3=A1n_V.?=" <elterrible@ivanyvenian.com>
Subject: Newbie question: Is it possible to undo a stash?
Date: Wed, 14 May 2008 14:56:52 -0500
Message-ID: <509f40850805141256gce6ac1brf5ced6436f81dae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 21:58:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwN6t-00027t-DM
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 21:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763891AbYENT5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763902AbYENT5D
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 15:57:03 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:28120 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763775AbYENT47 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 15:56:59 -0400
Received: by mu-out-0910.google.com with SMTP id w8so41969mue.1
        for <git@vger.kernel.org>; Wed, 14 May 2008 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=yW0erMogG0UgvQp49yW3RjZPNb2jykziRT4VGxMnF5k=;
        b=rtyqMTiFfK8wXUAdiY+cC/1v28oax97dPRNW1F9n1dyBZK8A8nLaq/APTUFj3KhtGQoSnGO4kcoCQzzMJAVZq7c4cMDgd6gic/JcxI6Fb4Ui7inYGI5KzEzPGI4/x7KfvRtmEs+V6AHpG7cRlM39yZbmeJlzh11B/cPEU58xHes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=sLza8OHOapWGH/1gHUFfiteA9ZZ7lAe/0sqRBC2SW5Qh7c95svCLLvYbpP23SFZcrcMjTCJovuvtcKaB2cUIg5kUjQT50K+vcQVVrijPW9yJBlhqu0biE+Fs713B0i8NzRmetdT4d7aQwQJwK4d4vAolBHRWlsOx9acPgLov+mc=
Received: by 10.150.83.29 with SMTP id g29mr1510127ybb.130.1210795012612;
        Wed, 14 May 2008 12:56:52 -0700 (PDT)
Received: by 10.70.57.4 with HTTP; Wed, 14 May 2008 12:56:52 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: e312629600510494
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82140>

Hi,

I just did a git stash, and then changed my mind and ran git apply,
thinking that would get me back to where I was...

Now I have lots of conflicting merges and files that came back from
the dead (and some files seem lost)... I've been trying to go step by
step to try to get the tree to where it was, but it's very
complicated, so I was wondering if there is anything I can do to get
my working tree exactly to where it was before I ran git stash...

Thanks!
