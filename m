From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 10:03:22 -0400
Message-ID: <48A43B2A.7010702@griep.us>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814064524.GA4379@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 16:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTdSe-0004H8-A7
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 16:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbYHNOD2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 10:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632AbYHNOD1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 10:03:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:18224 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbYHNOD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 10:03:26 -0400
Received: by wr-out-0506.google.com with SMTP id 69so546479wri.5
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=3OopalyB8V+ci3nDAtaQUelaT1pKBfxOxvu2S3eQdLw=;
        b=fE+bUgcZJFrL+PUZ9bs9zhYdT5yGMcVkZ8Vbo2Z/rYPtuYSSVLUNWUszXx9UPPjlMn
         9GDh4Yi7wIbjBgoCwuXduoqZXk/jyCckgGxQuYRYpFYARzHbIbNnHTd1sBwlqSE7tyex
         FCk5EuPvUtySS482aogGsC/WWCq4lkDJRS6rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=hyveIB7VR98Ue/Ca/OdoHkVarcM7+oTwHHmVNdul+a0CWzaXFCd3M0FjdAqkI4o0oG
         sRMOvNxjrNSGQCPKTpOnCq1n8IkGTK3YzbE9A51q19o2HvZhzXnlirdYGgnDIpUUMPRq
         SMKtsvkVxdqTPY4JMc7YvHeN39srTtE7Ndl2M=
Received: by 10.90.55.9 with SMTP id d9mr1884336aga.23.1218722606063;
        Thu, 14 Aug 2008 07:03:26 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id o61sm1863613hsc.17.2008.08.14.07.03.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 07:03:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080814064524.GA4379@blimp.local>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92361>

Alex Riesen wrote:
> GNU ls and du use "-h", with du using -H for SI units.

git's parse options plays interference here and injects the usage
and exits if it finds the '-h' option.  Is there a way to get around
that?

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
