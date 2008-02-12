From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Tue, 12 Feb 2008 14:10:57 +0100
Message-ID: <200802121410.58208.jnareb@gmail.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <200802111630.29159.jnareb@gmail.com> <E16BED2E-C146-44D8-BD90-ECF0DF89CA35@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 14:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOuvR-00018Q-BJ
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 14:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbYBLNLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 08:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbYBLNLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 08:11:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:50234 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbYBLNLH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 08:11:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so479842ugc.16
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 05:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=F1vzpIDNdZFr3qA/NUmPRBlshlj7xkdcNoUA1dGBdV0=;
        b=P3UFLdYqrskMLQx8pyJe16WSUYF7FErK6ucDix6cRzttmWrVou2zte/ctXQz3jvQDQMOoPHm6VSWjmgBLpclsFlkKcMlOWA6xAUkis/13RSW92f+3jA/Ck9f2M7moGfBN0u0grQyuP6EKISIsMb4NOGyI9RwJtMWMmYtKsyB4DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JJR+BFsu5PD7Tery+qH8YvZ/BjlBhLJC/0LQVxvth2XMV4eePVPO+p36Fv8KgGNRphHnWoKA/AUDIaX6z3wdw39+ytndY6qf6FP4uk0vPZp16jAAcTcHaqtIENRYmaaO20UyEEmFaoFe5nKtZmqEqJ224bG2fifFlsl82j+D+6s=
Received: by 10.67.196.2 with SMTP id y2mr517382ugp.60.1202821866166;
        Tue, 12 Feb 2008 05:11:06 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.23])
        by mx.google.com with ESMTPS id j33sm2826906ugc.63.2008.02.12.05.11.04
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Feb 2008 05:11:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <E16BED2E-C146-44D8-BD90-ECF0DF89CA35@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73659>

Dnia wtorek 12. lutego 2008 13:24, Wincent Colaiuta napisa=C5=82:
> El 11/2/2008, a las 16:30, Jakub Narebski escribi=C3=B3:
>>
>> I'm sorry. You are right. I haven't seen breakage because it shows
>> only when you use 'pathinfo' feature and pathinfo URLs.
>>
>> Below there is a fix for that; actully only second part mentioned
>> (and first in patch) is needed, i.e. moving setting $params{'project=
'}
>> before dealing with -replay is needed I think to fix this bug.
>>
>> Could you test it please?
>=20
> Your patch fixes the "next" links in the shortlog and log views.
>=20
> It doesn't fix the broken "raw" links in the commitdiff view. I'm =20
> still seeing links like:
>=20
> http://example.com/ARRAY(0x8c97f64)?a=3Dcommitdiff_plain;h=3Df29d5626=
9a1c3bd4a970897397470f41553a64f9

Could yu please give an URL for the page containing broken
link, relevant parts of gitweb configuration (gitweb_config.perl),
and gitweb parts of repository configuration, if there are any?

This would help in reproducing this bug, and correcting it.
--=20
Jakub Narebski
Poland
