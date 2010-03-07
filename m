From: Thomas Anderson <zelnaga@gmail.com>
Subject: Re: error: failed to push some refs
Date: Sat, 6 Mar 2010 23:04:03 -0600
Message-ID: <15b345f1003062104p67edcde9pba7cf6000d4d7a2c@mail.gmail.com>
References: <15b345f1003061815y52a4e842u9373731cecd8ec60@mail.gmail.com>
	 <20100307021848.GI2529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 07 06:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8ey-000124-Te
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180Ab0CGFEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:04:07 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39273 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab0CGFEE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Mar 2010 00:04:04 -0500
Received: by pwj8 with SMTP id 8so3157775pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7g6X2sCxCjrRJZtdPXGKJMT9jc17jHGvLkWoOtiXkqw=;
        b=ZT4uvpUBk6vKkhjm/+J0iOz6wsRQZogaRcvl3KiRNAdrulajrXJoRLdNiNHP12XcAr
         mGPHfZHXRzpah7RXH7qhW7NkZJr9aCrLOJ160Sb/5P6N9hP5G/d06RCFMzBPsxQGUcX7
         ZQQkpdGV7lhxCMNQDQxWrWz5UweY538eyUNNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P1+j4uoo4CMsFZcG7OrDxdcGYKLSsLe+KAmTb++xODlWC0z2YZiDE2GhVZl+tsIGZL
         xyfHsa9GgOgEA6nJmShtYy7HBg0pEZzxuw/h1M+VeOjdkY5ZylZS1yT6k9beOGtygsip
         ExpmYTk1zeZrtTiv2IJh7MReYkrak7KVmNLvU=
Received: by 10.142.119.9 with SMTP id r9mr2060829wfc.201.1267938243660; Sat, 
	06 Mar 2010 21:04:03 -0800 (PST)
In-Reply-To: <20100307021848.GI2529@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141663>

On Sat, Mar 6, 2010 at 8:18 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Thomas Anderson <zelnaga@gmail.com> wrote:
>> I cloned git://github.com/symfony/symfony.git to C:/git/test-root an=
d
>> then cloned C:/git/test-root twice to C:/git/test-clone and
>> C:/git/test-clone2. =A0I modify the README file in C:/git/test-clone=
,
>> stage it, commit it and then try to push it to C:/git/test-root and
>> get this message:
>>
>> To prevent you from losing history, non-fast-forward updates were re=
jected
>> Merge the remote changes before pushing again. =A0See the 'non-fast =
forward'
>> section of 'git push --help' for details.
>> Pushing to C:/git/test-root
>> To C:/git/test-root
>> =A0! [rejected] =A0 =A0 =A0 =A0master -> master (non-fast forward)
>> error: failed to push some refs to 'C:/git/test-root'
>>
>> What does that even mean?
>
> Exactly what the message said to you:
>
> =A0To prevent you from losing history, non-fast-forward updates were =
rejected
> =A0Merge the remote changes before pushing again. =A0See the 'non-fas=
t forward'
> =A0section of 'git push --help' for details.
>
> Someone else (your other clone) modified your project in the interim.
> To prevent losing their change, you need to use `git pull` to bring
> in their work, merge it with your own, and then you can push it to
> the destination.
>
> For more details, check the `git push` manpage section suggested
> by the error message above.

How do I do "git pull" with Git Gui?  And in any event, if there's a
conflict, I wouldn't want to overwrite my code with the code on the
server - I'd want to view a diff so that I might resolve the conflict
by hand.
