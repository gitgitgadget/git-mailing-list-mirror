From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: windows git problem
Date: Tue, 13 Sep 2011 20:30:51 +1000
Message-ID: <CACsJy8Cy0nFuAVzfN9sGgd3wiQ1HE2ASW7vqY5PGt4bH4BCvtg@mail.gmail.com>
References: <4E6E42CE.80405@tandvsolns.co.uk> <CAMOZ1Bs6tGGJ8eZja0OaqtzK0imKt_NtiWOTgpLCaisvEXh2Rw@mail.gmail.com>
 <4E6E5000.3040203@tandvsolns.co.uk> <CACsJy8B4RY4Yst9TPhNCOj8AUziFa+O+2Msen9Bt=QHo5SW=sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: luis <luis@tandvsolns.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 13 12:31:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3QH8-0005lb-Dd
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 12:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab1IMKbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 06:31:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42546 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab1IMKbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 06:31:22 -0400
Received: by bkbzt4 with SMTP id zt4so379591bkb.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AjmcwYvKyilOem/hfPgbqjYn+hJdER0ScvaStnM8CPM=;
        b=Hgj6+kc6lvzGIBjOPcm8W0Kspr16mwZ6eS83sj/hHpcPArWvR81xK1pq5QUWbvj6cW
         mqc9eASrdiEIJ/B052qS8BmvM0ouMq6H40gkBaDuIx/2lb5SDiv7CtCK6kyz/fbDExP1
         deFPwS5q21JjKVGVesttKH7ckwMi6zsokkMAg=
Received: by 10.204.146.132 with SMTP id h4mr531139bkv.287.1315909881173; Tue,
 13 Sep 2011 03:31:21 -0700 (PDT)
Received: by 10.204.7.4 with HTTP; Tue, 13 Sep 2011 03:30:51 -0700 (PDT)
In-Reply-To: <CACsJy8B4RY4Yst9TPhNCOj8AUziFa+O+2Msen9Bt=QHo5SW=sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181281>

On Tue, Sep 13, 2011 at 8:10 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Sep 13, 2011 at 4:31 AM, luis <luis@tandvsolns.co.uk> wrote:
>> Exactly!
>>
>> so the next time someone (in windows) does a commit, they remove the file or
>> the folder contents!
>
> May be this commit dc1ae70 (Support case folding for git add when
> core.ignorecase=true).

I take it back. add_to_index() is mostly called by git-add. A checkout
fills the index with unpack-trees, which does not seem to be
case-insensitive to me.
-- 
Duy
