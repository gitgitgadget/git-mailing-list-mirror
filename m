From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: How to see 'assume-unchanged' information
Date: Tue, 20 Sep 2011 22:02:52 +1000
Message-ID: <CACsJy8B1jPmkLB8xq86Ji52G=zGn+3K1_meL5K2T-spDpagL6A@mail.gmail.com>
References: <4E787AD3.2000208@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 14:03:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5z2v-0004t3-0N
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 14:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab1ITMDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 08:03:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40753 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab1ITMDX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 08:03:23 -0400
Received: by bkbzt4 with SMTP id zt4so395826bkb.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 05:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/wQKL9cD0nB8Wj8vUr9tSOhV2Ob8VVnzATZzZc64DH0=;
        b=HHqsG4LT2HRJaahFymVNki0puiGAY8Vpoboaj+pJALsC2O7ClzUVmefwScMkKVphe/
         19ttMBWzy0OiAHGTkNNyiAPmn3IO4EiK6FzWNe2bT/n/BzLY5CR2t6ozxltWzRtZrFSV
         D6ohguec2ZQXMQBkylfNpRIRQDVlAfmsE0aVI=
Received: by 10.204.133.156 with SMTP id f28mr506668bkt.79.1316520202209; Tue,
 20 Sep 2011 05:03:22 -0700 (PDT)
Received: by 10.204.7.1 with HTTP; Tue, 20 Sep 2011 05:02:52 -0700 (PDT)
In-Reply-To: <4E787AD3.2000208@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181758>

On Tue, Sep 20, 2011 at 9:36 PM, Stefan N=C3=A4we
<stefan.naewe@atlas-elektronik.com> wrote:
> Hi there.
>
> Is it somehow possible to see which files have the 'assume unchanged'
> bit set ?

git ls-files -v
--=20
Duy
