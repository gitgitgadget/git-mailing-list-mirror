From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Tue, 9 Aug 2011 00:48:58 +0200
Message-ID: <CAGdFq_ioxeZUCnn-fFKuiT-6eVzVoph8eQE2j0hEbAxtDZzGnQ@mail.gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org> <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org> <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vty9rv9p2.fsf@alter.siamese.dyndns.org> <CAGdFq_joHskwhp=934OjirmXiRMR3NbGd4s-hSjJc-gCFT_Jew@mail.gmail.com>
 <7vliv3v8cx.fsf@alter.siamese.dyndns.org> <CAGdFq_iHBE7eESpsX_doyfJu6EAkPOJpBgqkw1psMhqATf2oCw@mail.gmail.com>
 <7vhb5rv7x0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:49:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYdj-0007CD-Jx
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab1HHWtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 18:49:39 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61071 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab1HHWti convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 18:49:38 -0400
Received: by pzk37 with SMTP id 37so9017974pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GNIq9kwTnDpWEcOZjiWH2zOpR0HXR0nXIFJ3dKTQv2Q=;
        b=DiftDPpY1PdGiJQhApnCIIhPMUyiyhNk8TnyTMzPNVOr+mwpWLBTu+6cbdAQn8HfD3
         1+QAg3niIQOmjErlqehBbpUY6gxSMiTUde+Y6r9C4AY5TrT+QirVqod3owkY01iBrZJw
         4odwld8sowm4kMim11uw0Dgj8ai17GQyVxsHU=
Received: by 10.143.20.28 with SMTP id x28mr6503396wfi.349.1312843778099; Mon,
 08 Aug 2011 15:49:38 -0700 (PDT)
Received: by 10.68.63.102 with HTTP; Mon, 8 Aug 2011 15:48:58 -0700 (PDT)
In-Reply-To: <7vhb5rv7x0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179000>

Heya,

On Tue, Aug 9, 2011 at 00:46, Junio C Hamano <gitster@pobox.com> wrote:
> Why isn't it a real problem when I have it in the currently released =
code,
> and why is it a real problem if you have it with your wip series that=
 uses
> the current code? =C2=A0Both are real problems that somebody is actua=
lly
> having.

Because no actual users are actually having this problem (e.g., at
times typing "git diff ^C A B" and are seriously troubled by it), or
at least haven't spoken up? Or do you meant that you are that user?
I'm confused.

--=20
Cheers,

Sverre Rabbelier
