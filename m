From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Thu, 29 Jan 2009 14:51:15 +0100
Message-ID: <bd6139dc0901290551g42ac7cb6m40194f75b8863be0@mail.gmail.com>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 14:52:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXK0-0000X1-4D
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 14:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbZA2NvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 08:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZA2NvR
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 08:51:17 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:58369 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZA2NvR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 08:51:17 -0500
Received: by gxk14 with SMTP id 14so6477389gxk.13
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=O88aVB+BXqeVdieFREydn4LF0WtWHBRQAd+CzWVk17U=;
        b=rheiGXhwUHsVbayYs7XnB+zC1umBGUtvaBznscdBYFnrfY4w+ffNfyqs4h6xfPnH4M
         xz42BdL3WqCq+i1HHJu8tf36XWg24nB8cCzVricW1zl0GbHylRUixu7udKJtxecMpBrZ
         c3ul6dDDP4FKniLCXwzb9rf7mzSdHdl1kgEAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=PKDWUoJEbU6ljs77kWE0uayqi7RXkalHtWvgBwAzzriVTk+v2B/xJXsRF/RHCAd5Ld
         gD1DhtXGJclC9035ayLY2XQIg879H+HgmPcr4doRKdlZpO9cKv7s8sASx6rWUDMsuvZZ
         C/rp8ZVfQOwWbFLhZgxKRqmIhraoleNt/7lSI=
Received: by 10.150.154.6 with SMTP id b6mr144272ybe.95.1233237075869; Thu, 29 
	Jan 2009 05:51:15 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 72f278d75b0c57fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107674>

On Thu, Jan 29, 2009 at 12:45, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Mhhh, so maybe we want a way to set up tracking branches when pushing,
> yes? From what I've seen a patch to do that shouldn't be too hard, so
> if there's interest in that I could look into that.

On Thu, Jan 29, 2009 at 14:38, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>        $ git checkout xyz
>        $ git push --track origin xyz:abc
>        $ git pull

Am I reading this correctly in that you beat me to the patch I
mentioned earlier in reply to Junio and Peff?

-- 
Cheers,

Sverre Rabbelier
