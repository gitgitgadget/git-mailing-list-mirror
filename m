From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/8] apply: accept --threeway command line option
Date: Thu, 10 May 2012 19:40:49 +0700
Message-ID: <CACsJy8B18gua5kRCTY6aE13J1T0YROmvSFP+88XCunOZm32mww@mail.gmail.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com> <1336629745-22436-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 14:41:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSSgX-0001fe-0O
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 14:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab2EJMlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 08:41:22 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61666 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758518Ab2EJMlU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 08:41:20 -0400
Received: by lahd3 with SMTP id d3so1029821lah.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jQFmSdHIT2ZZdXvzyBiZwlSV/SEt9bfSjlbORh7ZejQ=;
        b=faR7y9/WwGs5wwFXvYnGLJ6IDc0qNg+kGmRb0Gbhue2JE6ML3QwNCtfRri2roaASV7
         n87+PROiHxONk8KeT5/ibZ/Vb1pnP9FWR5Vgz7KYbg5gsxhwA3D1IkFGxvidPiNMXUvC
         /xl0GkIlT4wG2yKRKdbuy0UfMwRnf8w9iAs/r0wD2G5gWZzZZaC29bylKzbedEPydG++
         35qDS3zqVx6QnuLQSG+7wquCrtkUEPg0/C4/bQ7uH3dLyaWCJNOdbIFmhMGghqLKvCiM
         WCOhRapWhSbTlZO3K0hRylxfroOc/oHzl+6juFFfisKx5XMqX2VZ2oDJK1wzqXCspfqa
         ZUkg==
Received: by 10.112.45.230 with SMTP id q6mr1676252lbm.103.1336653679497; Thu,
 10 May 2012 05:41:19 -0700 (PDT)
Received: by 10.112.17.167 with HTTP; Thu, 10 May 2012 05:40:49 -0700 (PDT)
In-Reply-To: <1336629745-22436-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197558>

On Thu, May 10, 2012 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> This is the beginning of teaching the three-way merge fallback logic =
"git
> am -3" uses to the underlying "git apply". =C2=A0It only implements t=
he command
> line parsing part, and does not do anything interesting yet.

Can we reuse '-3/--3way' instead of --threeway? I already have hard
time remembering which command uses -m/--merge, which one -3.
--=20
Duy
