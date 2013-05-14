From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] checkout: add --ignore-skip-worktree-bits in sparse
 checkout mode
Date: Tue, 14 May 2013 17:21:42 +0700
Message-ID: <CACsJy8CzOrnofz6eWLN61axrdTubnLfWnYxWPZSMrsBgu594_A@mail.gmail.com>
References: <1364637753-18785-1-git-send-email-pclouds@gmail.com>
 <1365808328-4191-1-git-send-email-pclouds@gmail.com> <1368523634.10814.3.camel@vpl-thinkpad10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?M=C3=BCller_Kirill?= <kirill.mueller@ivt.baug.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 14 12:22:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcCN8-0000po-LD
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 12:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3ENKWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 May 2013 06:22:14 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35781 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3ENKWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 May 2013 06:22:13 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so347794obb.30
        for <git@vger.kernel.org>; Tue, 14 May 2013 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=S50lZyb2DJ59y100VA/PEJmQfrLKtDNYsKbbmqHeuVE=;
        b=Oz+CE3QhuWVExQzwqv0Z6NbxMbe8mcP/Zfn4FrOPGLYLJbVojjcBwwjwVtTwmnUiPR
         BqjWDlhPHNewdV8+DiLBixW69J7BJI/SO5cfQzz+6JWgk/IBRd6dOb8TykfFHcUiznZa
         NCazabg1glN/uNgeJvqBLWqDbydAuV5CcBFTdDLlpaehhvKJkWK0BgQWaxhbVaVsgDxh
         ONENc6uGNgqatiHCI3yuP9emS6aPuBTE5l9SMLsYCiXeZxvjaRKab670FwKYH61XsQQi
         WKAKexkrm7GZybVsckVLRXhhKQwMOiCYZzD/JmsnqQW5uQEGtVLnIMt2ED2AMTzRdv12
         +Oeg==
X-Received: by 10.182.49.201 with SMTP id w9mr1272934obn.38.1368526933146;
 Tue, 14 May 2013 03:22:13 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 14 May 2013 03:21:42 -0700 (PDT)
In-Reply-To: <1368523634.10814.3.camel@vpl-thinkpad10>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224297>

On Tue, May 14, 2013 at 4:27 PM, M=C3=BCller  Kirill
<kirill.mueller@ivt.baug.ethz.ch> wrote:
> Thank you, this looks nice. What needs to be done that this will
> eventually reach the git in my favorite distribution? Which version o=
f
> Git will this be?

It'll be in the upcoming 1.8.3.
--
Duy
