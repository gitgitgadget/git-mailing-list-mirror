From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] bash-completion: Add non-command git help files to bash-completion
Date: Fri, 15 Aug 2008 13:53:32 -0400
Message-ID: <48A5C29C.5080602@griep.us>
References: <1218816948-7864-1-git-send-email-marcus@griep.us> <Pine.GSO.4.62.0808151234110.17004@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:54:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3Vb-0007MH-Ak
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 19:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbYHORxi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 13:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbYHORxi
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 13:53:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:40546 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbYHORxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 13:53:37 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1137543wri.5
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=y1vCEgS6v3Wn3a7ieMFVWUL6Xme3jO4TJIIONRpYwwI=;
        b=n4iLHy16tkHxB1gbQhGw+9Rj5btwMh1X3yRFLJfmx5MM/8o/I+97ScUYU9BA9S5Y4m
         dlJDrLFABFkmzzLjAa29V/v9VAwSCKRFlmk9uLis4hzv0E+cItA33H6yC5bNpoFiPqdy
         heUprZoACpe++Iqy1KvX4tQ2hZQ1JS/kB55bU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=irWk1A2XPdRWT/XaBL8hCeIoygBL+ldy19Erkn6NhFULVR+ZA5wGXgO0iGkGVKKi0O
         NLwdUZu/91H9qEAcKheFRUCSaBq8nux4I2MCk1r2afuvexV3AzPc7MWRKFn7TAN/IKyC
         i5l1/tTTs/YFwuUGaSXEbCIqdKxZGH0/PijeQ=
Received: by 10.90.81.19 with SMTP id e19mr4029620agb.24.1218822816449;
        Fri, 15 Aug 2008 10:53:36 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id l48sm1406212wrl.4.2008.08.15.10.53.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 10:53:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <Pine.GSO.4.62.0808151234110.17004@harper.uchicago.edu>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92499>

It can be either.  In a bash-completion list, though, gitk would probab=
ly
be more recognizable.  I'll rehash that one.

Jonathan Nieder wrote:
> Hi,
>=20
> Marcus Griep wrote:
>=20
>> Git allows access to the gitattributes man page via `git help attrib=
utes`,
>> but this is not discoverable via the bash-completion mechanism.  Thi=
s
>> patch adds all current non-command man pages to the completion candi=
date
>> list.
> [...]
>> +		diffcore glossary hooks ignore k modules
>=20
> I think k should be gitk here :)
>=20
> Regards,
> Jonathan

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
