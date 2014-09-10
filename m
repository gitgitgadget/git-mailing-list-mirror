From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Wed, 10 Sep 2014 17:25:36 +0700
Message-ID: <CACsJy8AO5Ni1BNJGa1Wy5ZdX=HNE1UuVM-gnwtHBw01sfcZNrg@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> <20140910081358.GB16413@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 12:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRf6L-0001AU-Dq
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 12:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbaIJK0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 06:26:08 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:52805 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbaIJK0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 06:26:07 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so6234350igb.8
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/PDGcpPxfS6ruY3+y4G9w4O5xGBS7+EJVO9TlODBnTg=;
        b=YwUKejA6v62OE6Aie3EZH5vxV30PqTTUQtfFXtrAZr+VZRr0psWzgERchamIw7v4JD
         eAxdaItMyXsj5i6l3CmqxPJ4FVb5M5gqgdExbUtMJOM4kYB7RQpfQZ92uWVA0im/QEG6
         ciWmUbnvd/8bUK++DeHOA44M6SHLRWtbTUHF1xsKVSIHRTnbkmEyO6pqz23aoTKqAXIF
         29XY8tfXxE6ENbvMhiOu2lemL4aifJ0oNpjAnbPwppjGNCrPZv47tyGz/PVvXPWeNpmf
         zqlwBGTTBWBF8Hsj0EdROUcniEA6xHV9tzpF13BqW67FbfVI7R5jWMYiaMgMHmih7B2Y
         Xh2A==
X-Received: by 10.50.66.229 with SMTP id i5mr26655778igt.27.1410344766999;
 Wed, 10 Sep 2014 03:26:06 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Wed, 10 Sep 2014 03:25:36 -0700 (PDT)
In-Reply-To: <20140910081358.GB16413@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256731>

On Wed, Sep 10, 2014 at 3:13 PM, Jeff King <peff@peff.net> wrote:
> I was running pack-refs on a repository with a very large number of
> loose refs (about 1.8 million). Needless to say, this ran very slowly
> and thrashed the disk, as that's almost 7G using 4K inodes. But it did
> eventually generate a packed-refs file, at which point it tried to prune
> the loose refs.

Urghh.. ref advertisment for fetch/push would be unbelievably large.
Gotta look at the "git protocol v2" again soon..
-- 
Duy
