From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git rebase command and docs questions
Date: Fri, 9 Apr 2010 22:37:15 +0200
Message-ID: <r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com>
References: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 22:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0KxU-0000jY-TC
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 22:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab0DIUhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 16:37:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48791 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab0DIUhj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 16:37:39 -0400
Received: by gwj19 with SMTP id 19so10222gwj.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7yPszLw2si9xON4AxRZP/oQi9WANYlMiF0qMb9w3bkQ=;
        b=NhxcO+fBFZh4Gsf2oMvZ0BxDtWNcFP0ugU8aQw66mw8MByNTq4CqBWQgRGmGnmEwMc
         Rw9G1ykhWm32za0foknL3MNx+45qhX4mbdbD/bESMgY29NnN+rPAh/OFjocezy78lrua
         bYKc82wGRIBaCdIeqXTpjdPWpfLhocBNwG0AU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=m+cB9PKetltGTTuBZNYCE3YgK6rTBLs05chZaSzMVE87NR9FVlcw8JbEHndEEdCQcy
         NTfpn/37PMuukyWkRXohSJsVQ6Op823k5dIw14+LDudWhfy38eePYf27fkXVS2RM24Ea
         MBWCLeq/QgybHB1bhMThvNXu4D4tzkvbxuNtw=
Received: by 10.100.206.13 with HTTP; Fri, 9 Apr 2010 13:37:15 -0700 (PDT)
In-Reply-To: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com>
Received: by 10.101.202.17 with SMTP id e17mr944021anq.73.1270845457355; Fri, 
	09 Apr 2010 13:37:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144469>

Heya,

On Fri, Apr 9, 2010 at 20:49, Eugene Sajine <euguess@gmail.com> wrote:
> But, in =E2=80=9Cgit rebase =E2=80=93onto master next topic=E2=80=9D =
the meaning of the =E2=80=9Cnext
> topic=E2=80=9D parameters is different: as I understand, it actually =
specifies
> a range of commits from next to topic, =C2=A0because =E2=80=93onto ch=
anges the way
> the whole command is working, but it is not clarified in help. Is tha=
t
> correct understanding?

I've never been able to remember how rebase --onto works, perhaps if
we actually let users specify a range it would be more intuitive?

$ git rebase next..topic master

--=20
Cheers,

Sverre Rabbelier
