From: John Szakmeister <john@szakmeister.net>
Subject: Re: Rebase and incrementing version numbers
Date: Tue, 24 Jan 2012 20:18:49 -0600
Message-ID: <CAEBDL5XF3uiCSih4U9jJwmHMAaUqGh+9mXRFxyHNTqEn61K8PQ@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	<CANgJU+WWq=+BP1ZDbGY3weB5Xey2TtbryDJvz5=eMLFzNet3xQ@mail.gmail.com>
	<CADo4Y9is9mBOJaU+YRTMedTz7FfDrMFoDiqiUvQpVxQpyariPQ@mail.gmail.com>
	<CA+gHt1CPBYTLLwSSLdu-BmDfuGDzPwi9RnXAku7KZjHLYhUtjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mike@nahas.com, demerphq <demerphq@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jan 25 03:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpsRw-0001yS-N6
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 03:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab2AYCSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 21:18:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38124 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab2AYCSt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2012 21:18:49 -0500
Received: by iacb35 with SMTP id b35so6170745iac.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 18:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Q4HSX8RveGUooqEFqvlKa7Sakjf3S4Z6thNO3xsQcU=;
        b=DkDMOmG0SNF2EMw9cKYSPeU4WI3RFHdoee8CeEjzWAUs3hrLGhG5qwhx6mEw5znjJF
         evjKNsiuYRpIMvvLpbW5Z6H/u+clr7cL9WafHTqUhPc348r8WXHeea2cuZEmtWWYM5YR
         KjIc08VvWU/9uyedwSFCpDxb6pBo6sFHaxNg8=
Received: by 10.50.34.202 with SMTP id b10mr5575551igj.2.1327457929421; Tue,
 24 Jan 2012 18:18:49 -0800 (PST)
Received: by 10.50.57.133 with HTTP; Tue, 24 Jan 2012 18:18:49 -0800 (PST)
In-Reply-To: <CA+gHt1CPBYTLLwSSLdu-BmDfuGDzPwi9RnXAku7KZjHLYhUtjQ@mail.gmail.com>
X-Google-Sender-Auth: Oz0IFsXEdI1PY2leBOd-gVy04Cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189094>

On Thu, Jan 19, 2012 at 5:31 PM, Santi B=C3=A9jar <santi@agolina.net> w=
rote:
[snip]
> Yes, but you can use "git describe" output:
>
> $ git describe
> v1.7.6-180-gdf3f3d8

That doesn't work with git-svn.  In Subversion, tags are closer to
branches, which is how git-svn treats them.

-John
