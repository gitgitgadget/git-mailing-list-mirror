From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: why '--init' in git-submodule update
Date: Wed, 7 Nov 2012 08:10:45 +0100
Message-ID: <CAC9WiBhvEX8VCprytK8HMTdFX+iQE7K=a4cKb8MphhpDowaw6A@mail.gmail.com>
References: <CAC9WiBgpHWFGW-z5fnQR_EWnfGJUw+G3b7C6tYMGuVu1S-kP9A@mail.gmail.com>
	<20121105213004.GA2797@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Nov 07 08:11:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVzmu-0000oL-H8
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 08:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab2KGHKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 02:10:46 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60278 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab2KGHKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 02:10:46 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so1286677obb.19
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=37lKhGSbPxUuucZz2NbRfQokx/V4XPGwhAkYUqtrfjk=;
        b=t/lwUiuxvXSsAZ3HULlYfetukfRAgxMWI8QMKyyohHGAQyHT1EhgASC9d1DrOZlweu
         w5P6txzg92B5FfVEBUY+E0EdMdAl8MywIzRT61WS755WwZn887olr3bW25/LltsoxB3w
         BgP7rJzr4ivY/9LOeN3In53ccwoe3fd9zSqffyDXD7gHSgwTAmcBVEg51MNCYF92wv3i
         PGllbIFupjqmIP3w0FAwWAEN2gGD6B4mX4ZFRevi3WQrbFZTzrMGkDyNK/w5twqLKCto
         21V/oNFCSCB03EBcDUkEdpv4KqTHQ3CjYccvryuhxMgTv4dVnFAr9hODtJX387GaEFhr
         SsUQ==
Received: by 10.60.169.38 with SMTP id ab6mr1355907oec.139.1352272245635; Tue,
 06 Nov 2012 23:10:45 -0800 (PST)
Received: by 10.60.93.163 with HTTP; Tue, 6 Nov 2012 23:10:45 -0800 (PST)
In-Reply-To: <20121105213004.GA2797@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209130>

Hi,

On Mon, Nov 5, 2012 at 10:30 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Mon, Nov 05, 2012 at 05:30:51PM +0100, Francis Moreau wrote:
>> I'm wondering why the --init option from git-submodule-update is not
>> at least the defaut. Or even wilder, why this option exists at all and
>> git-submodule-update always behave like --init was always passed.
>
> That was a design decision. People may not be interested in all
> submodules but just a subset they are working with. E.g. think of a
> large media directory as a submodule the developers might not be
> interested in having it around all the time because only the designers
> are heavily working with it.
>

Thanks for explaining.

Another possible solution was to check if one or several submodules
are already checkout. If so then update only them. If none of them is
checkout then assume --init is passed and init all of them. Same if a
path is passed and this path corresponds to a submodule not checkout
yet.

--
Francis
