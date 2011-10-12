From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: "trying out" gitolite with minimum impact on a system
Date: Wed, 12 Oct 2011 13:22:47 +0530
Message-ID: <CAMK1S_juQRRNhCMDx4Wdp+QwAZBQBvBYYQ06AdS_P2fdtLqBtg@mail.gmail.com>
References: <CAMK1S_g5CnP+vrE71cqMgcjpj8ocE+wdtA2vPjeaXGCRNt25Dw@mail.gmail.com>
	<CAGK7Mr6cnP6QQwGswWwQYiGR2_BUjMPz+VsygQXb0Voehm+akg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 09:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDtcT-0002tS-1j
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 09:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab1JLHws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 03:52:48 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50570 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab1JLHws convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 03:52:48 -0400
Received: by qadb15 with SMTP id b15so317014qad.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 00:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mNFSRME0AZ7PEz5GK602w4pdQeS/olmF5lD/yAUcJvs=;
        b=bdQW2op6SFJNDXDfPtfqflQC8RT+zKB6MQL/wPDV6OeE6u5qpnJY8K9qwD9yfXwTks
         I4DK2GZvHle3VwrwXcxiy15pyVxqe/8e+1c80yDtFAOMi7Pixe0guvUeCEuNk39QBEgO
         9kFkQ0lK1kmsGUKmrsJ0mEpKYOiuosNwsFjjc=
Received: by 10.224.218.9 with SMTP id ho9mr17820320qab.56.1318405967530; Wed,
 12 Oct 2011 00:52:47 -0700 (PDT)
Received: by 10.224.20.67 with HTTP; Wed, 12 Oct 2011 00:52:47 -0700 (PDT)
In-Reply-To: <CAGK7Mr6cnP6QQwGswWwQYiGR2_BUjMPz+VsygQXb0Voehm+akg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183358>

On Wed, Oct 12, 2011 at 11:45 AM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> After that, entirely within that user, you have an admin user and si=
x
>> normal users, to do with as you please. =C2=A0You emulate different =
users
>> simply by using a different username in the URL, like "git clone
>> u1:reponame" versus "git clone u2:reponame".
>
> Hum, except if I missed something the classic way to use gitolite is
> to always clone using the same user (git@host:repository.git), and th=
e
> "real" identification is done by the ssh keys (which means that
> contrary to plain ssh you lose the ability to have two users with the
> same ssh key, which should never happen anyway).
>
> But maybe you're refering to an alternate authentification mechanism
> within gitolite I'm unaware of.

you should read "entirely within that user" as "entirely within that
new, possibly throw-away, Unix userid you created".  This is meant to
fit with the subject line's "minimum impact on a system" phrase.

regards

sitaram
