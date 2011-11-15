From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-show-ref: fix escaping in asciidoc source
Date: Tue, 15 Nov 2011 15:11:52 +0100
Message-ID: <4EC27328.3070309@alum.mit.edu>
References: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 15:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQJk3-0006Bi-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 15:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab1KOOL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 09:11:58 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34938 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab1KOOL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 09:11:58 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAFEBqx1014651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Nov 2011 15:11:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185460>

Junio,

Did this one fall through the cracks?  I don't see it in your tree.

Michael

On 10/19/2011 08:52 PM, mhagger@alum.mit.edu wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> One of the "^" characters was not coming through in the man page.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/git-show-ref.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
> index 3c45895..87f358d 100644
> --- a/Documentation/git-show-ref.txt
> +++ b/Documentation/git-show-ref.txt
> @@ -44,7 +44,7 @@ OPTIONS
>  -d::
>  --dereference::
>  
> -	Dereference tags into object IDs as well. They will be shown with "^{}"
> +	Dereference tags into object IDs as well. They will be shown with "{caret}\{\}"
>  	appended.
>  
>  -s::
> @@ -75,7 +75,7 @@ OPTIONS
>  	Make 'git show-ref' act as a filter that reads refs from stdin of the
>  	form "^(?:<anything>\s)?<refname>(?:{backslash}{caret}\{\})?$"
>  	and performs the following actions on each:
> -	(1) strip "^{}" at the end of line if any;
> +	(1) strip "{caret}\{\}" at the end of line if any;
>  	(2) ignore if pattern is provided and does not head-match refname;
>  	(3) warn if refname is not a well-formed refname and skip;
>  	(4) ignore if refname is a ref that exists in the local repository;

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
