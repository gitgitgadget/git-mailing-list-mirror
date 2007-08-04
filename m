From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 17:48:03 +0200
Message-ID: <8c5c35580708040848u78c4a913tf650325fff6a0bb7@mail.gmail.com>
References: <854pjfin68.fsf@lola.goethe.zz> <85tzrfh3yg.fsf@lola.goethe.zz>
	 <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
	 <85k5sbh129.fsf@lola.goethe.zz>
	 <8c5c35580708040703w44781498t7396588a3f8c81c8@mail.gmail.com>
	 <854pjfgzit.fsf@lola.goethe.zz> <85y7grfkbe.fsf@lola.goethe.zz>
	 <8c5c35580708040735l54d1b9c7i40cd80d7d11e2961@mail.gmail.com>
	 <85odhnfiau.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 17:48:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHLrd-0007Gx-38
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 17:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763737AbXHDPsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 11:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763661AbXHDPsF
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 11:48:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:62321 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763737AbXHDPsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 11:48:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1195600wah
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 08:48:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j/k64NN7jjqSVsQTuRgdE6il72XWuQTzWewST6gCNtbCQCt+J40MBw8qMnpoVLf1XqF4o7f2MHC/l+l5H1SvTt4qNw/at+rUwA7zEbTFJZ2fcIy32kXRWU36dqmGtW1hwK8S5NgxWzzrQXBzo+b7m3olwMTJtBLIhnhxlLJQi44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EoGbdvjTyfxXLmxt7Rk5RvEWxLh3+NcNVQjjNKMVRVsSSDO5tK8CoYvpWrwpXEMqF6Em3uDM3cPUc2JwgJQsW1dgT46yZQkFiuHd4eSedbS7E+WsaMuuOlXUY5aaml7ZtKQqM3dL9+Bt2zbUye8ddnHIHZ6eZPo2M8Nagq4UQqw=
Received: by 10.114.58.1 with SMTP id g1mr4021622waa.1186242483102;
        Sat, 04 Aug 2007 08:48:03 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 4 Aug 2007 08:48:03 -0700 (PDT)
In-Reply-To: <85odhnfiau.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54869>

On 8/4/07, David Kastrup <dak@gnu.org> wrote:
> This whole "remote tracking" appears to be more a matter of _policy_
> rather than inherent design.

Absolutely.

> It would appear that local and remote
> tracking branches have no fundamental differences

I'd say they have no differences at all, it's just that
'git-checkout.sh' will refuse to update HEAD to point at something
outside of refs/heads.

-- 
larsh
