From: Christopher Dale <chrelad@gmail.com>
Subject: Re: [PATCH] Adding hooks.directory config option; wiring into run_hook
Date: Fri, 16 Dec 2011 12:28:17 -0600
Message-ID: <CADQnX_c=WUYgjTkXC2vNCua=6Cf7CMBBfnteBv2hE_kGH=y9UQ@mail.gmail.com>
References: <CADQnX_e76LzuRUDOKFOsRHU=e8Cw+qh5x1BdW5HMEdMmP5PaHg@mail.gmail.com>
	<7vmxasie6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbcWB-0003MN-3T
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760494Ab1LPS2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 13:28:23 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34538 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760406Ab1LPS2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 13:28:18 -0500
Received: by werm1 with SMTP id m1so545186wer.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XYWm07Uf3ECRXCi4WBg7emXbxp+X/yS6s9rrqQg/c40=;
        b=t1mZA7+PWso9w/zYtlxyrqo3kFdFvuc8xN55LPII4AMpXjz3gGmYDgS0Dwj/wkYIR6
         A9ipJ4eRgb85aFa2dIeY+oaC0vPpAAfXT7e9v+eabY5TOUaxRMxqo+bIrnbPHl3BlM2S
         xTcwBL3VX/TDd74TZFy8ihhnsVkxGgAXOB3aU=
Received: by 10.216.138.151 with SMTP id a23mr3614898wej.52.1324060097632;
 Fri, 16 Dec 2011 10:28:17 -0800 (PST)
Received: by 10.216.155.148 with HTTP; Fri, 16 Dec 2011 10:28:17 -0800 (PST)
In-Reply-To: <7vmxasie6k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187296>

Okidokee, thanks for your feedback :)

On Fri, Dec 16, 2011 at 12:06 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Christopher Dale <chrelad@gmail.com> writes:
>
>> ...
>> trusted path execution policies. These systems require that any file
>> that can be executed exhibit at least the following characteristics:
>>
>> =C2=A0 * The executable, it's directory, and each directory above it=
 are
>> =C2=A0 =C2=A0 not writable.
>>
>> Since the hooks directory is within a directory that by it's very na=
ture
>> requires write permissions,...
>
> Sorry, but I am not interested at all. If you can write into $GIT_DIR=
/config
> then you can point at any directory with hooks.directory and that wou=
ld mean
> it would defeat your "trusted path execution policies".
