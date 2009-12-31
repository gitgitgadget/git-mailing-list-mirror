From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] Problem with apply
Date: Thu, 31 Dec 2009 13:49:57 +0100
Message-ID: <40aa078e0912310449g4d503ba7t612e532f5069051f@mail.gmail.com>
References: <SNT131-ds16B1679EFC8F74B62D4630C4780@phx.gbl>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: richardpreen@hotmail.com
X-From: git-owner@vger.kernel.org Thu Dec 31 13:50:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQKTi-0008Su-7i
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 13:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbZLaMuD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2009 07:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbZLaMuD
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 07:50:03 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39889 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbZLaMuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Dec 2009 07:50:00 -0500
Received: by ewy19 with SMTP id 19so4580909ewy.21
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 04:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3MmPFdqMit3iSgSFKGzBhPUmylMDlwl6Wb/mZ/1GmhY=;
        b=VR8wZKpiSUNfAlh6KmrDPrwK4ajOjd0fg70J9MioKC4yrQDrV8Ldss8rfHZm547kPV
         M3DWFLO9cAgtej3fC2/+1u3Te+TTa0BrHK5Ymvc5ALgVYuCOHE2xLLa92GhpouTw9+XK
         YQcNPdLfoCI1F5n2cMf9CLcNx+POPArZTB49A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=wT0xvz4bS95LCQ73IimB6ouEN5ozF85XQTgMWD32yTTRmnbQnKPhSF8SlkJwPrPTMq
         gD0eEMUBNzivxqIcUXqcRjPCCSThKo+PruCuF1jYc/7y7VeyUodiG7hJWfcYacOX3AiR
         R2JRWCB7OLHOH63Zs4NfjcXhsLJGZ125jNsrI=
Received: by 10.216.87.66 with SMTP id x44mr7308019wee.96.1262263797340; Thu, 
	31 Dec 2009 04:49:57 -0800 (PST)
In-Reply-To: <SNT131-ds16B1679EFC8F74B62D4630C4780@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135947>

This isn't a Windows specific question, and would be better for the
main git mailing list. I'm CC'ing it in hope that someone there knows
the answer.

On Thu, Dec 31, 2009 at 1:26 PM,  <richardpreen@hotmail.com> wrote:
> I'm trying to use git to create a binary diff of two files and then a=
pply
> the diff to the=A0first file in an attempt to make both files the sam=
e (just
> testing the concept);
>
> git diff --binary --no-index original\t1.ppt modified\t1.ppt >
> original\my.diff
> cd original
> git apply my.diff
>
> This is giving me the following error message;
> fatal: git diff header lacks filename information (line 3)
>
> Any suggestions as to where I've gone wrong?
> Thanks.

--=20
Erik "kusma" Faye-Lund
