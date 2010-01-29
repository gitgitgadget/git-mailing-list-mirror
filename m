From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 12:27:56 -0800
Message-ID: <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron1 <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:28:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaxS5-0007j3-2G
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab0A2U2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 15:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667Ab0A2U2R
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:28:17 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:59770 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab0A2U2Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 15:28:16 -0500
Received: by pzk2 with SMTP id 2so1903521pzk.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4G9HIxU35VE3G9Aiqa/XylEVLucrGgAaUD9HcP0wo4w=;
        b=N9r4YPRPAZoLJoJW7oN9cqeppkhSCP7IKulWKzI4jdMfGbyIE494zyEDy+2bh3YKvi
         maBY5MyvuTT8T0riHFLA3AGR+aQD6f4Wr2OacKRizA0JHbKG0lsJVtXlRtqw+rKXqm8B
         eEzNj4n0iY+/1RLxMsMluUd+xU/bbStROOIBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tpt8sKfm/IrKtqeIIuEzjT+8AX4Yg3DqUVAuZgp1qpPY19NAMzeU1RNK6IbC5Fi8Dn
         VrlLBGv/BsUgIxc2l6MtC31+6jMBbFNpx3Y1EdDyDUZDj7ZHzTknlhT/CYxKy3x/otkk
         dWKtPbvbEI/1T6bgM6daZk83U2wnIi6Zbwf4o=
Received: by 10.140.83.9 with SMTP id g9mr870573rvb.136.1264796896073; Fri, 29 
	Jan 2010 12:28:16 -0800 (PST)
In-Reply-To: <ron1-2E17EF.12204629012010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138347>

On Fri, Jan 29, 2010 at 12:20, Ron1 <ron1@flownet.com> wrote:
> [ron@mickey]$ git checkout master
> Already on 'master'
> [ron@mickey]$ git checkout master^
> Note: moving to 'master^' which isn't a local branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
> =C2=A0git checkout -b <new_branch_name>
> HEAD is now at 7be05e0... test
> [ron@mickey]$ git branch
> * (no branch)
> =C2=A0master
> [ron@mickey]$
>
> Huh?!?
>
> This is a test repository which has never been pulled from nor pushed=
 to
> anywhere. =C2=A0So how is it possible that I have a non-local branch?
>
> Thanks,
> rg
>

master^ is a commit (the first parent of master), not a branch (local
or otherwise).
