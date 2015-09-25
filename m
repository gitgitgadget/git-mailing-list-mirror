From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Formatting error in page http://git-scm.com/docs/user-manual
Date: Fri, 25 Sep 2015 16:29:18 +0200
Message-ID: <56055A3E.4020800@drmicha.warpmail.net>
References: <CAOq7JjbYP=fGB0aqbrMz_ibfWHor-v-Y-BsO316H4dHpfSYS-w@mail.gmail.com>
 <20150925125935.GN17201@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>,
	Valentin VALCIU <axiac.ro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 16:29:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfU06-00023v-PE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 16:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626AbbIYO3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 10:29:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43854 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756295AbbIYO3V (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2015 10:29:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id A046120861
	for <git@vger.kernel.org>; Fri, 25 Sep 2015 10:29:20 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 25 Sep 2015 10:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=0C7zkZRnDprEUlKbmGahasxuVV0=; b=l893c+
	ZRHkLQMnhBpTce8X+tilYJK3G1EyHLQrUFE0q8Jmb3iN0W7676eW6m3HqlRv8GW0
	1XLBawpntv2P2hVaDmVhVc7o0YbrDpJVJxb9AzsiJHMD6rYYlHStPVII+xO1HhRI
	KloF9fskit+lw2ov6qCphR12qaE79OoP+hz6c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=0C7zkZRnDprEUlK
	bmGahasxuVV0=; b=kKpC3SYY4HGIM46H66rTgDQZCfumBKQKHg9yXKyOskgvpmW
	m9FbrIf1y1ECTAaIYdDw2+BHbYy99vf8dD2yHMDZT88UH8iW+H03yY6y5kCkA6qd
	dty65GWXrPnDCtmyLp7rgAHD1a0VKF+IQKp3W6hxREmIfzolzjVVmXIVoCMI=
X-Sasl-enc: HEEgK0o2XJfi/RsPvFoA8JmoRpm3nUy4j5TY8OyJmmEF 1443191360
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DD201680124;
	Fri, 25 Sep 2015 10:29:19 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150925125935.GN17201@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278660>

John Keeping venit, vidit, dixit 25.09.2015 14:59:
> On Fri, Sep 25, 2015 at 03:38:02PM +0300, Valentin VALCIU wrote:
>> There is a formatting error in the source code of page
>> http://git-scm.com/docs/user-manual that makes almost half of it be
>> rendered in a <pre> element displaying the page source in the original
>> markup language instead of being converted to HTML.
>>
>> The issue is in the paragraph that stars with "The index is a binary
>> file (generally kept in `.git/index`)..."
> 
> It looks like the header underline isn't quite accurate enough to keep
> Asciidoctor happy.  The patch below should fix it.
> 
> -- >8 --
> Subject: [PATCH] Documentation/user-manual: fix header underline
> 
> Asciidoctor is stricter than AsciiDoc when deciding if underlining is a
> section title or the start of preformatted text.  Make the length of the
> underlining match the text to ensure that it renders correctly in all
> implementations.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  Documentation/user-manual.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 68978f5..1b7987e 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3424,7 +3424,7 @@ just missing one particular blob version.
>  
>  [[the-index]]
>  The index
> ------------
> +---------
>  
>  The index is a binary file (generally kept in `.git/index`) containing a
>  sorted list of path names, each with permissions and the SHA-1 of a blob
> 

The only other instance seems to be:

Documentation/git-bisect-lk2009.txt-Acknowledgments
Documentation/git-bisect-lk2009.txt:----------------

Dunno if we want to fix that, too.

Michael
