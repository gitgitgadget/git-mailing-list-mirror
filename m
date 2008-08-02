From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Sat, 2 Aug 2008 07:41:37 +0200
Message-ID: <cb7bb73a0808012241s80a06fq1ac54a3350169f6c@mail.gmail.com>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
	 <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
	 <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 07:42:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP9t4-0007aM-Uc
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 07:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYHBFlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 01:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbYHBFlj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 01:41:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:41017 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbYHBFli (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 01:41:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so801574ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 22:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=78bZhHZ3rhlYlH5adOfdySkMTmGei50rQF0WRPCTVa8=;
        b=E0bOSox0jiO5LquY/VFknRVYNzeZtTskW/1nieP/80gBU7zVN/wZPF/DYFBqEKfblH
         8cDnqXborqpcclcUfYTjJiI87+GuMJeloabSTxLxP1qUW9A/fuWBHgBlMRhahbUWUhA3
         7vX0i+JrGen8UGzRbqMNgj9OLPSTn+TBpbeyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wiuXgBu+YKlRh+hhf/mJ/CXizYI0UYTqNqTyPkIZQSu/SK7Jvq5mQlaYXMqaMIS4pM
         Q/MtjZhcsN5fAZaTBQNnq9Mw48LWukOHfkMjXCNhjgphAkVyVc/E5S/oKcTvICuIsvoj
         uetmErDP4bV834wKcTSWaHTJqzzd8b/BImPv4=
Received: by 10.150.84.17 with SMTP id h17mr4486352ybb.206.1217655697858;
        Fri, 01 Aug 2008 22:41:37 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 1 Aug 2008 22:41:37 -0700 (PDT)
In-Reply-To: <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91132>

On Sat, Aug 2, 2008 at 2:31 AM, Kevin Ballard <kevin@sb.org> wrote:
>
> As a Ruby user, the regex for the funcname looks fine to me.

What is your opinion about the anonymous code blocks?

I've been thinking that another possibility could be to have two ruby
funcnames, a simpler one (the one I presented) that only has 'named'
blocks, and a more thorough one that also matches up anonymous blocks.
User could then choose which one to use in their code by having
gitattributes such as *.rb diff=ruby or *.rb diff=ruby-full (or
whatever else).

I'm not sure this would be a sensible policy though.

-- 
Giuseppe "Oblomov" Bilotta
