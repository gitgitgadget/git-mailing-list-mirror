From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Avoid rename/add conflict when contents are identical
Date: Sat, 28 Aug 2010 10:12:09 +0000
Message-ID: <AANLkTik2op0_Cq13EGit17ja+zCdmbM6WXJ=rfhQMnOQ@mail.gmail.com>
References: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
	<7vd3tnmht0.fsf@alter.siamese.dyndns.org>
	<EF9FEAB3A4B7D245B0801936B6EF4A25262E13@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Schalk, Ken" <ken.schalk@intel.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 12:12:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpIOp-0003rV-FY
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 12:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab0H1KMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 06:12:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46909 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0H1KMM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Aug 2010 06:12:12 -0400
Received: by iwn5 with SMTP id 5so3387911iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=npG6PGDl9Hn4D6RjquCkBEDt0EuWtRl0oORB0UYGoo8=;
        b=jnB2YOED1NmuKGwysLksGFxOW+7B8nMR7E2gjqCVkCx8QrQeTZDz/80DCe4UlBgC5g
         EIo0zcqwxdqazarQXQ7cL6XpOpeTi1iIg1QppMYTfo+AXo6ABr4TwPbj3kjE2ksoctHx
         zvDuy2OcRyIgMQgCL8MxlWWHfHnLicsgLOym8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XzKuThbcCs6gApj/wiYkCBqUTwF70vsbh/6QFMwwS8T8WI04KWI01FHnwyyfop0Ciy
         Rkp6xJN/M8XxhqsG4ge238DmVC2OZlmTCuaMtUUhwuZcdAXFifqNw4zImcUlPIxr5a6A
         7bScStqk5Te3zo4H9mJU7Z4oxEhiRumK91ykU=
Received: by 10.231.58.201 with SMTP id i9mr2527660ibh.98.1282990329568; Sat,
 28 Aug 2010 03:12:09 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 28 Aug 2010 03:12:09 -0700 (PDT)
In-Reply-To: <EF9FEAB3A4B7D245B0801936B6EF4A25262E13@azsmsx503.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154635>

On Fri, Aug 27, 2010 at 22:14, Schalk, Ken <ken.schalk@intel.com> wrote=
:

> + =C2=A0 =C2=A0 =C2=A0 ln -s e a &&

Due to this this (and maybe all the tests) need to depend on the
SYMLINKS prereq.
