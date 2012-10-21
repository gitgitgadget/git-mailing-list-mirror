From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Sun, 21 Oct 2012 20:03:27 +0200
Message-ID: <CAMP44s0jgxqb8EyjCcEdzaDR6y8gqydW7X-C268NahjaXMrh6A@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.1.00.1210171759230.3049@bonsai2>
	<CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
	<alpine.DEB.1.00.1210171936170.3049@bonsai2>
	<CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
	<CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
	<CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
	<alpine.DEB.1.00.1210181031320.3049@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 20:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzsE-0000rk-5r
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 20:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460Ab2JUSD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 14:03:29 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39233 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374Ab2JUSD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 14:03:28 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1805040oag.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GyM9TE6WUQ0raEZ2od0v5Fvcp3sW7dnSNRLtIqw2aZI=;
        b=YR0Gz+ECsEvQkkhMTh9uFU5F/04OUumEmg8rI/auujx+oWM4oeHPHpvW7TJcKmpMge
         roS1tksyC6esjmfQ+tRxgxiMEK9NOs9ZqOptKJ+sdBhYxWnp6T0WFWu/AwKvBP4Mktaa
         hP7UW8Ne0Vof0UnrZwTmval9TMmh2nGYACx2CqFtRT7pnYMoBIpr9LU5p1mxMvQydSEn
         9FqaOVmxYpKmd3JhUikzzAaeOGVctcdhhYd0lU9z1fJNb4bvVO0+qjk3t+rpkLIuv6vJ
         LmsAiCClK1nYLIdMXGthW1sBliP8Cts+cBhSVFflUr+rVMqn37thxDTcsJfW1eN5y82L
         wqXA==
Received: by 10.60.27.71 with SMTP id r7mr6345674oeg.96.1350842607733; Sun, 21
 Oct 2012 11:03:27 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Sun, 21 Oct 2012 11:03:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210181031320.3049@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208135>

On Thu, Oct 18, 2012 at 10:47 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Without push support, remote-hg is useless to me. Without regression tests
> proving that it is rock solid, I will not use remote-hg.

Done and done. My remote-hg now has support for pushing, all in less
than 500 lines of code. It also manages to pass all 14 of the
"extensive tests" of your remote-hg. Anything else?

-- 
Felipe Contreras
