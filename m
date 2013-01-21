From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-for-each-ref.txt: 'raw' is a supported date format
Date: Mon, 21 Jan 2013 17:02:52 +0100
Message-ID: <50FD66AC.1080201@alum.mit.edu>
References: <d3a288a67867d7a60c9217a78bda42301392c3da.1358776352.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:03:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxJq9-0006px-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 17:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab3AUQC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 11:02:56 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:60250 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752902Ab3AUQCz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 11:02:55 -0500
X-AuditID: 1207440f-b7f276d0000008b2-57-50fd66afee05
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E9.BB.02226.FA66DF05; Mon, 21 Jan 2013 11:02:55 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0LG2qb1016254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 Jan 2013 11:02:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <d3a288a67867d7a60c9217a78bda42301392c3da.1358776352.git.john@keeping.me.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqLs+7W+AweNedouuK91MFg29V5gt
	bpzfxerA7HH20QNmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6Y07maseAUR8WPO7fZGxgn
	sHcxcnJICJhIXJm2jRHCFpO4cG89WxcjF4eQwGVGiV1PdzNDOMeZJO5e384KUsUroC2x9kwf
	mM0ioCrxf9UMMJtNQFdiUU8zE4gtKhAm0fv6HCNEvaDEyZlPWEBsEaD6aZ9ugG1mFrCWWPH6
	MFi9sIC3xK9PE8HqhQQiJDbNf84GYnMKREr0HjnCBlGvI/Gu7wEzhC0vsf3tHOYJjAKzkKyY
	haRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCgpd/B2PXeplD
	jAIcjEo8vJw9fwKEWBPLiitzDzFKcjApifKuS/kbIMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	d0YUUI43JbGyKrUoHyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYrw8GhJMG7KBWoUbAoNT21
	Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Uq/HFwGgFSfEA7T0BchNvcUFiLlAUovUUoy7H
	9t/tzxmFWPLy81KlxHm7QXYIgBRllObBrYClqleM4kAfC/NygVTxANMc3KRXQEuYgJbwLv4N
	sqQkESEl1cBYeImzbdoJq7vHmzJ5TKTOBEsGqMwU8L+z2SL8y8TbnBuEe24Vi82edyiNxT5U
	jbn2Tr6Dzz/huqq8HyyTgoKYSsqu5UmxXpR43H543uzDxgVfLO/Gfzq5MNQnT26q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214124>

On 01/21/2013 02:53 PM, John Keeping wrote:
> Commit 7dff9b3 (Support 'raw' date format) added a raw date format.
> Update the git-for-each-ref documentation to include this.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  Documentation/git-for-each-ref.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index db55a4e..d3e1df7 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -117,7 +117,7 @@ returns an empty string instead.
>  
>  As a special case for the date-type fields, you may specify a format for
>  the date by adding one of `:default`, `:relative`, `:short`, `:local`,
> -`:iso8601` or `:rfc2822` to the end of the fieldname; e.g.
> +`:iso8601`, `:rfc2822` or `raw` to the end of the fieldname; e.g.
>  `%(taggerdate:relative)`.

Shouldn't "raw" be preceded with a colon like the other format specifiers?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
