From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] gitweb: 'blame' view improvements
Date: Sat, 11 Jul 2009 18:56:52 +0200
Message-ID: <200907111856.54621.jnareb@gmail.com>
References: <200907102354.43232.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 18:57:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPfsx-0007jG-4u
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 18:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbZGKQ5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2009 12:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbZGKQ47
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 12:56:59 -0400
Received: from ey-out-1920.google.com ([74.125.78.144]:21443 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbZGKQ46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 12:56:58 -0400
Received: by ey-out-1920.google.com with SMTP id 3so290329eyh.36
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0tPxJzOKt5r5JHWJx3AORxfLKP9UGWzsGArWw0mY1Jo=;
        b=J/0wVzrQT5HLj4vmTKDoFU9sLX4d7LrvTB1F/KBT5LlHVye6vvgvjk1WTJ6D/SvJhQ
         TpTxYVBscbsdy9odyVKrramZBMzmApNAgrlHO1yr0ofvIlt91XeJMSRceT1WXeqoxb7d
         JYLIOv2/0kH0tyBGrL3hvrpBNdEkjS/dRe0lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=SOSGCaYjTe+rfZTfDLn9oRBK+4/mMWY3yToNJax2QmoKuSRZQ10kzyCzTRmQ8lFAao
         j9h0pcUlxqR/mrskwnElDsyeWsJTTU+CnedCkU+r/POqVHICzoH7zZdm6jqBytf/o0hp
         VKpcSHUBpxU0qqQ5Rj/p18fxaIxP/24n3JBZk=
Received: by 10.210.119.5 with SMTP id r5mr3314144ebc.90.1247331417178;
        Sat, 11 Jul 2009 09:56:57 -0700 (PDT)
Received: from ?192.168.1.13? (absh210.neoplus.adsl.tpnet.pl [83.8.127.210])
        by mx.google.com with ESMTPS id 24sm5508299eyx.3.2009.07.11.09.56.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Jul 2009 09:56:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200907102354.43232.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123114>

On Fri, 10 July 2009, Jakub Narebski wrote:

> Table of contents:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0[PATCH 1/3] gitweb: Mark boundary commits in 'blame' view
> =A0[PATCH 2/3] gitweb: Use "previous" header of git-blame -p in 'blam=
e' view
> =A0[PATCH 3/3] gitweb: Add author initials in 'blame' view, a la "git=
 gui blame"
>

By the way I plan on submitting 'blame_incremental' view similar to
the one in "[RFC/PATCH 4/3] gitweb: Incremental blame (proof of concept=
)"

  http://thread.gmane.org/gmane.comp.version-control.git/102657/focus=3D=
102712

This time having the same (or nearly the same) features as ordinary
'blame' view.

--=20
Jakub Narebski
Poland
