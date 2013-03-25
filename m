From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Mon, 25 Mar 2013 16:43:14 +0530
Message-ID: <CALkWK0=f01C_5UP7WhgS0sXHdetbXe9YSroXx-PVvmp29FO9ew@mail.gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <513FB85C.5010106@gmail.com> <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
 <5140BC80.4000201@gmail.com> <7vtxof146d.fsf@alter.siamese.dyndns.org>
 <87ehffv30f.fsf@pctrast.inf.ethz.ch> <CALkWK0=0+HYn=bSrGC5sMQOE-53As0h9dG3N9wvUB2=NW3=98A@mail.gmail.com>
 <87r4jdt404.fsf@pctrast.inf.ethz.ch> <CALkWK0nt22NW=_iH2u8iiOMofoF6k+1sZLp-NsoYZtbADfCEuQ@mail.gmail.com>
 <CACsJy8Bx83P=HK1pcy7ASnP5t+_snERxnVxji9_TGW-3fuUq-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 12:14:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK5Ln-0005iT-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 12:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab3CYLNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 07:13:35 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49010 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab3CYLNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 07:13:35 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so7208252iec.18
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DP1GjzUy5iDSroBQGb8KNFYK5P2oXbIkdQW+dduljVw=;
        b=MODohzlNOfB3jPieft3XlnnmqgqtzXix2A+cCppX9L6xc3UjmQvtDNuy8nYJHiTZJM
         LVNYlNkpYvcSi90vokMNKb5qIBZGePdA+wFWta7V7pvJAAT7PYUA+VXBCedLK8F6hPen
         NHMSFuH7OoRD4vPWIfQZeBzRNMqFBdd/cEM9J/KHK/d/N5XWFAKj2nQNHkH6exoBp5j/
         gpN+ICNOgGTle7s0fhB603XTudIG+th6AUvh0IVPu/O2VPILu9oewg2fmJBBLJ8Ynpab
         iJf96l453oUI8BfbVqxOLMzKVH7FW2/LLLW6nlnmv37/lb7NiSZr2xoLXHD8p5F2u2fU
         EM1Q==
X-Received: by 10.50.17.166 with SMTP id p6mr11058944igd.12.1364210014845;
 Mon, 25 Mar 2013 04:13:34 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 04:13:14 -0700 (PDT)
In-Reply-To: <CACsJy8Bx83P=HK1pcy7ASnP5t+_snERxnVxji9_TGW-3fuUq-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219031>

Duy Nguyen wrote:
> On Mon, Mar 25, 2013 at 5:44 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Just a small heads-up for people using Emacs.  24.4 has inotify
>> support, and magit-inotify.el [1] has already started using it.  From
>> initial impressions, I'm quite impressed with it.
>
> Have you tried it? From a quick look, it seems to watch all
> directories. I wonder how it performs on webkit (at least 5k dirs)

Yeah, but only on some small repositories.  I expect it to be
problematic on big repositories: if I'm not mistaken, Emacs will
block.
