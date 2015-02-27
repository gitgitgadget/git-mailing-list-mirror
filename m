From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Fri, 27 Feb 2015 14:20:09 -0800
Message-ID: <CAGZ79ka8zwnT+dn5AHNhvEbMTuaicZiZLZY85baFA=aYSp+OFg@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<CAGZ79kay+EXKaZ0UibCB=t4s5cVb28zgvUXeVRbd9d+XywhAsw@mail.gmail.com>
	<CACsJy8DOS_999ZgW7TqsH-dkrUFpjZf0TFQeFUt9s0bNhHY0Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 23:20:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRTGd-0002Zb-4j
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 23:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbbB0WUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 17:20:12 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:40459 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664AbbB0WUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 17:20:10 -0500
Received: by iebtr6 with SMTP id tr6so34575705ieb.7
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 14:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=sdmCJRQyJxf4H0vqdrTilIoO9Gic2nvQeV/SapfF/3A=;
        b=YEC/Zdz7aL2nFM/tjTl1CxSlWZqmWzshuBPCWoshJ5UuvAhD60J0qpwWtNp1s4rUc2
         GNTlj8NYG9BifRiifZ+vMFtyd8FHhGRYp48ZsF5vUWBCNRDKXVGXe7meCZJE1mVYNYg3
         ELsYJzRlcsrdktkJvn1bmM49TBP474uEYQMJ+xjaa1QFBhflFfNIBzgwzFC/Nj4YLvxh
         kC9XPwiL0AFhNyBkvSPTf0/DkXwJE/9ri9vW0HCM6J3aNzpS/b6P7Ccn1FZ4zfNxtdxj
         xa0vgYTZrAZwPOIqDg6n90n9UOWgxDNcLgaeR9EWtCrEbOmEvKA/IgutqPOTC3M0+Qaf
         xoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=sdmCJRQyJxf4H0vqdrTilIoO9Gic2nvQeV/SapfF/3A=;
        b=YCakh+EErQkeOLBXYZ3YU5h8eNkhm7kERZ3w46WTcoMVmrVrgUqocbvfujGGmLnb4g
         k2qDILPOuZONOG6YqVJDomDBXvwnj9hJqbptjmuLwNWUmfJsN2R9mfjDAjilaSInRizG
         waTPL8PD+axasRJbwYoxyRBu168aoKFf6W2MC9AA+xw03SznIwnynqjub6znXjpp+oKA
         J+/TyZDzfzue5Y/Qb76jcjJ1XWjJorH5SvXhLyg2tEttdjfzSG7CchLwvI1FQtPkM9yl
         0akgfT7a+jyXw1S/WrMg9kUCQSzt/6A8mFuM4yqz6+qOG9qbBpeXWWffIMZP61rSPjUO
         CQBA==
X-Gm-Message-State: ALoCoQlZMoCsC9ZW//ZuKiSfgKqljXCZPTWB4Llr4h8Px2LVtK0CDT7NISZGv96qbb+4u0WhT7i5
X-Received: by 10.50.39.65 with SMTP id n1mr6112034igk.37.1425075609673; Fri,
 27 Feb 2015 14:20:09 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Fri, 27 Feb 2015 14:20:09 -0800 (PST)
In-Reply-To: <CACsJy8DOS_999ZgW7TqsH-dkrUFpjZf0TFQeFUt9s0bNhHY0Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264510>

+git@vger.kernel.org

On Thu, Feb 26, 2015 at 5:42 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> https://github.com/pclouds/git/commits/uploadpack2

I rebased your branch, changed the order of commits slightly and
started to add some.
they are found at https://github.com/stefanbeller/git/commits/uploadpack2

I think the very first patch series which I try to polish now will
just try to move the
capabilities negotiation into the beginning of the exchange.

Any 'real' changes such as adding capabilities to the protocol to not
have all the refs
advertised will come in a later series.

Thanks for your help!
Stefan
