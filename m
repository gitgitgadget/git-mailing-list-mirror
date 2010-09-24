From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Minimum Perl version?
Date: Fri, 24 Sep 2010 10:23:11 +0000
Message-ID: <AANLkTin_wrCnpz-fz=FuJ96j+xBHM1-5HTGG0vP7bmDY@mail.gmail.com>
References: <20100924100019.GT23563@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 12:23:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz5R0-0003a8-8B
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 12:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab0IXKXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 06:23:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43508 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0IXKXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 06:23:12 -0400
Received: by iwn5 with SMTP id 5so2288343iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=c06g/jRIVWPbroA1EbOQ041+o5J1tHB3WsTv6x/tMS0=;
        b=UJTSTpcQw1bW+dRR+YD4/l3ZLZoUQI6gaK0VIfbxwHT6evGUvUjOi1igcatoHN1Ckg
         zVg/GiRMTeRO9M9ekMZBPreMz2UBhZ7k88kdLHR/TKz/C0jkPvbfG4LVuZAdfSMas+Is
         fCHzMzV0Q/M0P7R0pswnx/Knw5OnwrvGACE+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rpH+c0yDhoc1pCHvVxO3y29OcF/1hlDS232pyHZMYck5Cy03ii7z5+RwzQpIilDw+g
         qyASIPBRSLPrcljU8mIbITnFkcXolq++l2KgIna7ssL0l+/ZzQP+MKKVRo4XzYXaKv7X
         Ztgte5NIVhhKZX3fUvYGYIEsvaQwP1OJaQZ4U=
Received: by 10.231.190.149 with SMTP id di21mr3513893ibb.166.1285323791949;
 Fri, 24 Sep 2010 03:23:11 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 03:23:11 -0700 (PDT)
In-Reply-To: <20100924100019.GT23563@ece.pdx.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156968>

On Fri, Sep 24, 2010 at 10:00, Tait <git.git@t41t.com> wrote:
>
> What is the minimum Perl version git expects to support?
>
> I ask, because f922df8... seems to have introduced a open() syntax that
> is not compatible with some older Perl versions.

We generally support 5.6 or above, but 5.8 or above for some other
programs.

As far as I can tell there was no new open syntax introduced in that
series that wasn't supported before.

What specifically is breaking for you, and on what perl version?
