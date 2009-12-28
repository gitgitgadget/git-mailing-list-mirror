From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH 2/2] Smart-http: check if repository is OK to export 
	before serving it
Date: Sun, 27 Dec 2009 23:07:26 -0500
Message-ID: <905315640912272007i8b4904dv2b93879789b453fb@mail.gmail.com>
References: <7vk4w963np.fsf@alter.siamese.dyndns.org> <1261870153-57572-1-git-send-email-tarmigan+git@gmail.com> 
	<1261870153-57572-2-git-send-email-tarmigan+git@gmail.com> 
	<20091227211033.GB609@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	rctay89@gmail.com, drizzd@aon.at, warthog9@kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 05:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP6uZ-0001EE-O7
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 05:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbZL1EHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 23:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbZL1EHq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 23:07:46 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62872 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbZL1EHq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 23:07:46 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so6086552pwj.21
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 20:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Phtryxro6lRMsytvnsOrOgHgIxkKWpv4OTEyAHb5AcA=;
        b=C3lxMfoR/AzHfphMzdyHNBWon0SUxgYR2/DmLVy9sj7s2ttybzo0w1hP/Nkqu3uyHC
         RcxnWHcEYleEkKHROy89Kx5VNJj8Nr1kidd/edK8dkxbTLhJwjM799/3K1jmPvDCBlQm
         zH7lrjm/VN4x7TrXTxeLeAKKxV6I3fG5F+T6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Bz5c1yBUjkkUhvyKIZl79a8BBtuzHteaUutLF9w7aJAKUhwVIAyiGCZgaTtvmCcPaE
         fSjpPflw6Ng+vmQhFWjfyB6wC4i1T9Cq7kBjq27P4BXGuagoAr4/bplunAtJY55KUQ7M
         3SEiZypXGk2wQ6MuAHXEua6CoH5hKwHYEAYco=
Received: by 10.142.3.13 with SMTP id 13mr10097885wfc.302.1261973266088; Sun, 
	27 Dec 2009 20:07:46 -0800 (PST)
In-Reply-To: <20091227211033.GB609@spearce.org>
X-Google-Sender-Auth: e0c628c49094821b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135723>

On Sun, Dec 27, 2009 at 4:10 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
>> Similar to how git-daemon checks whether a repository is OK to be
>> exported, smart-http should also check. =A0This check can be satisfi=
ed
>> in two different ways: the environmental variable GIT_HTTP_EXPORT_AL=
L
>> may be set to export all repositories, or the individual repository
>> may have the file git-daemon-export-ok.
>>
>> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
> I really think this and 1/2 should be squashed together, in which
> case you can apply my ACK to the entire thing.

Great, thanks for the ACK.

Squashing sounds good to me, I just split it so someone could verify
that the tests fail first if they want.

I've been thinking that the not_found() to a forbidden() instead.
Thoughts?  I'll send out a unified patch with that change in a reply.

Thanks,
Tarmigan
