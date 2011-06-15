From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Test 9500 - unhelpful without Perl::CGI
Date: Wed, 15 Jun 2011 09:26:03 +0200
Message-ID: <BANLkTinAfqysABm+t_NkOGO2U+iy57WbVQ@mail.gmail.com>
References: <BANLkTikj0GQCN94PvZz6n6fJJb5sHMApig@mail.gmail.com> <7vmxhjk539.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 09:26:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWkV0-0007UE-KL
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 09:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab1FOH0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 03:26:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37839 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab1FOH0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 03:26:44 -0400
Received: by pwi15 with SMTP id 15so203309pwi.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ZudNxGizff/F0HhChC3jUzTyGGod/HpzZW44P4Bngug=;
        b=eGaAETDPSl6fOw8dHRfpt0frzbZseA0acr/VIWmZyC7sF4NJwKiIymTPFwjzxIbUVj
         JfzWpKBiuOB/eIlFgJ8Mrjz8B87gvtZdjYkrE2oZlVn0tAKIlRsSx9yq+xeFE5jOcr8j
         5Q5ck15LwWkdZZEoQvM62Ho62taHTawbjTrsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LdTcc5sqVgyJ7OTTpg0kCECOjpiyQ8o7qKcbhZvzlKQkZxjhIhf2RLzcC6bJ2glWiG
         o5b/5kNHNVuucXv6wHiaSrxjqKruhGKNAaNEmY/XOrC845ZmDAmiM17n9ggvbz0AvKqW
         Q0kHfCbqaXRLl1kMTwBg8fhHOyENbDlWkfg54=
Received: by 10.68.2.42 with SMTP id 10mr83192pbr.8.1308122803394; Wed, 15 Jun
 2011 00:26:43 -0700 (PDT)
Received: by 10.68.41.99 with HTTP; Wed, 15 Jun 2011 00:26:03 -0700 (PDT)
In-Reply-To: <7vmxhjk539.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175809>

Heya,

On Wed, Jun 15, 2011 at 07:59, Junio C Hamano <gitster@pobox.com> wrote=
:
> +perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2>&1 || {
> + =C2=A0 =C2=A0 =C2=A0 skip_all=3D'skipping gitweb tests, CGI module =
unusable'
> + =C2=A0 =C2=A0 =C2=A0 test_done
> +}
> +

Isn't the new style to use test_must_succeed CGI_AVAILABLE '...' '...'
rather than skip_all+test_done?

--=20
Cheers,

Sverre Rabbelier
