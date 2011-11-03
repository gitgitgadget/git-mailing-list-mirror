From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>
Subject: Re: error from 'git push' on v1.7.8-rc0
Date: Thu, 3 Nov 2011 12:49:20 +0100
Message-ID: <CAJzBP5Q1LaUBL_wHFfaY-cLatd_=oez9j+=60z3kxwg_47GN_Q@mail.gmail.com>
References: <CAJzBP5Q1_zX+H0jeBZNB81KLYAbtJWhUuHA3rf8CuW-_OSFXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: gitlist <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 12:49:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLvnR-0007LI-Vb
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 12:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753Ab1KCLtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 07:49:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43359 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab1KCLtV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 07:49:21 -0400
Received: by ywf7 with SMTP id 7so1224757ywf.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=Pz99L/C+50Ui8ttGbc3KEFjJhYwYBIFQBUHkZp9LJ20=;
        b=k+uFixh1/2biprFLNgUKyx+27D8rLeaKIKaSghuiTobGRqwr+WYSpgZfORX0duUCYf
         XVpwn1pW0V9hqr26w1DmxmTg6qoO4wbBjlhFqA6hZ5ycyzljW+ZJySXSbLmOYdoiwcF/
         ft7Qc0X1aAxoRfpwvLBHl75wtbcQgezE4gYXc=
Received: by 10.101.155.21 with SMTP id h21mr2056820ano.69.1320320960518; Thu,
 03 Nov 2011 04:49:20 -0700 (PDT)
Received: by 10.100.33.12 with HTTP; Thu, 3 Nov 2011 04:49:20 -0700 (PDT)
In-Reply-To: <CAJzBP5Q1_zX+H0jeBZNB81KLYAbtJWhUuHA3rf8CuW-_OSFXbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184716>

On Thu, Nov 3, 2011 at 12:43 PM, Stefan N=C3=A4we <stefan.naewe@gmail.c=
om> wrote:
> I get errors from git push when trying to delete a (remote) branch:
>
> $ ./bin-wrappers/git versiongit version 1.7.8.rc0
> $ ./bin-wrappers/git push -q . :refs/heads/nogofatal: bad object
$ ./bin-wrappers/git push -q . :refs/heads/nogo

(re-wrapped)

$ ./bin-wrappers/git push -q . :refs/heads/nogo
fatal: bad object 0000000000000000000000000000000000000000
fatal: bad object 0000000000000000000000000000000000000000
remote: warning: Allowing deletion of corrupt ref.


Stefan
--=20
----------------------------------------------------------------
python -c "print '73746566616e2e6e6165776540676d61696c2e636f6d'.decode(=
'hex')"
