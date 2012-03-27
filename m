From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: Please pull gitk update
Date: Tue, 27 Mar 2012 16:50:19 +0200
Message-ID: <4F71D3AB.5050903@in.waw.pl>
References: <20120324055540.GA20898@bloggs.ozlabs.ibm.com> <7vsjgvkl69.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 16:50:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCXjJ-0005Jg-QI
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 16:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab2C0Oud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 10:50:33 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56392 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634Ab2C0Ouc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 10:50:32 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SCXj7-0002Ad-KN; Tue, 27 Mar 2012 16:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <7vsjgvkl69.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194046>

On 03/27/2012 01:16 AM, Junio C Hamano wrote:
> Here is what I came up with after looking at the result of this pull.
> Could you eyeball it?
>
> Thanks.
>
> diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
> index 11b0b10..e1f493c 100644
> --- a/Documentation/RelNotes/1.7.10.txt
> +++ b/Documentation/RelNotes/1.7.10.txt
> @@ -46,6 +46,14 @@ Updates since v1.7.9
>   UI, Workflows&  Features
>
>    * various "gitk" updates.
> +   - show the path to the top level directory in the window title
> +   - update preference edit dialog
> +   - pathspecs like "gitk -- .", "gitk -- ..\t" did not work well
> +   - make "git-describe" output in the log message into a clickable link
> +   - avoid matching the UNIX timestamp part when searching all fields
> +   - give preference to symboic font names like sans&  monospace
s/symboic/symbolic/

> +   - allow comparing two commits using a mark
> +   - "gitk" honors log.showroot configuration.

Zbyszek
