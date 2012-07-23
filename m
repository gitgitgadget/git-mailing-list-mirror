From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Mon, 23 Jul 2012 23:44:25 +0200
Message-ID: <CAHGBnuNP6VmDUXr_01zWZgcTDOUSX2_v7UDf6sOnEYU95RCW4g@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFB19.6010905@gmail.com>
	<7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
	<500DA7F3.3000403@gmail.com>
	<7v4noykxvm.fsf@alter.siamese.dyndns.org>
	<CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
	<7vipdejhmh.fsf@alter.siamese.dyndns.org>
	<CAJDDKr71SYf3=iUahGLVA2kmKYqT85Thaiooo2YCJqprS5nVag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:44:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQQZ-0003j5-WF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab2GWVo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:44:27 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39961 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab2GWVo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:44:26 -0400
Received: by vbbff1 with SMTP id ff1so5184264vbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MWdBkx/TImjS3w4q4zx/cMXm8XzKGmN9iQX7UOxLUDs=;
        b=VznTGfxKlzVIruWRri5UsQEedNv+D6rn5SPTsY1qZ9UlNtv++QmPRD2UWLD4Whj3UV
         uutEhoiWMT05EDCrDPUzgrbxb2d8AIZchvX6vK6uw1i08/JaHVdHH7q/y7DGRJEwH2/+
         2Q5PVIz6L/R2ARJddmEuNw52AqXBvYZPv7nG1yM0Qyx7wxM8qebzUfFjtmSn1qIJDQLQ
         E41gR9zcqCdN5d9Ow2zlBDoaXVmfukD/OjZ3t/OEL3K+RTIVEfE2lwM5mjZMgcqNyDk9
         Mg2QkefW5ULgW20RaK9pbMVsmzhJKWUtE/4+kbmiZM5MN3aE0eDnMi98TIDQuDP6cHeK
         2dCQ==
Received: by 10.52.97.227 with SMTP id ed3mr12129919vdb.103.1343079865639;
 Mon, 23 Jul 2012 14:44:25 -0700 (PDT)
Received: by 10.58.35.135 with HTTP; Mon, 23 Jul 2012 14:44:25 -0700 (PDT)
In-Reply-To: <CAJDDKr71SYf3=iUahGLVA2kmKYqT85Thaiooo2YCJqprS5nVag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201993>

On Mon, Jul 23, 2012 at 11:34 PM, David Aguilar <davvid@gmail.com> wrote:

> Sebastian, are you testing on Windows?  The araxis "compare" I used is
> OS X.  Does "compare version" open a GUI window for you?  For me it
> does not.
> What about "compare -h", or just "compare" ?

Yes, I'm testing on Windows, and unfortunately Araxis behaves differently here:

- running "compare version" or "compare blah" prints nothing on the
console, but the GUI opens saying it is unable to open a file
"version" (which it would compare to nothing),

- "compare -h" or just "compare" both open up the usage dialog listing
all valid command line options (because "-h" is invalid).

-- 
Sebastian Schuberth
