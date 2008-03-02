From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 0/3] fix "diff --raw" on the work tree side
Date: Sun, 2 Mar 2008 18:41:08 +0800
Message-ID: <46dff0320803020241l29277bd4m1a711ff0a863e7f8@mail.gmail.com>
References: <1204451012-17487-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 11:41:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVldc-0004qj-8C
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYCBKlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 05:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbYCBKlK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:41:10 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:28363 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbYCBKlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:41:09 -0500
Received: by an-out-0708.google.com with SMTP id d31so1108399and.103
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BMWT+xZ1APrQwQECllEZHP1U5FUZC/0DvNc4goene2A=;
        b=XOjim+Bm/3KycMLXMiQCFSiliDltc1lv+h6SlJwUvZStPbh6+FQqkLZIgD9L8ujKbJzzXxaq6eWeJ2vC1ukDm4GrVrz6IMcmSxPfEVxXsImSUQgLLRkI1AH9oE9C1vXm67IJzuirjSUS4d1YLA1UXZNF2EIZMs/H4SuUzAzrt0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R/A5AWZH3/8amj8y6nunmQVmYviOD344CbdLEe7PV3wJWLDR/oo/IGgdJmhl5EfkNd3bvM+4NgEnB21TMc31XPwSLxOaBNk/3ow0rjt5BNikgjNyOLbNjDIU6LgLiq+U8Ut/5EN8ItiM7W1/lDtoVgX9D/+PZ9/ECduFJhqP8E0=
Received: by 10.100.131.3 with SMTP id e3mr25740606and.49.1204454468616;
        Sun, 02 Mar 2008 02:41:08 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sun, 2 Mar 2008 02:41:08 -0800 (PST)
In-Reply-To: <1204451012-17487-1-git-send-email-gitster@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75774>

On Sun, Mar 2, 2008 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The second patch fixes the inconsistency between "git-diff --raw" and
>  "git-diff-{index,files} --raw" when they are used for submodules.
>
>  The third one is a bit controversial and changes the semantics and
>  existing callers and won't be considered for 1.5.5.
>
Unfortunately, my submodule summary patch series will depend on
git-diff or git-diff-index. So should i resend my improved patch only
after the thrid one is applied?


-- 
Ping Yin
