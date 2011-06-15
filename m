From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Wed, 15 Jun 2011 13:03:42 +0530
Message-ID: <BANLkTikCB7t4DhCxjLT-JABsUuksPBhkLw@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
 <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com> <4DF74EEC.1050506@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jun 15 09:34:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWkc6-0002ND-4v
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 09:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab1FOHeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 03:34:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44282 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab1FOHeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 03:34:04 -0400
Received: by wwa36 with SMTP id 36so156226wwa.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 00:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HYfnAc06jp7YHIVxLnWulJ96zwCiqKuYiqnLROMahIs=;
        b=M3MgCZn8hInumT70ZaR+Eq5tw6k9NZTq3DaFW29JXBG3g1SaZv/1u/5q6XvXHsAYeo
         G5ozRkFNXmotn9hh6xIFVtbkw3QnxshzaSz0TGoVGUuv9kcqNVn9rxfwnO3ICerlKcK5
         7tkeboB0MPb48tL2CvQ7+eQXdaDiXf1+onnLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=W9BEt7fW1rC1Unyy/2BRWSIZbZxYZFCn+Ebe6IiXKZFSED/qNDSesX5TjE7Ihgk38E
         qeSfIirYjH0jz0KOwa40iQ+ZwCthl9NsqvCCqlPecn/zIQiKSImHQ+9dn60VL3KWYXkI
         1wzEma+MOJWS3Wgeb2ykDajKn5K2nsgYrEPLg=
Received: by 10.216.143.7 with SMTP id k7mr173962wej.95.1308123243164; Wed, 15
 Jun 2011 00:34:03 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Wed, 15 Jun 2011 00:33:42 -0700 (PDT)
In-Reply-To: <4DF74EEC.1050506@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175810>

Hi Andreas,

Andreas Ericsson writes:
> Historically, a translation for one language has been considered "one
> logical change" in that respect. I think it's safe to assume that if
> we want translators to stick around they shouldn't need to divide their
> changes on a per-message or per-command basis. Especially since such
> divisions wouldn't be very easy to do if all you've got to go on is
> a pot-file.

Fair point.  How do we work around this?
1. Can we relax the requirements for contributing translations?  To what extent?
2. It think one commit per edit-session per language sounds sane.  If
people just go around translating some random strings that they like
(which is often the case), what is the sense in asking them to write a
commit message? Maybe we can write one ourselves before committing it,
provided they signoff on all the commits? Maybe there should be an
auto-signoff option too?

-- Ram
