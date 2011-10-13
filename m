From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [Bug] git pull doesn't recognize --work-tree parameter
Date: Thu, 13 Oct 2011 21:55:46 +1100
Message-ID: <CACsJy8AgW8fg3iOKQw=vv2s20hF0PTGD9Py-eMOTBmAv+6CYWg@mail.gmail.com>
References: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 12:56:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REIxZ-0003SJ-W5
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 12:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501Ab1JMK4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 06:56:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35360 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1JMK4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 06:56:17 -0400
Received: by gyb13 with SMTP id 13so1670226gyb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=znSkEHRX/obN9vLTPiFyBeXOQxP7rsFPtoeXlkZYO9o=;
        b=d/JqM6jHIfhloPgKzIthUh1BDVNUf38cfHBJAiFPXmVcHZHm1jku+QSpQAINNXqSqF
         QU2SErt1MD3Aw3BHlWjrQHqysY/2ZJvapzT39ClGup2un+oH2huuZJ895Jaqp2uMLzcm
         eDZyajkPHKzVCk4AvwI+42UgtShFrIT9IaFvE=
Received: by 10.223.61.211 with SMTP id u19mr5322070fah.29.1318503376115; Thu,
 13 Oct 2011 03:56:16 -0700 (PDT)
Received: by 10.223.88.202 with HTTP; Thu, 13 Oct 2011 03:55:46 -0700 (PDT)
In-Reply-To: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183468>

On Thu, Oct 13, 2011 at 7:38 PM, Kirill Likhodedov
<kirill.likhodedov@jetbrains.com> wrote:
>
> 'git pull' doesn't work from outside the working tree even if '--work=
-tree' is specified:
>
> # git version
> git version 1.7.6
> # git --git-dir=3D/Users/loki/sandbox/git/child/.git --work-tree=3D/U=
sers/loki/sandbox/git/child pull
> fatal: /opt/local/libexec/git-core/git-pull cannot be used without a =
working tree.
>
> Note that =C2=A0'git fetch' and 'git merge origin/master' work fine, =
so 'git pull' should be easy to fix :)

Not exactly. git-pull is a shell script and may have problems that a
builtin command like git-fetch never has. An "easy" way is to just
build git-pull in. I have such a (stalled) WIP since May. Thanks for
reminding me to finish my work :)
--=20
Duy
