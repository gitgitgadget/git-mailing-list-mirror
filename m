From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: .gitattributes escape character?
Date: Wed, 3 Nov 2010 22:47:37 +0700
Message-ID: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
References: <4CD15461.9070201@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 16:48:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDfZH-0003QF-SE
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 16:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab0KCPsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 11:48:01 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42081 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab0KCPsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 11:48:00 -0400
Received: by gwj21 with SMTP id 21so555890gwj.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=mjQSfrcha85V2GLXyLQbNyd+Sqb8+AZMXklBoUsHTMw=;
        b=QBpcZsXe6DirrXR9rG03hLrLs+ChZ6anGz6VW44Vp76r8qqKriybbZaFjTzVOa8T0r
         DEvidfj60ASXQJ/I3JGNF2y7Z5Izs0+BMFv7w03olNq68Xxp+Pb5ajWbn/25Gc9VTGa0
         XHqutb8hXD8rcb/1Nv7qj9okNllpK39YkgNjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KbfpylR5tUAXTj/1IeoMbls7jwpqjV2F8QjBhoODF/jBbMs3vzxJFKaVBLNLoge1ZY
         L1wuG8u7W77AZmfj3c7XovJkck2NgdvACesx28/nDODDCjydTQFqD1I5FkdM1zoamsOB
         PEIARtsW2c55GfSBDkFFgfWiWcKEl1DFgTa38=
Received: by 10.216.47.19 with SMTP id s19mr752328web.56.1288799278654; Wed,
 03 Nov 2010 08:47:58 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Wed, 3 Nov 2010 08:47:37 -0700 (PDT)
In-Reply-To: <4CD15461.9070201@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160603>

On Wed, Nov 3, 2010 at 7:24 PM, Marc Strapetz <marc.strapetz@syntevo.com> wrote:
> Is there an escape character which may be used in .gitattributes to
> escape e.g. the space-character? Could octal-escaping help here (I
> didn't succeed)? Thanks for any hints.

You mean escape the path part in .gitattributes? Sorry, no.

I think we can teach git about path quoting though. A leading double
quote means the path is quoted, C-style.
-- 
Duy
