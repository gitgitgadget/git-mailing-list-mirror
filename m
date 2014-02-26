From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC 2/3] merge: Add hints to tell users about "git merge --abort"
Date: Wed, 26 Feb 2014 18:16:58 -0500
Message-ID: <CADgNjakHaS5xU3G6_DpZFEUyHHjSFrXm88vwDtfCRr9eLipJaQ@mail.gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
	<20140226203836.GM7855@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 00:17:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WInit-0000PP-3S
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 00:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbaBZXRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 18:17:01 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63960 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaBZXRA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 18:17:00 -0500
Received: by mail-wi0-f172.google.com with SMTP id e4so6556710wiv.17
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 15:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+18QmYNSPVaAPpcvKz+E6dXUeFLX8dY4jC9bm9rGzjA=;
        b=UhUHejFmLrtPFmHzVGe30ezfuDWmmREQNJioAAPaDry2+OooUg11hH7nevZq4DkuyO
         fq/saEIiAkuILJ2+Tetp5gIWhGh0mEodyjnUL83poduEOOwoz9ogzpk3wozHRvB8dgvM
         Cf96lpU136wDJ2qxNxwVUlc4+2O+n7XRO/2wIX3e/s9DPzzfACC6ZWO0aZYmRhRDjnbx
         U4hK3ir+z47PT/U10QuOwcn5ElyDD2nUZBx4majJ8TmenjW5gZdrto9FlFXRsoH2R7Lx
         aImPwlHssKsipxpV8jcTpZSvfb2cYNUztNDPflIRpBdVvcJbhkhtmcBeJzUpAWxosEhy
         swtw==
X-Received: by 10.194.85.75 with SMTP id f11mr4701869wjz.47.1393456618068;
 Wed, 26 Feb 2014 15:16:58 -0800 (PST)
Received: by 10.194.81.65 with HTTP; Wed, 26 Feb 2014 15:16:58 -0800 (PST)
In-Reply-To: <20140226203836.GM7855@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242771>

On Wed, Feb 26, 2014 at 3:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Seems reasonable, but I worry about the command growing too noisy.
>
> Could this be guarded by an advice.<something> setting?  (See advice.*
> in git-config(1) for what I mean.)

Ah, good idea. This seems to belong to advice.resolveConflict. I'll
add it there.

> `status_printf_ln` already prints a newline, so the translated message
> shouldn't include an extra one.

Good catch. Thanks!

Andrew
