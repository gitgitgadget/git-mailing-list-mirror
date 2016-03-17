From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Subject: [PATCH for submodule ideas wiki] `git commit` to warn
 about broken submodule states configuration
Date: Thu, 17 Mar 2016 20:57:01 +0100
Message-ID: <56EB0C0D.3080609@web.de>
References: <1458162423-13768-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:57:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1age2h-0006oP-QT
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 20:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935276AbcCQT5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 15:57:07 -0400
Received: from mout.web.de ([212.227.17.12]:56683 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933516AbcCQT5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 15:57:05 -0400
Received: from [192.168.178.41] ([79.211.107.106]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MIvPJ-1aeA8C42bh-002V80; Thu, 17 Mar 2016 20:57:02
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <1458162423-13768-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:GJfJdUob+aHOLUBjM7zW/hYxZaiwlyb9BhLrwk4HNnoqtg2fVpr
 lVw0JCEolR91i7/tqbWJ16oTo3fx97eBYyjyRZnbsq+HZX3rfQJSbJzsHa0pLPRgDQCvR8p
 plQBvq7GXfwdZ6SWdF/CuTbncO56dYGg6oYpHROr77TkvMD+wf1fbEJuCxISGKk5jPvxUDj
 BcEz/SEiIpqs5Dh7Ay1Gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N01zBLE8hj0=:OYNDxf7FQlZL2dbzu8tK22
 IeNQLHw7g5jZoK/RKuLvCsQ0JQlO1rT/VyQwA9b9C/f8IF2/ER9lDXyqYxjfC9gPNBDtFWu3G
 SmbPe+aPS1QDcbvXwt4wLjXslZ13ko2B/HbKCzu5XMb1EZDfIIM/EJUKrrIbis6YA8/gDO0fu
 fcMQWersTXUDb8ezYG6PFKP+UDTjymVv6tOJqTZCfE+M2v1mHE+dNdjD58JGa/lE1lN/xfPcw
 KUL8xa3Zofkfl4J8Ga0k7CgkK5hvV66XrNx7H3AXg3POpad4+aJmB1tl3UhVAxtmzpU0qurdO
 ME5tQTEea7kWDEXcNc8NiWPvO59KlOSpQPF14fmK8k5DlvTNoJwP+I90WyZygHqFEzC6sh+gd
 RYsd9UW8QTfGVP/Ze1Erj3GLn1snjp/ENVQfsk/oAa7gK9PUhMgnMPiaQZSIQfchSqri2C1Ai
 5ulvijKhg9ffrikXP0HY5OodG5JWJLwXR55su7ZbjnIsDS2IwVecSaO+nx4/BvQ90gRQ8fUpV
 DCAigA2g9nmVfkWs82QjkzXMzjOHTT239STOnINevEUl6gQ02h6gktqw0+WYWmjw1fathZdzj
 1kzhsNXjm1YFICrJjLjtODKHKJQJ9p/4R0iSycvC4f42ympi2Siw1RWglaV6F2vEtVbT6cDMm
 PqUV0zg1cZZcsSoXlBTf6aG7LebkzMsZ5qD4LBrt8M+gwF2AT/vTDRQA9WfRTZuqp8w71cear
 EMfI7O3C/+manhII/IgQrRf7AVtBqrcorC16rIQy7xA6V4gliOi5f8HYfgUH6PerKdCO+i+v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289153>

Am 16.03.2016 um 22:07 schrieb Stefan Beller:
> ---
>
>    Hi Jens,
>
>    I cannot find the edit button in the wiki[1] any more.

Oops. After you mentioned recently that every GitHub user had write
permissions to the Wiki I restricted it to be writable for known
collaborators and also added you to this list. But it looks like I
added the other Stefan Beller registered on GitHub instead. That
should be fixed know, please let me know when the edit button still
does not show up for you.

>    Please apply this patch documenting another idea.

Sure, thanks for the patch! Applied and pushed.

>    Thanks,
>    Stefan
>
>    [1] https://github.com/jlehmann/git-submod-enhancements/wiki
>
>   Home.textile | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/Home.textile b/Home.textile
> index 152ad04..3b00496 100644
> --- a/Home.textile
> +++ b/Home.textile
> @@ -47,6 +47,17 @@ h2. Submodule related bugs to fix
>   * E.g. @git log <submodule>/@ and @git diff <rev> <submodule>/@ do not produce any output while dropping the '/' at the end makes them work as expected.
>   * @git add@ does not honour the submodule.&lt;name&gt;.ignore settings
>   * @git submodule add@ messes up paths from nested submodules, see ("thread on mailing list":http://thread.gmane.org/gmane.comp.version-control.git/288130)
> +* @git commit@ can be cautious about submodule related commits. That is if a commit contains a change to the .gitmodules file, make sure that the corresponding gitlink is present (either already in the tree or newly added). IIUC Jonathan correctly a submodule which is configured in .gitmodules, but not present as a gitlink is considered broken, which we may want to avoid in the first place. When implementing this, we need to take care of historical mistakes being handled correctly as well as a flag to commit, which overwrites the potential warning. The gitmodules file unlike other in-tree configuration files (.gitignore, .gitattributes, .mailmap) have a 1:1 mapping so the existence of the gitlink is strongly expected. (Counter example with .gitignore: Ignoring *.exe doesn't expect any .
 exe file to be there). I imagine this to roughly work as:
> +
> +bc.     $ git add .gitmodules
> +    $ git commit -m "add submodule to .gitmodules, but not as gitlink"
> +      Warning: Not committing as this would break submodule consistency. Use
> +      --force-submodules to commit the broken submodule state.
> +    $ echo $?
> +      1 # fail
> +    $ git commit --force-submodules -m "add submodule to .gitmodules, but not as gitlink"
> +    $ echo $?
> +      0 # Success
>
>   *[[Ideas]]*
>
>
