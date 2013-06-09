From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] submodule: remove redundant check for the_index.initialized
Date: Sun, 9 Jun 2013 11:44:15 -0500
Message-ID: <CAMP44s2cidZt6YWx-f5VMO3uhcTbV-SA-ze6xojHn2y_Pi1=NA@mail.gmail.com>
References: <1370795625-10506-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlijG-0007I4-Tn
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab3FIQoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 12:44:24 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:64421 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab3FIQoR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 12:44:17 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so5620504lbh.10
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=M2K3gd7EgDWGFncBlaymCwwxhhDUEyQUaRi3U4n2Adw=;
        b=LqrtkVweO23i/cWFyP+L0qwlNe+1Ov4jkMrH3noDCxgZS1jM8Nyn2iztzGTg3VjlvT
         7oPW48EhOeowJP3B58J+I+V4PmaLHGshKxC3SvP2pKBFf6WPuX6Fn4d0MYGMVdSG9SzU
         2AxQzzaFl1UAWFlHzQUB9vdDriTRL0TmiXr51JSrwcNuiTvY9W38X5KZLi+U9tHMrsUK
         6OwS7/+IfY08rkd+oKEuqizOWlhq8a84pEx2dpVCWO6GHe7+NQJnxGSc86tP1HHA9b3B
         f31CNkyNsnCeWNN18INRMEnHMt9pOsLKFqpVqZlsI7EkIP0O7J74Ki/DmIS2q2OFIfp9
         R3xg==
X-Received: by 10.152.22.73 with SMTP id b9mr3280659laf.36.1370796255685; Sun,
 09 Jun 2013 09:44:15 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 09:44:15 -0700 (PDT)
In-Reply-To: <1370795625-10506-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227000>

On Sun, Jun 9, 2013 at 11:33 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> read_cache already performs the same check and returns immediately if
> the cache has already been loaded.

This time I beat you to it first ;)
http://article.gmane.org/gmane.comp.version-control.git/226701

--=20
=46elipe Contreras
