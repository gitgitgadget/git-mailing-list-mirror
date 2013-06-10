From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] completion: remove ancient "ensure colon in
 COMP_WORDBREAKS" workaround
Date: Sun, 9 Jun 2013 21:58:18 -0400
Message-ID: <CAPig+cQZUa1mD0+dutNYowGbAXqEqWvfMUm-Vf+-1ap3xy3A-g@mail.gmail.com>
References: <1370822361-15637-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlrNI-0008Hj-CK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab3FJB6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 21:58:20 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:44121 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab3FJB6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 21:58:19 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so3729715lab.40
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FbV7mYf7gd5Uxh+vJiqA1/qfI5xtEaAWFqxfUneKrKg=;
        b=M02F3RaReAGwTxI7NCGVh4xsTH+QAbVn7o9F3/wVCN2MGbfUtVYRjRScRPT+sBeGtG
         a9tNk7nxHIacMsEVoxZjW+isbbp7ecNk5v7Go2Dyj8vbQ+RJSBT2bl0zFO56QBCV6Uq4
         bFysNJQxTVGmKKfLQf3z+ICmltjOwW2PKv9ceXdTi7F0nK1Yv80VRnna7p7hVFRPX2aU
         Tno5+mtnV4EX0TGzqZdaNR6w2xL1dQ2oGOHyQ6v0H8u91Lv4sOEiiB3qS65Chs3oZ39t
         975fEgIhc3Z6oQ40oaNCRTYNvAfcWL65/XHO+AESw3u9HnsE6zxmZ0Tm9UgqfwgNQniz
         SFLA==
X-Received: by 10.152.43.82 with SMTP id u18mr3778412lal.86.1370829498223;
 Sun, 09 Jun 2013 18:58:18 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 18:58:18 -0700 (PDT)
In-Reply-To: <1370822361-15637-1-git-send-email-szeder@ira.uka.de>
X-Google-Sender-Auth: cIjvyK3w9MB9j9UIh3A-DiEECs0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227230>

On Sun, Jun 9, 2013 at 7:59 PM, SZEDER G=E1bor <szeder@ira.uka.de> wrot=
e:
> Fedore 9 shipped the gvfs package with a buggy Bash completion script=
:

s/Fedore/Fedora/

> it removed the ':' character from COMP_WORDBREAKS, thereby breaking
> certain features of git's completion script.  We worked this around i=
n
> db8a9ff0 (bash completion: Resolve git show ref:path<tab> losing ref:
> portion, 2008-07-15).
>
> The bug was fixed in Fedora 10 and Fedora 9 reached its EOL on
> 2009-07-10, almost four years ago.  It's about time to remove our
> workaround.
>
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
