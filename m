From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: msysgit color scheme
Date: Mon, 3 Mar 2014 00:27:19 +0100
Message-ID: <CABPQNSYPTifbRZ8jJxOe3BqnDD-x6JGTg2tSWuU8boOEVEv0eg@mail.gmail.com>
References: <CAHd499Arq_KhSKH=quez4irU_i4AjZN-anbvGn3XM--Cg4Nypg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 00:28:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKFnj-0001dP-G7
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 00:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbaCBX2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 18:28:02 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37642 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbaCBX2B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 18:28:01 -0500
Received: by mail-ig0-f174.google.com with SMTP id h18so6318383igc.1
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 15:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gcXq2KIWHCX+FiFauejz/6Xy98kGaNPPclLS2DtSHu4=;
        b=ZUODR2MrCctFZSCWY0gHUX5uR4n7OdBgImf/3j4Oe9vjHnEjaGJRBK0HENWNCC6CV5
         9UUTW0UcUR1glhuZHAO5yRUbbUaxv5jb2Q/mEBPCeTh/TG0nEVI604B52n7CaFuuaNyl
         JBgc7ZNvm6K0b3A26b66nNtRzqp0/4PG8OGJzvGPwhN7h1p5zgqI4QTc8Cxs3XFBJX/g
         JWR1DHUKl20UPXTcoIzKrM8w8Go5R02NVrGux/bucfRrZ2WtQF84fGXlOMjLhTylY/bV
         Pe72bT9ATg8yevjuinCHT4Vmsb+sYeUAoTfYAgMceS/QNnGBGtWabcDB9qpzdQ7G1HME
         golQ==
X-Received: by 10.50.254.131 with SMTP id ai3mr18460918igd.43.1393802879704;
 Sun, 02 Mar 2014 15:27:59 -0800 (PST)
Received: by 10.64.166.135 with HTTP; Sun, 2 Mar 2014 15:27:19 -0800 (PST)
In-Reply-To: <CAHd499Arq_KhSKH=quez4irU_i4AjZN-anbvGn3XM--Cg4Nypg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243165>

On Fri, Feb 28, 2014 at 11:38 PM, Robert Dailey
<rcdailey.lists@gmail.com> wrote:
> Is there a way to change color scheme in msysgit without going through
> the Properties >> Colors settings?
>
> Reason I ask is because I share the same HOME directory and .bashrc
> file between msysgit and cygwin, and it'd be nice to use the same
> color scheme defined in the bashrc between both.

Not really. The reason is that in cygwin, it's the terminal emulatorl
that does the coloring, but this doesn't work for non-cygwin programs.
So we're detecting if stdout points to a console, and setting
win32-console attributes directly. If you're interested in the
details, see compat/winansi.c.
