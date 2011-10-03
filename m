From: robert mena <robert.mena@gmail.com>
Subject: Re: Unable to remove a file
Date: Mon, 3 Oct 2011 16:57:17 -0400
Message-ID: <CAAZ43xa43YjO7Vqw87cYnXhJWvsZT_ocPpLuJ81jCPc8KKRczw@mail.gmail.com>
References: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>
	<m262k6jc2c.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 22:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RApZx-0006S2-6f
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 22:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab1JCU5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 16:57:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40258 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756961Ab1JCU5U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 16:57:20 -0400
Received: by eya28 with SMTP id 28so3234489eya.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=s7jLfi4IH7sOaF2GrPAGw503ODoC5/JLPdfw4WnX1mQ=;
        b=wzXyQTjbMhe4omjkc766ELkq/NNUoiU4YipH0/gnzaBbIrE5exofHFMZMiXWIUqeAZ
         Po/s2axBI59NyW2xT+K+AD/h9m1n+9pbQN71rsqpXG8VEfPWzhhu5tVxsKQYE20AtoCi
         HNHL58aFjNWnC7iQXxb7yk7mVB/OmrGlBvY7I=
Received: by 10.223.36.68 with SMTP id s4mr477610fad.92.1317675437782; Mon, 03
 Oct 2011 13:57:17 -0700 (PDT)
Received: by 10.223.104.66 with HTTP; Mon, 3 Oct 2011 13:57:17 -0700 (PDT)
In-Reply-To: <m262k6jc2c.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182712>

Thanks.

It accepted the command but rejected my push.

git filter-branch --index-filter 'git rm -q --ignore-unmatch --cached
scripts/\\' HEAD
Rewrite 5ac83187fa298add60cf81fd1d54b194da7ae783 (57/57)
Ref 'refs/heads/master' was rewritten
git push
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'git@myserver:repository'

Should I do anything special?

On Mon, Oct 3, 2011 at 12:04 PM, Andreas Schwab <schwab@linux-m68k.org>=
 wrote:
> robert mena <robert.mena@gmail.com> writes:
>
>> I found the command filter but it is not working.
>>
>> git filter-branch --index-filter 'git rm --cached scripts/\\' HEAD
>
> $ git filter-branch --index-filter 'git rm -q --ignore-unmatch --cach=
ed scripts/\\' HEAD
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756 =A001D3 44D5 214B 82=
76 4ED5
> "And now for something completely different."
>
