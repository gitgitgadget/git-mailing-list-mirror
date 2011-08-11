From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git-mergetool: wrap tools with 3 files only to use the BASE file
 instead of MERGED
Date: Thu, 11 Aug 2011 11:48:01 +0200
Message-ID: <CAHGBnuM=nadYNOH8rPzenttYmNwyz04FsPyvavWD1UDUbF4v8A@mail.gmail.com>
References: <20110810160356.GA32126@ortolo.eu>
	<20110810161211.GC4076@elie.gateway.2wire.net>
	<20110811083835.GA29507@gmail.com>
	<20110811084955.GA31233@elie.gateway.2wire.net>
	<20110811093731.GB29507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 11:48:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrRs1-00060H-0q
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 11:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab1HKJsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 05:48:04 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52002 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab1HKJsC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2011 05:48:02 -0400
Received: by qyk38 with SMTP id 38so3388824qyk.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XMQm0b4tydoGH7CjMX/zazYqFb+emea8goqwV26i8uM=;
        b=gpt5Oq7qFMXGy2w4fpAyKDELdOpGEkrdN4Bsn5qYuQWC/L316M8EwVoC6m10fJHSb3
         IRGkJfX7nv5tyCwy57VBAw5QkCZ7im8xbbEGA3IK0zjFthgkJr9N+zMs43g1ai5Z9Ptz
         myx3cOGYYUZIfQJ8yKWkO6gVil3edAJu9ShHQ=
Received: by 10.229.98.83 with SMTP id p19mr7166903qcn.91.1313056081371; Thu,
 11 Aug 2011 02:48:01 -0700 (PDT)
Received: by 10.229.182.11 with HTTP; Thu, 11 Aug 2011 02:48:01 -0700 (PDT)
In-Reply-To: <20110811093731.GB29507@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179098>

On Thu, Aug 11, 2011 at 11:37, David Aguilar <davvid@gmail.com> wrote:

> What's the best way to use this and not break existing users?
>
> meld v1.5.0 was released in December.
> We could parse `meld --version` and use the new --output flag on
> newer setups, leaving old setups alone. =C2=A0That's a lot of
> code to carry around but it's nicest to users.

I'd definitely prefer this solution, as it's the most convenient for us=
ers.

--=20
Sebastian Schuberth
