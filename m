From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/11] add options to for-each-ref
Date: Sun, 21 Jun 2015 17:41:38 -0700
Message-ID: <CAPc5daX6=LugA6n9DFWXxfJG-K_js73JSON7S6xbDrKWNA6Vvg@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <CAOLa=ZRLzTm1nW+JMUTqGgZ_H25A53NyHNVnH-Fd7GuBgrH+vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 02:42:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6poK-0005av-1r
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 02:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbbFVAl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 20:41:59 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33344 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbFVAl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 20:41:58 -0400
Received: by obpn3 with SMTP id n3so20870935obp.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 17:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=waD5toNBimP2u3ytTvm9+kn0uY62nGw7beZRTzFI3Ew=;
        b=Az+vr7tDpC2/Pf4dIVDNqgep9HvrAhZ84INIfWqymproCKX99swqh4mCyhWzD+c1es
         k6rJqYH9jskRcF+ErLzf9WsKFBWoImsIRVix+3xM3FhLAWs+qfIOK9LaLCQTT2+nteG+
         DEG9iJPNoTxKkyBNr0MT1ob5+9tm5Ei2IIKInepV0QGtglUZzm+wzT2Dc7BWgAjQB6KA
         dCLdqJDYDpJ6RrA36AyCzrLT1t6R6CeCRXonp8eiW6RA8VX/qWz/JLtexdXJLXWNyqmK
         jIJGaw5W2guavbNmA39V4Ql4DHx34w8O//HgWJUI4ZztKNTGr2vcKSCl8Cd0JGd4JwAG
         NdEg==
X-Received: by 10.202.4.212 with SMTP id 203mr16492059oie.93.1434933717660;
 Sun, 21 Jun 2015 17:41:57 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Sun, 21 Jun 2015 17:41:38 -0700 (PDT)
In-Reply-To: <CAOLa=ZRLzTm1nW+JMUTqGgZ_H25A53NyHNVnH-Fd7GuBgrH+vA@mail.gmail.com>
X-Google-Sender-Auth: stmloXmKZS41Nm92CkFI3FbxOWM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272309>

On Sun, Jun 21, 2015 at 1:51 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Mon, Jun 22, 2015 at 2:15 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> The previous version of the patch series can be found here :
>> thread.gmane.org/gmane.comp.version-control.git/271754
>>
>> Changes in this version :
>> *   01/11: Remove unnecessary tests and add signed tag.
>> *   04/11: Grammatical change.
>> *   06/11: Introduce a comment to explain code.
>> *   11/11: Grammatical change.
>>
>> Thanks to Matthieu for suggestions on the previous version
>>
>
> The patches end at No 11. Even though they show XY/19.
> I have more uncooked patches on my branch, which I'll eventually send
> to the list.

Just FYI, you can "git format-patch -11 my-work~8" or something like that
and get 01/11 to 11/11 even if you have more commits that are not yet ready
near the tip.
