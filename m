From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] glossary: remove outdated/misleading/irrelevant
 entries
Date: Mon, 15 Apr 2013 11:14:48 -0700
Message-ID: <7v1uabu0dj.fsf@alter.siamese.dyndns.org>
References: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
 <1456791522.996464.1366048016249.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnvb-0004MN-Pb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704Ab3DOSOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:14:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756694Ab3DOSOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:14:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E563A16F45;
	Mon, 15 Apr 2013 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=8VptPdMe2TWryviDijWhtDV0SpY=; b=HoZu4kv61fwWJ3hRjspI
	1ivkBYjG2QdTuLwZVu3h7CyaiBU8oesyZVY9CACPVxQrcr58yWlpIqLdQCtuMQTp
	5nifqwdp5Q6jGVoIzDiKv9M7L3Zfj5GxtmHoYltUqswLtV4JMinev7yAD1fWC178
	zAbvId6k06sJVZtpDFn5h2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oA8qfSw/cVJByuL9YYpyNbTORBInLObpQXg8mdHzR+jtOf
	DoE5TwJ32P2qhm5jzUwxv16QJSPr03XebDLgcnlGDZZIt4pSf/kGgmKsrYmYaWbT
	HzthklIj+G+P78rja03UIG1E4xVMNgcPz0lUeNVcN/6E3uoLiylvTVCCyQboU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C3B16F44;
	Mon, 15 Apr 2013 18:14:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 372A116F42; Mon, 15 Apr
 2013 18:14:50 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CD31BDC-A5F8-11E2-9449-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221280>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

Looks sensible.  Thanks.

>  Documentation/glossary-content.txt | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index eb7ba84..5a7a486 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -104,9 +104,6 @@ to point at the new commit.
>  	an arbitrary <<def_commit,commit>> that isn't necessarily the tip of any
>  	particular branch.  In this case HEAD is said to be "detached".
>  
> -[[def_dircache]]dircache::
> -	You are *waaaaay* behind. See <<def_index,index>>.
> -
>  [[def_directory]]directory::
>  	The list you get with "ls" :-)
>  
> @@ -115,11 +112,6 @@ to point at the new commit.
>  	it contains modifications which have not been <<def_commit,committed>> to the current
>  	<<def_branch,branch>>.
>  
> -[[def_ent]]ent::
> -	Favorite synonym to "<<def_tree-ish,tree-ish>>" by some total geeks. See
> -	http://en.wikipedia.org/wiki/Ent_(Middle-earth) for an in-depth
> -	explanation. Avoid this term, not to confuse people.
> -
>  [[def_evil_merge]]evil merge::
>  	An evil merge is a <<def_merge,merge>> that introduces changes that
>  	do not appear in any <<def_parent,parent>>.
> @@ -257,8 +249,7 @@ This commit is referred to as a "merge commit", or sometimes just a
>  	<<def_object,object>>.
>  
>  [[def_octopus]]octopus::
> -	To <<def_merge,merge>> more than two <<def_branch,branches>>. Also denotes an
> -	intelligent predator.
> +	To <<def_merge,merge>> more than two <<def_branch,branches>>.
>  
>  [[def_origin]]origin::
>  	The default upstream <<def_repository,repository>>. Most projects have
