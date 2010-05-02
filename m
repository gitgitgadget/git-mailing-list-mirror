From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: [PATCH] index-pack: fix trivial typo in usage string
Date: Sun, 2 May 2010 14:11:15 +0100
Message-ID: <t2n86ecb3c71005020611l1beef4a5tfa0448416f0db491@mail.gmail.com>
References: <ea91a4320bf70e3bb4acee0c9b134338c1f36d51.1272555727.git.git@drmicha.warpmail.net> 
	<p2pbe6fef0d1005012333tb5cb1487y47512633731a80a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 15:12:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Yxl-0000Cv-A8
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 15:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab0EBNLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 09:11:37 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:57078 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab0EBNLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 09:11:36 -0400
Received: by pzk42 with SMTP id 42so838543pzk.4
        for <git@vger.kernel.org>; Sun, 02 May 2010 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=8g3BvozQmv93cRUhLeawwRX9yAJhMYHWDFrP1V8qQVI=;
        b=nsk3p+CUz0cheWF7Szn4a0nrIedGtBpiuTqkwYpa0oKcn3fmXp0cZ+zC81OoGNOs2p
         geRHF+CRcZ8GY1fOPV9/bLY6Vyuk7SO5Ky50KAtBoe/IZ5M9XWs2jUoy6CekR5DXBwui
         jJCpo1fYiwACmNi3BRvfhtVsv0FMyGLbadR2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=X2ideCtGWHVY+3ZaObsppGpz21h+qYYkDjrNo3t3NWVDNSUbfLd4tCqqPcDZF7KKFy
         D/LlygNDVf1AuxBQAHJdo7odZzjsvSUHueLUNmXPlqKEA+khHxcRCrhFPtRCqJAEgGDb
         cgHQEggf8P/cZL0pGGj5z6ms5AxoKeWo+sSC8=
Received: by 10.143.25.2 with SMTP id c2mr59563wfj.147.1272805895096; Sun, 02 
	May 2010 06:11:35 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Sun, 2 May 2010 06:11:15 -0700 (PDT)
In-Reply-To: <p2pbe6fef0d1005012333tb5cb1487y47512633731a80a0@mail.gmail.com>
X-Google-Sender-Auth: 0c657c29ff62b32d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146172>

On 2 May 2010 07:33, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Sun, May 2, 2010 at 2:35 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> -"git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
>> +"git index-pack [-v] [-o <index-file>] [{ --keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
>
> to save some eyeball-time, the change was s/---keep/--keep/.
>

Thanks =)

I wonder if there is a normal email client which can syntax highlight
git-format-patch emails with per word changes ;-)
