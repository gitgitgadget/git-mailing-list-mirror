From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: "trying out" gitolite with minimum impact on a system
Date: Wed, 12 Oct 2011 08:15:42 +0200
Message-ID: <CAGK7Mr6cnP6QQwGswWwQYiGR2_BUjMPz+VsygQXb0Voehm+akg@mail.gmail.com>
References: <CAMK1S_g5CnP+vrE71cqMgcjpj8ocE+wdtA2vPjeaXGCRNt25Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 08:16:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDs70-0006bQ-1w
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 08:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab1JLGQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 02:16:13 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36502 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1JLGQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 02:16:13 -0400
Received: by qadb15 with SMTP id b15so278398qad.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nWR2eZi1B7xNC5lknhRDtn1XhFEzQfQ+jLzK0CVpQGU=;
        b=fPdzf2lMBbMkmh014idieVVypCaZys6oDFbaQKV6wiJHTGaeXM+bNQCmJrtZahelPL
         JQ9sE2ecigQfbk5HqqKwDpISMgAOjNdeHxkOgMSFW64gYQLdBkC7uYbOlnIvATjyb7o8
         e/mNIyqfvGScg3WSQeMZlAlTSFrOe53dZ3w2k=
Received: by 10.229.72.84 with SMTP id l20mr4842363qcj.60.1318400172446; Tue,
 11 Oct 2011 23:16:12 -0700 (PDT)
Received: by 10.229.185.204 with HTTP; Tue, 11 Oct 2011 23:15:42 -0700 (PDT)
In-Reply-To: <CAMK1S_g5CnP+vrE71cqMgcjpj8ocE+wdtA2vPjeaXGCRNt25Dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183356>

> After that, entirely within that user, you have an admin user and six
> normal users, to do with as you please. =A0You emulate different user=
s
> simply by using a different username in the URL, like "git clone
> u1:reponame" versus "git clone u2:reponame".

Hum, except if I missed something the classic way to use gitolite is
to always clone using the same user (git@host:repository.git), and the
"real" identification is done by the ssh keys (which means that
contrary to plain ssh you lose the ability to have two users with the
same ssh key, which should never happen anyway).

But maybe you're refering to an alternate authentification mechanism
within gitolite I'm unaware of.

Philippe
