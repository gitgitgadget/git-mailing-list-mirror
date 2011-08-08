From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Tue, 9 Aug 2011 00:30:04 +0200
Message-ID: <CAGdFq_joHskwhp=934OjirmXiRMR3NbGd4s-hSjJc-gCFT_Jew@mail.gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org> <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org> <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vty9rv9p2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:30:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYLS-0000Pm-5k
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab1HHWap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:30:45 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:60696 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab1HHWao (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:30:44 -0400
Received: by pzk37 with SMTP id 37so8996189pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xukg63s3zopPvO1Bv4gjlFRf+GmNaRbmQCt3xRD3uJs=;
        b=AmvlZ9oX0lxIgiNoixjPiLlfOGP3MO6cJu55LvWiCFx3OvBzYtpDZMZZst6nfmrTtt
         9l9habiatp2+ORU0qRzOhOP4FQT0xIjF2oxHJjhRkywhXON8Cu4q1NbQ2FeL2DKa298V
         ql73FSS4X3u/8xZ/UuU3NTcYHIkahRInp8xz0=
Received: by 10.142.171.10 with SMTP id t10mr6206575wfe.178.1312842644043;
 Mon, 08 Aug 2011 15:30:44 -0700 (PDT)
Received: by 10.68.63.102 with HTTP; Mon, 8 Aug 2011 15:30:04 -0700 (PDT)
In-Reply-To: <7vty9rv9p2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178996>

Heya,

On Tue, Aug 9, 2011 at 00:07, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> Nobody needs the stuff you mentioned right now.
>
> Wrong.
>
> "diff ^C A B" is a bug, isn't it? And that is a bug in the current code.

I think I missed something, can you point me to the relevant thread
about this bug in diff? Maybe I can convince the people involved in
fixing that to help out.

-- 
Cheers,

Sverre Rabbelier
