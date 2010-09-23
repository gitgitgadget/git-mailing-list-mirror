From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCHv3 4/4] t7500: add tests of commit --squash
Date: Thu, 23 Sep 2010 10:44:52 -0600
Message-ID: <AANLkTikWzo85QoSCPWHCw4ncf=Ut0GWmnB+6cLcDVCeo@mail.gmail.com>
References: <1285258997-12497-1-git-send-email-patnotz@gmail.com>
 <1285258997-12497-5-git-send-email-patnotz@gmail.com> <AANLkTim=i3UqVTo7_OTr+qCW3JdMLugVBG84M6h9ZXM5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 18:45:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyovE-0005Ux-FR
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 18:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686Ab0IWQpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 12:45:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35614 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200Ab0IWQpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 12:45:13 -0400
Received: by mail-fx0-f46.google.com with SMTP id 3so185570fxm.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UaiWbxfE6dYdjZK2yH8EnXAMidqY5EXLIuHHR3w/uMo=;
        b=Q2LvuVbWkdP3WmOtwCTTdLJPeW6Px1RCUsAgWEoKBVAA4BhmO5TX3SRXJ+DSU37ElG
         Y6yK5gWUIsctJw5A2O0gdfRr//6jEydxOAhEyB/vq8hz6DZZF2ZRvNJrj1JRJSHUcLYu
         efxbF0P0XP8dQxNA5S/yk5mmZfdT7jnq0rRks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qQ1MtWOpra6YU32DW9/cP82p1nkOQuFPXYQJMoMk0QqhAo6bDiJmKgJ8bt/K+FG5xV
         zR0y9CatH8L/MvAWvDH0T5/m6mCuVJnyHbVMgOdOc3vj3r9Txq1ro5/9aM3WX8nntbM1
         8ufJKVHq76hzqbi0oLZKdr2uAAH4h8o342EG8=
Received: by 10.239.184.68 with SMTP id x4mr121849hbg.136.1285260312853; Thu,
 23 Sep 2010 09:45:12 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Thu, 23 Sep 2010 09:44:52 -0700 (PDT)
In-Reply-To: <AANLkTim=i3UqVTo7_OTr+qCW3JdMLugVBG84M6h9ZXM5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156879>

On Thu, Sep 23, 2010 at 10:34 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Sep 23, 2010 at 16:23, Pat Notz <patnotz@gmail.com> wrote:
>
>> +test_expect_success 'commit --squash works with -F' '
>> + =A0 =A0 =A0 commit_for_rebase_autosquash_setup &&
>> + =A0 =A0 =A0 echo "log message from file" >msgfile
>
> Missing &&
>

Wow, great eyes (on both tests).  v4 shortly.
