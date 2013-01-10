From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] contrib/vim: simplify instructions for old vim support
Date: Thu, 10 Jan 2013 15:08:55 -0800
Message-ID: <20130110230855.GC30784@google.com>
References: <50EEA34B.7070102@gmail.com>
 <20130110113958.GA17137@sigill.intra.peff.net>
 <20130110205427.GG16532@google.com>
 <20130110213427.GA26138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Manlio Perillo <manlio.perillo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 00:09:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtRFS-0004C0-O3
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 00:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab3AJXJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 18:09:01 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:50756 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab3AJXJA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 18:09:00 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so578748pbb.29
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DVpltElK7oIMQH5NBR+ppWbLFu5B53mlB/1L0ILu3sw=;
        b=Bzti0UxCNPQ54hGPlp74cYanskMq3YbHa7OrwC5HW4nT+qwtwnHjZmx7E2Osr0l14u
         uSv4aOzV4UKsnNv4SKlCHqG0jSaF3ff6DgwulQ93XMcXrygupny1YclF3rOUtK9ynmLy
         m8P6RII7zRLzgTXxnRtc/6MZDI7Ecvonr57UnefKVlqmd1Gp5N1ES7o2+uRPO6BoW/LA
         F3rFa46HuCZiFOT1/9B4d6W7ljxndNYF1vwgXsY8h29uPtjppbZWGAsSh2UbA2iG6/N7
         lOjC3sF3DDZZtRtRDaWeLGf5/M71ht8RsoG0qe/6poXMfBXSYzNoNHXHB3b9R/Hcu1F5
         R20A==
X-Received: by 10.66.80.202 with SMTP id t10mr201712204pax.81.1357859340112;
        Thu, 10 Jan 2013 15:09:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id sk1sm1547793pbc.0.2013.01.10.15.08.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 15:08:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130110213427.GA26138@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213159>

Jeff King wrote:
> On Thu, Jan 10, 2013 at 12:54:27PM -0800, Jonathan Nieder wrote:

>> Rely on the upstream filetype.vim instead of duplicating its rules in
>> git's instructions for syntax highlighting support on pre-7.2 vim
>> versions.
[...]
> Yeah, I think this makes sense. I'd be fine with removing it entirely,
> but it doesn't hurt to err on the conservative side and leave it there.
> It's not like it's generating a huge maintenance burden, and with your
> patch, there is even less to maintain.
>
> Acked-by: Jeff King <peff@peff.net>

Thanks for looking it over.
