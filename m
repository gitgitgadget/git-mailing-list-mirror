From: Hong Xu <xuhdev@gmail.com>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>" if the ssh key is encrypted
Date: Fri, 23 Mar 2012 01:56:31 +0800
Message-ID: <88F32C4E-F5A9-4741-8707-641F63E41E42@gmail.com>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl> <7vmx78y1eq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:56:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAmFB-0007a5-3Z
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 18:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab2CVR4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 13:56:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51737 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab2CVR4C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 13:56:02 -0400
Received: by iagz16 with SMTP id z16so3406818iag.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=PiafCSgLoTMUrlCegVPfoCxWIWBmogeL6WFnk8LH4UI=;
        b=kyHt7bcHeh1ppM58926To/s1RFTd6zjpAWO37rdN1AaxVqYDel/ivDiyi/k8BqX/qB
         +/wN+pq75VWA77bUe9qmgPqpuSPqu7m+k+2mb75qs/R63Il/Tw3eSfvQVM2A83mD3rO4
         RSW+LoZ/YeGg3tVoZIQ4Rsz4KD+kqJUsbPcNBNsxsfYOiVjdpg/KtVzbBiJIPQxZHTud
         om4Jbkgv8uQTHNn1il/C3wvk78O+HAuenHR99USn8glYf9EFTy2U0zY3svk/M2OFi9EX
         hphWtoTcphWT9pP6RODKNZb+U02RvsNMTrs5oAkNNS5KBaOcrbbjXI5YlobCFkUszX23
         rk2A==
Received: by 10.42.176.6 with SMTP id bc6mr5521162icb.49.1332438962010;
        Thu, 22 Mar 2012 10:56:02 -0700 (PDT)
Received: from [192.168.26.100] ([114.96.19.30])
        by mx.google.com with ESMTPS id cw5sm1803514igc.17.2012.03.22.10.55.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 10:56:01 -0700 (PDT)
In-Reply-To: <7vmx78y1eq.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (9A406)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193672>



On Mar 23, 2012, at 1:46, Junio C Hamano <gitster@pobox.com> wrote:

> Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:
>=20
>> Maybe git-ls-remote should learn --quiet?
>=20
> I would rather think that the completion should ask for refs only whe=
n
> dealing with local repositories, without going over network, whether =
the
> query involves authentication or not.
>=20

Could you give some reasons about why shouldn't we go through network?

Hong