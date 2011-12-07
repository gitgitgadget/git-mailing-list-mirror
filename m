From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: Query on git commit amend
Date: Wed, 07 Dec 2011 07:48:09 +0530
Message-ID: <8739cxw2e6.fsf@gmail.com>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com>
	<20111206191124.GE9492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Viresh Kumar <viresh.kumar@st.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 03:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY75N-0001fx-Kb
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 03:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab1LGCSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 21:18:13 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35884 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab1LGCSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 21:18:12 -0500
Received: by iakc1 with SMTP id c1so123252iak.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 18:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HMYVTM6JdEwLW4nbo3QR3ByhMyO41Vkv7Pa416PYa0w=;
        b=OLxkREbz3jrgiM4WbMDZro51bqIjnrr1jTtApnGOPQELEokGdzTENBOeXdcQ8VamIw
         xigWyPYAD0rE0ioBlcHYt7wxMJgB5/CBnmk+UJUxSjbHAqUp3a0AyOkrW37xSX8gjAhL
         2PxtVxrOACSqbTg6BvNVOOJuTanClvpF/fHW0=
Received: by 10.50.169.99 with SMTP id ad3mr17715055igc.6.1323224292170;
        Tue, 06 Dec 2011 18:18:12 -0800 (PST)
Received: from BALROG ([59.92.45.19])
        by mx.google.com with ESMTPS id p16sm755743ibk.6.2011.12.06.18.18.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 18:18:11 -0800 (PST)
In-Reply-To: <20111206191124.GE9492@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 6 Dec 2011 14:11:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186414>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 06, 2011 at 09:16:18PM +0530, Vijay Lakshminarayanan wrote:
>
>> I've found 
>> 
>> $ GIT_EDITOR=cat git commit --amend
>> 
>> useful.
>> 
>> The benefit of this technique is that it even works for git-rebase -i.
>
> I sometimes do a similar thing, but I don't use "cat". That will dump
> all of the log message (including the generated template) to stdout
> (i.e., the terminal), which is quite noisy. Instead, I use:
>
>   GIT_EDITOR=true git commit --amend
>
> which silently leaves the file untouched.

Thanks Peff.  I didn't know about true.  I will use it when rebasing.
cat's noisiness is useful as a review of the output.

> -Peff

-- 
Cheers
~vijay

Gnus should be more complicated.
