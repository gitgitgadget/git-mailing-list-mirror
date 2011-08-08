From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Tue, 9 Aug 2011 00:38:24 +0200
Message-ID: <CAGdFq_iHBE7eESpsX_doyfJu6EAkPOJpBgqkw1psMhqATf2oCw@mail.gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org> <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org> <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vty9rv9p2.fsf@alter.siamese.dyndns.org> <CAGdFq_joHskwhp=934OjirmXiRMR3NbGd4s-hSjJc-gCFT_Jew@mail.gmail.com>
 <7vliv3v8cx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:39:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYTX-0003SC-1j
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab1HHWjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:39:05 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:45231 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab1HHWjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:39:04 -0400
Received: by pzk37 with SMTP id 37so9006107pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uKK++gzD5yVYMLMgM3F3st/ULZqdAywpBJRq0e9JM+8=;
        b=Xw5upuuqyB3mba/9mmcKoiLru/xAUa+1gIi3ICqJSt9t3l3TEJPq0ODZAjiL5ZnkJJ
         AJi2/wfxDm1dpnkxtcBS2VEnPUCLDODqXOJ+JnPZZ5lIbSH8fta2JboAqsew0uZxwaEC
         LeyTNB9oQLIhJIHFkRan80RopF9/TZmVfHhH0=
Received: by 10.142.165.18 with SMTP id n18mr3777443wfe.235.1312843144069;
 Mon, 08 Aug 2011 15:39:04 -0700 (PDT)
Received: by 10.68.63.102 with HTTP; Mon, 8 Aug 2011 15:38:24 -0700 (PDT)
In-Reply-To: <7vliv3v8cx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178998>

Heya,

On Tue, Aug 9, 2011 at 00:36, Junio C Hamano <gitster@pobox.com> wrote:
> It is in this thread; <7vy5zabbz7.fsf@alter.siamese.dyndns.org>

Then I don't understand why you're mentioning it in reference to a
problem someone is actually having?

-- 
Cheers,

Sverre Rabbelier
