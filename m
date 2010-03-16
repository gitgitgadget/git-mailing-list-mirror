From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Tue, 16 Mar 2010 07:26:26 +0100
Message-ID: <fabb9a1e1003152326m4d67f48bkc207ba7368cb54e4@mail.gmail.com>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com> 
	<20100315213221.GA12941@vidovic> <7vhbohi80n.fsf@alter.siamese.dyndns.org> 
	<buovdcw6fjj.fsf@dhlpc061.dev.necel.com> <7vljdsu7kc.fsf@alter.siamese.dyndns.org> 
	<fc339e4a1003152320i12a7d4b2p711f6b5d0eda9bcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 07:26:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrQEw-0003rE-Q1
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 07:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966022Ab0CPG0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Mar 2010 02:26:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39427 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966019Ab0CPG0q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 02:26:46 -0400
Received: by pva4 with SMTP id 4so317653pva.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=94D/QoePQkICC5lVtnFlGwYU/jEFwOEDqBZMOgudWLY=;
        b=j0mb+5YPPKpqClYSiu62475s+Np5KgXQMfFh66xGIKPz8awYi/2/cepVI6jWwWk1wc
         QJOJUGjziTJrbhY43i/J5QbhIpiqyriLy/eTGieCfgX98ot6U1v6lg/M9363PuHpTjBH
         G7WTo9Ske1QVl8egVqaXzxDw1YkDWbi5u7gSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i6aHEnmPPK9iIwKhZOi3ylm0SrdWHpK9aD5f+WIi9qBoTplOaRkQEUSNnsN9ovLltl
         rXWHWh3kRywyLlJZEl1S5aEHUV907E9//vr8kbmo92o5Wvsf94Qux+WZMke8o+weARvn
         rbVqB1ygFcAvAS7vu8Vrej5+oW6oKh6ID6emg=
Received: by 10.142.59.4 with SMTP id h4mr3053705wfa.250.1268720806131; Mon, 
	15 Mar 2010 23:26:46 -0700 (PDT)
In-Reply-To: <fc339e4a1003152320i12a7d4b2p711f6b5d0eda9bcd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142322>

Heya,

On Tue, Mar 16, 2010 at 07:20, Miles Bader <miles@gnu.org> wrote:
> On Tue, Mar 16, 2010 at 3:03 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> If you mean by "publicly visible" branches in public repositories, I
>> suspect not. =A0At places like repo.or.cz, github, or installations =
managed
>> by gitosis, you typically do not have direct access to $GIT_DIR/conf=
ig
>> files (they belong to site administrators) in your repositories, and=
 that
>> is not likely to change for security reasons.
>
> Hm, ok you're right... which is a shame... :(

Which is also why I think it would be nice if we could teach notes to
annotate branches/tags/the whole shaboodle. I really think that a
generic way to annotate something under /refs/ would be useful.

--=20
Cheers,

Sverre Rabbelier
