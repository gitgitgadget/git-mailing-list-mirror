From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Tue, 5 Feb 2013 11:16:52 +0100
Message-ID: <CACBZZX7FJ39sereptAQ40Q4MwEpf15v0H=++WvB7+BpMknxoYw@mail.gmail.com>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org> <510F95D7.6010107@drmicha.warpmail.net>
 <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 11:17:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2far-0000KK-RV
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 11:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab3BEKRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 05:17:15 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:42912 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab3BEKRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 05:17:14 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so7403975oag.1
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 02:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vJ7IswftSLOC7TAuUI0POk0IzMLh1vW7wD9pgNppJ0I=;
        b=fqfxK6sxDJT57TZQOyjOcSeaJ6/OLrgAcyaBx7B9IsMeIuuVu1vPHVp7h47Wlxq3HD
         ZkZrApPxUCpbjfiN3AMDY2O0uV9bvxmigwthYSIt1KzMPrNl0G4jOMmrCKhGCkcBjhiQ
         Iabw5DG7p1yeekWNBhGtx4atDnUHqgUQyCK1CoiR1iuJXo5vm/nzue13THTSYPla7GBN
         y34BQECAAB/g10jgGd1+1P3lxodMmBu2bFjtGvP4T4TbTWnSmZXNArvXOQD1teKYuOvc
         Ymc4lkff2mE8d5FJG0vVPWYq9upGLolhc61R9MEG5M6eJOyv/rsaiPskQRYGsomDOypr
         SspA==
X-Received: by 10.60.30.42 with SMTP id p10mr18848540oeh.59.1360059432964;
 Tue, 05 Feb 2013 02:17:12 -0800 (PST)
Received: by 10.76.168.163 with HTTP; Tue, 5 Feb 2013 02:16:52 -0800 (PST)
In-Reply-To: <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215474>

On Mon, Feb 4, 2013 at 5:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "git log/diff-files -U8" do not need "-p" to enable textual patches,
> for example.  It is "I already told you that I want 8-line context.
> For what else, other than showing textual diff, do you think I told
> you that for?" and replacing "8-line context" with various other
> options that affect patch generation will give us a variety of end
> user complaints that would tell us that C) is more intuitive to
> them.

On a related note I think "--full-diff" should imply "-p" too.
