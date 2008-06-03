From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 22:29:40 +0200
Message-ID: <200806032229.40447.jnareb@gmail.com>
References: <839911.60903.qm@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:30:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3d9h-0001x8-SH
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYFCU3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 16:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYFCU3s
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:29:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:50181 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbYFCU3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:29:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so667563nfc.21
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Fw8l22csubgDHV8oNIc4i7a0ybiI/FY8bmmuRrpOvgo=;
        b=pAq8S9KWA2ahwx0o5BdNRxwWNr4nLuAQGcGg9gzAgEHy2neZNnf9g8MZVdpkNyJ8wCmppoVVNACq9abUoZqd2OZgqP4IRQEW01+zqZZSUjjMR9lJ6RNx+m3o+gGI7JkhH3vZz2VsPP8alBa9rY2mtjV5a8e0uOHS54d9hL0H7Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R8Ycc+hA1ENBvgP0fGFupj1M3n7K5FNsLhE9h307JZRezDJKmaN/ipK6ebaqaJJkaf2gTeIoVwnahlqIXu8fsO9mBZIjQl/nXNh8DmGH+YbnVHdl4Il7ZMk+9pSEL3ajQNlxvWP7aRlrUTb96arrfkZwpBBsYg51E/JEKShLPFk=
Received: by 10.210.89.4 with SMTP id m4mr5891812ebb.68.1212524981542;
        Tue, 03 Jun 2008 13:29:41 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id u14sm793014gvf.6.2008.06.03.13.29.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 13:29:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <839911.60903.qm@web31810.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83704>

Luben Tuikov wrote:
> Jakub Narebski wrote:
> > Rafael Garcia-Suarez wrote

> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $parent_commit =3D <$dd> || =
'';

By the way, here you would probably want=20

+           my $parent_commit =3D <$dd> || '--root';

(if it works).
--=20
Jakub Narebski
Poland
