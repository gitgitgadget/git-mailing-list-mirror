From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Mon, 1 Jun 2015 19:17:30 -0400
Message-ID: <CAPig+cRTNGzzGNTZzPCz1M_uHxT6fOBw+k=3njUOkyhUCdX8kg@mail.gmail.com>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<CAPig+cRGT4qgCNgVi_x-==GKze7VUPVbVPGHYui7y5ZXie72Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Stephen Kelly <steveire@gmail.com>
To: =?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 01:17:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzYxc-0006rj-H5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 01:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbbFAXRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 19:17:33 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36000 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbFAXRb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 19:17:31 -0400
Received: by igbpi8 with SMTP id pi8so73952698igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=0MhHItKkoMbg4pWNK75pZSqfNtDyjBr5BLvYxllUEBM=;
        b=UwNLlh+yNrf8eBaHw7NK7yuIDf4A+4A/pzVkGiGJpRz33DZDO8eRGsDm/4cgqXAVXZ
         p4rsWaebD1x/+JsHi2JUIGqh980Gol3cg+fP6l4gHrV0nwt4FR2F07X3QHUvw+UuFl+G
         cEUr8rFEEZavRLVTGeQdSOMVN/R2vKHwc3AiUDNFM2MpNbQrYxS06GuAyJH0gajrypvN
         JTdE+CuMFNWgDq47RxOAIOLO2N7cVnWmAgLTCmbF0r25FPycN2po9ltV9s/tFjDOecAJ
         lcEP0SRyWLOX60dSr983pX6PHz1kbgDWPTl1L6sPsAJ2VbO+T+H76d+fZ2tFZ7s8gogl
         5ZzQ==
X-Received: by 10.42.146.202 with SMTP id k10mr15554184icv.34.1433200650648;
 Mon, 01 Jun 2015 16:17:30 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 1 Jun 2015 16:17:30 -0700 (PDT)
In-Reply-To: <CAPig+cRGT4qgCNgVi_x-==GKze7VUPVbVPGHYui7y5ZXie72Qw@mail.gmail.com>
X-Google-Sender-Auth: ri39kxOQ-SBhgcwzCpu4o4tqsw0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270481>

On Mon, Jun 1, 2015 at 7:16 PM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Mon, Jun 1, 2015 at 7:52 AM, Galan R=C3=A9mi
> <remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
>>  test_expect_success 'drop' '
>> -       git checkout master &&
>>         test_when_finished "git checkout master" &&
>>         git checkout -b dropBranchTest master &&
>
> This "cleanup" change might deserve its own test (or at least a
> mention in the commit message).

"...might deserve its own _patch_..."
