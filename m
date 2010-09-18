From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: error running git-completion.bash on snow leo
Date: Sat, 18 Sep 2010 07:28:44 +0000
Message-ID: <AANLkTi=7gNFV7Us8EoMccp9Kq1yKDErZMwWiyPSXpwQt@mail.gmail.com>
References: <AANLkTi=VtE9OPKx0+HobC7hcOjeNNMXBG2aQ8vj1FwR1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Wes James <comptekki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 09:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owrr2-0004N1-7d
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 09:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab0IRH2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 03:28:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48625 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0IRH2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 03:28:45 -0400
Received: by iwn5 with SMTP id 5so2588814iwn.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Zjv2kH4zN6UbmhZ5jnZIiAcVmt5V1JnZiRNZ/MequX8=;
        b=OLmhGchiHe15BKFPzP5GjSTnXcRcWNDPtoT7DEOkvn1jOqwOMVorZ9uSJL0VerhmKQ
         OCUFSP+t6C3l9YGYU++fH2v5Thaq3eyxGesVo2AUG8JryucTh1o0nkhxVm+ORUGvXMBc
         tN89tAYqXJzb9vWLJF3ca2Gfwu0uUh6kmZkeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=r8BM6n6rND1C/PN2fEUTfnihgnnWZHAh4sk0ERP8rGHmeww/Hmhn3ktngCJDBgFz09
         bdbTc18NXXvcJBqxXmCzb4SNMLxXRCh7p6pk5ymbqtC20y1p1UfXlX/8qkHFZcILpAJV
         1gJDUsEYsAcvj2PylezT6Yr7SzlnjTzI2k1ug=
Received: by 10.231.177.40 with SMTP id bg40mr5416901ibb.150.1284794924730;
 Sat, 18 Sep 2010 00:28:44 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 18 Sep 2010 00:28:44 -0700 (PDT)
In-Reply-To: <AANLkTi=VtE9OPKx0+HobC7hcOjeNNMXBG2aQ8vj1FwR1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156433>

On Sat, Sep 18, 2010 at 02:29, Wes James <comptekki@gmail.com> wrote:
> -bash: git-completion.bash: line 127: syntax error near unexpected token `done'
> -bash: git-completion.bash: line 127: ` done < <(git config -z
> --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null
> | tr '\0\n' '\n ')'
>
> anyone know why?

See http://permalink.gmane.org/gmane.comp.version-control.git/151723 and
https://bugs.archlinux.org/task/20288
