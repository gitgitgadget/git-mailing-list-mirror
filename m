From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Sun, 13 Nov 2011 16:14:12 +0530
Message-ID: <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXYF-0007qD-4J
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1KMKof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 05:44:35 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43501 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1KMKoe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 05:44:34 -0500
Received: by wwe5 with SMTP id 5so3159559wwe.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TQxoel1AmMveaeaHwpBjff0+dIyeqou4YpE3+B4KEZo=;
        b=nJc+mDcqAlpSTkoMn49e98wQO6CH9CBC068WGKsWBCq01vcpB9LAr+mjbFVCAcAzQo
         MDHyXgMWul9ZOEU8QyEK30tdD6UhJhpNUOP0I0NLC6FP9ETHj3I0otposnmyYUsr+tfT
         rVlRPCvJgNqFLGoM7rs5RLWHCfBnBgWY+TO10=
Received: by 10.216.186.196 with SMTP id w46mr417895wem.24.1321181073406; Sun,
 13 Nov 2011 02:44:33 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Sun, 13 Nov 2011 02:44:12 -0800 (PST)
In-Reply-To: <20111106002645.GE27272@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185329>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
> [...]
> The usual commit-message debugging strategy applies here: imagine you
> are a BIOS clone manufacturer, and for legal reasons you are not
> allowed to read this part of the git implementation embedded in the
> standard BIOS. =C2=A0However, you are allowed to read the commit mess=
age,
> and if that message is clear enough, it will explain the purpose and
> behavior of that code and you will be able to implement a compatible
> implementation addressing the same problem without scratching your
> head too much.

Ah, it helps to think about commit messages like this.  Thanks.

>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -654,11 +654,15 @@ static void walk_revs_populate_todo(struct rep=
lay_insn_list **todo_list,
>>
>> =C2=A0static int create_seq_dir(void)
>> =C2=A0{
>> + =C2=A0 =C2=A0 const char *todo_file =3D git_path(SEQ_TODO_FILE);
>> =C2=A0 =C2=A0 =C2=A0 const char *seq_dir =3D git_path(SEQ_DIR);
>
> Scary idiom.

What's scary about it?

-- Ram
