From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.7.rc3
Date: Mon, 26 Sep 2011 14:47:09 +0200
Message-ID: <CACBZZX77ZhdS1cyiYpjJcuvSnJsv15FUumPWeZOcwh_b41c2FQ@mail.gmail.com>
References: <7vhb42su6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 14:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Aam-00013E-Bz
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 14:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab1IZMrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 08:47:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47133 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab1IZMrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 08:47:11 -0400
Received: by bkbzt4 with SMTP id zt4so5756914bkb.19
        for <multiple recipients>; Mon, 26 Sep 2011 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pKI6QDPhRidZNhty4n2wZdiJIpjGHQiUNaCRz/4vN/s=;
        b=vNsnJNj4N6Q5iPxhsaTK0Cx9QFqBFtIB55jxohEJY/A5uGiuH1gW1U9/aQLjoOg/5y
         GUB3J/kvlhixl3/90dPBQXQjthDrikoimqGH+cuEulQjn5KLsCksg+SFNRAmbHJgirGd
         9Ia13Gt51NDjn9jcOj8bO93BcyUpcnM7JCe+c=
Received: by 10.204.132.212 with SMTP id c20mr1605405bkt.352.1317041229958;
 Mon, 26 Sep 2011 05:47:09 -0700 (PDT)
Received: by 10.204.119.203 with HTTP; Mon, 26 Sep 2011 05:47:09 -0700 (PDT)
In-Reply-To: <7vhb42su6f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182106>

On Sat, Sep 24, 2011 at 01:41, Junio C Hamano <gitster@pobox.com> wrote:

> Also the following public repositories all have a copy of the v1.7.7-rc3
> tag and the master branch that the tag points at:

The 1.7.7-rc* series still doesn't compile on older Red Hat machines
because 4c1be38b4a236403a329187acb70591a7fd92150 hasn't been included
in it.

Could you please include that in the final 1.7.7? It would be a PITA
to have to work around that.
