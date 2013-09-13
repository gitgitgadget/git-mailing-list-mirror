From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] doc: command line interface (cli) dot-repository dwimmery
Date: Fri, 13 Sep 2013 15:31:50 -0700
Message-ID: <xmqqy570gxpl.fsf@gitster.dls.corp.google.com>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1379107397-964-1-git-send-email-philipoakley@iee.org>
	<1379107397-964-4-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Sep 14 00:31:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbu9-0007Pj-Ke
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 00:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab3IMWby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 18:31:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755452Ab3IMWbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 18:31:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C051341974;
	Fri, 13 Sep 2013 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k9+zbvpTZitjfx9vbrqTyz5GB3c=; b=Vxxdfo
	RTTkcwcGAB9cZ8mAR+alHR227bjuHGloRpxZHNI06oA4rhuCGWNczyTOpbTk+r0I
	MkBW/j3SaOmy7wyZ0IPxLE3LPw680E2JgrVlQL6chFnAHRuigFNuiVYE53T447p7
	Kav4pbU8MRdco2Q3fNv9SoAoJ/K1fCsjAkqLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kAmmdH9hx3TDXlp0XHdo0u6e2s2NIZN6
	oK5IX6xAeeQthTppSmO47b2ulqb+OzqTh76eUMsAseDO8M+9iIHk7w+zpZ4+0wJE
	+MM7W8+3qZjX7X2KFtzHiyywIaOsRWbwTp1efASd0iJSFrbPpVo/0eMjDqtnG/Ys
	2ys+5GrRYkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4FFA41973;
	Fri, 13 Sep 2013 22:31:52 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECA294196F;
	Fri, 13 Sep 2013 22:31:51 +0000 (UTC)
In-Reply-To: <1379107397-964-4-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Fri, 13 Sep 2013 22:23:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 49530278-1CC4-11E3-8291-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234783>

Philip Oakley <philipoakley@iee.org> writes:

> The Git cli will accept dot '.' (period) as the relative path
> to the current repository. Explain this action.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/gitcli.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 7d54b77..b065c0e 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -58,6 +58,10 @@ the paths in the index that match the pattern to be checked out to your
>  working tree.  After running `git add hello.c; rm hello.c`, you will _not_
>  see `hello.c` in your working tree with the former, but with the latter
>  you will.
> ++
> +Just as the filesystem '.' (period) refers to the current directory,
> +using a '.' as a repository name in Git (a dot-repository) is a relative
> +path for your current repository.

Looks good to me.  Thanks.
