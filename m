From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Failure cloning from a separate-git-dir repository
Date: Sun, 21 Aug 2011 01:25:36 +0700
Message-ID: <CACsJy8AavETJb-Lm0Qd6Sz54zYbgvDUWmf+uXYTxO3+iYNHvoA@mail.gmail.com>
References: <6csv47te4qv41ni53q0kf1fne0a4e1grnm@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Tibbitt <gitlist@lazyprune.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 20:26:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuqFQ-0005Ml-Vs
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 20:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab1HTS0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 14:26:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40084 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab1HTS0I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 14:26:08 -0400
Received: by bke11 with SMTP id 11so2874240bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=n5e3fK3o8F3CslVRyTrcTRNK+CfeIAYpahXjgaRrMaw=;
        b=DSjeMOQAa8zy0CncrgzHxClIeMMiSyfg1PMGkzL2oDSa99i+/0ZS6R1ciOOy1DdPv9
         XZ2Cw0aTsrDFZvL09wPB2zxGnrxOOBY+sPCrn92peKPtXUEJOOwScm1QTfEaGUy9TCx9
         35aUfcctHQA1NK9eUyKCiZAv6V6/+LAxqfHM4=
Received: by 10.204.151.70 with SMTP id b6mr250453bkw.71.1313864766442; Sat,
 20 Aug 2011 11:26:06 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Sat, 20 Aug 2011 11:25:36 -0700 (PDT)
In-Reply-To: <6csv47te4qv41ni53q0kf1fne0a4e1grnm@4ax.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179768>

On Sun, Aug 21, 2011 at 12:47 AM, Richard Tibbitt <gitlist@lazyprune.co=
m> wrote:
> =C2=A0F:\>call git clone repo2 clone2
> =C2=A0Cloning into clone2...
> =C2=A0fatal: failed to open 'F:/repo2/objects': No such file or direc=
tory

This should be "git clone repo2/.git clone2", but with that command I g=
ot

Cloning into clone2..
error: '/tmp/repo2/.git' does not look like a v2 bundle file
fatal: Could not read bundle '/tmp/repo2/.git'.

You just do "git clone repo2git/.git clone2" for now.
--=20
Duy
