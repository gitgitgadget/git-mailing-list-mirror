From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Makefile: Track changes to LDFLAGS and relink when necessary
Date: Wed, 22 Jun 2011 10:51:35 +0200
Message-ID: <BANLkTi=XOEFyVu-ZEqpmLaD60FL6dV2ndA@mail.gmail.com>
References: <1308682726-20971-1-git-send-email-frekui@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 10:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZJB6-0002Xl-Ox
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 10:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab1FVIwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 04:52:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46813 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1FVIwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 04:52:17 -0400
Received: by pvg12 with SMTP id 12so371797pvg.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=xyyPe3+l6kddpM0UXVk6H9ujzoq5NGdtFW4/Z8gATo8=;
        b=W/wMjG3eIYkCk39YhT4V68cjOkH/W45s53juh15XU1hwu38wrAC9fwbvCMOFTzMfw/
         BGVDALfRck+VpVV5mRYZuyLLlGnUT4jIQ3aaa5PYKH708B8I63icoiXGDX2vJfUyLzPI
         8PzJUZUZZg8fMbOPCcKc9Jzz+gHBGO4jVLMaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TMJahjRmlnUux1aD9q1OHAN/Wj57dT7EZO9AQDoYrzpubmBjFv4M/mgDdpqJcZlBYt
         XiiW+fSgXaXoh2CPH9OX3U+xBjYKTzPO4XOCyiAAiQfMkq7PVfTMC4UjjeZqA/NNnO9k
         Ux7UV5c0PsoQl8wbXKnxEC75DTYm/oMw7B7d8=
Received: by 10.68.11.196 with SMTP id s4mr176961pbb.301.1308732735132; Wed,
 22 Jun 2011 01:52:15 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Wed, 22 Jun 2011 01:51:35 -0700 (PDT)
In-Reply-To: <1308682726-20971-1-git-send-email-frekui@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176227>

Heya,

On Tue, Jun 21, 2011 at 20:58, Fredrik Kuivinen <frekui@gmail.com> wrote:

It might be interesting to note in the commit message why this change
is made (now), and if there are any other similar flags that we ought
to track.

-- 
Cheers,

Sverre Rabbelier
