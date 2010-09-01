From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Thu, 2 Sep 2010 09:28:44 +1000
Message-ID: <AANLkTikOsZa6OvWkCV27NB7k2t+kT-5wDfx5Eaymx_MW@mail.gmail.com>
References: <1283334825-18309-1-git-send-email-pclouds@gmail.com>
	<201009012054.20482.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	srabbelier <srabbelier@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 01:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqwjb-0006QW-U5
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 01:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab0IAX2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 19:28:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42317 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab0IAX2p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 19:28:45 -0400
Received: by wwj40 with SMTP id 40so668127wwj.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r57ZNbgjmES9XCCGPbYV5UuSZrRrTBxkOg17xNQBY4w=;
        b=JaGfVKednImMv3IS4h9NhPuqug4MCHUFzlHonox3BIfe7k8f1faiwpIc6qGfckpdMg
         5tIECkxckmZ4Aoap9epyWL8CrfkLB0NpQtitD2XSNGLD0+zE6dxEo5JbfKQFmYaOfbiz
         WQdUI+HwZhwHMbvZC64cyzy2VLZjFBCQHjG/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Um+tIkW+HVNhXh+ujT4ETHArgh1VZjIdf3dnRmAZfcKsp+TPdGlPcHpOO4d1QvRy7A
         Rn5jNgwA0pGBeoaWAMsTiCuhqzXZj2BmFxKkbMA7od+TbFxgtpYcKbtXPuqXs2Q8FQ2x
         njM4mCFd8tpBquVft9Glm/q5hfPiClSMByowU=
Received: by 10.216.159.213 with SMTP id s63mr913319wek.78.1283383724418; Wed,
 01 Sep 2010 16:28:44 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 1 Sep 2010 16:28:44 -0700 (PDT)
In-Reply-To: <201009012054.20482.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155096>

2010/9/2 Robin Rosenberg <robin.rosenberg@dewire.com>:
>> + =C2=A0Entry path name (variable length) relative to top-level dire=
ctory
> ...to the top level...
>> + =C2=A0 =C2=A0(without leading slash). '/' is used as path separato=
r. Special
> The special...
>> + =C2=A0 =C2=A0paths ".", ".." and ".git" (without quotes) are disal=
lowed.
>> + =C2=A0 =C2=A0Trailing slash is also disallowed.
> Why would anyone even consider adding a trailing slash to a _file_ na=
me?

Well, I was tempted to put directories in index more than once. And
subprojects are actually directories although they are treated as
files in index.
--=20
Duy
