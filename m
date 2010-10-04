From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: branch versioning
Date: Mon, 4 Oct 2010 13:29:55 +0000
Message-ID: <AANLkTi=73Siu9O1WT8MdjfAEO5j5y=CkOAiof0z83L=c@mail.gmail.com>
References: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 15:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2l7C-0005R2-36
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 15:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab0JDN34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 09:29:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47858 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333Ab0JDN34 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 09:29:56 -0400
Received: by pvg2 with SMTP id 2so1324475pvg.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wcIxE463vHQA22EiEPjfH+d+SiNQXZOjqrXDGFH1Qo8=;
        b=pZixoENWFT6aXjXEwc+Ge6RSLezEKAKdo53atqyCtZEHkEFrsD4EV5l+JvNMaLqydS
         i2uj4ccHXwxJsPcsrRxKmO6o2Bmg9257WDSWNcMdo0YMshYBAqNo9zr8SNe5thFtbvY5
         4184CPDblLh1p2wTN6sa1aGCyd04MZXt6ayUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VpsbCSiCDREWl4stscJZKfihHvkP9JffW2y6mWQ/qp+KhY2G2C0BrA/YvHNfgXcDXg
         6ShceDCqXEqeC5Z+gdVweh+kOqhAN/qDORn234PPshIyNxoa7vcmZQXEZXdBrOSrsmTX
         H1U6F9mhKDkaoKNHmZBgagIC6SPpCg6axZvvI=
Received: by 10.142.229.16 with SMTP id b16mr8625176wfh.311.1286198995529;
 Mon, 04 Oct 2010 06:29:55 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 06:29:55 -0700 (PDT)
In-Reply-To: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158047>

On Mon, Oct 4, 2010 at 13:18, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> How do you guys manage versions of a topic branch? I usually end up
> saving format-patch series somewhere or forget all old versions.
> Although I really want to keep old versions around. reflog to me =C2=A0=
 is
> polluted with every kind of branch updates. And it's local
> information. It can't be transferred to another repo (or can it?)

I usually have foo, foo-v2, foo-v3 which eventually gets reset back to
foo once I'm sure nobody cares about the initial one or foo-v2. It's
very chaotic.

So my git.git on GitHub is up to 123 branches, and I don't even want
to know what my personal git.git is at. I also save my outgoing
format-patch E-Mails, but would probably do less of that if there was
support for attaching the comments after the diffstat in a git-note or
something.
