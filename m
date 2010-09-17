From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv2] remote-helpers: build in platform independent directory
Date: Fri, 17 Sep 2010 23:07:49 +0200
Message-ID: <AANLkTi=ye=Xkz2XaiBaqX3NsZOe0N1NRTaVpPcsSM8o9@mail.gmail.com>
References: <705f70e3df519fc28e551b4c0bd7512277e7a190.1284757060.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 23:08:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwiAT-0007Au-7d
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 23:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab0IQVIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 17:08:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49259 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab0IQVIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 17:08:10 -0400
Received: by ywh1 with SMTP id 1so868030ywh.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=JTxfBonL6tgw7smqwy7otxg1kSbW59I9Pb+eH20VB/M=;
        b=jXohPImPML+ii8crziZkSHXdsLsIDLqTWcpxapnWRGNPoGgipyEkg8IR5n+IXwUW57
         3d/AOQQwK81Pl+qUU19MMuA9LfrDkltROGgy6kUyJEmZpg8VpslYwBLadfHCHwzeqknK
         UoH2Iy81cSIG5ZYeR4Yizp7Bj7bnGrwXeWV0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xjzUNRmzCuW9Dnv52agsEuoh3iuNrMWXrkkUPlpTnY4zZNSQh3g5bBJuxH0VBtegNi
         oHi3Y/8rBMnm6lyGAd7Ad240MVdFqn4DUQaFD49RSLC6W7K2ivmsRWUxwOnqWlj5I+ad
         52Ly9je59IY0vN5seZ7ZOlkOpLQ3F1gM1ICLM=
Received: by 10.151.42.16 with SMTP id u16mr6051703ybj.396.1284757689245; Fri,
 17 Sep 2010 14:08:09 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Fri, 17 Sep 2010 14:07:49 -0700 (PDT)
In-Reply-To: <705f70e3df519fc28e551b4c0bd7512277e7a190.1284757060.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156413>

Heya,

[+Jonathan again]

On Fri, Sep 17, 2010 at 23:00, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The solution with setup.cfg avoids this and is cleaner anyways.

This does feel a lot cleaner, I like this approach better than the v1
one. I suspect Junio's question still stands though:

On Fri, Sep 17, 2010 at 20:41, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, wouldn't this interfere with the install target if you do not tell
> the "setup.py install" where your built stuff lives?

-- 
Cheers,

Sverre Rabbelier
