From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH v2] CodingGuidelines: add Python coding guidelines
Date: Wed, 30 Jan 2013 11:05:10 +0100
Message-ID: <5108F056.9040406@alum.mit.edu>
References: <20130129190844.GB1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 30 11:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Uek-0000X6-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 11:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab3A3KMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 05:12:17 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:48273 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753970Ab3A3KMP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jan 2013 05:12:15 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2013 05:12:14 EST
X-AuditID: 12074412-b7f216d0000008e3-98-5108f059a9db
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 16.64.02275.950F8015; Wed, 30 Jan 2013 05:05:13 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0UA5AML000950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Jan 2013 05:05:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130129190844.GB1342@serenity.lan>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqBv5gSPQoGc5q0XXlW4mixvnd7E6
	MHmcffSA2ePzJrkApihum6TEkrLgzPQ8fbsE7oy2F/dYC97IVnRsPM3UwLhNvIuRk0NCwETi
	0MY3LBC2mMSFe+vZuhi5OIQELjNKnDv2Fso5ziRx+M9uZpAqXgFtid1XbrGC2CwCqhLzvvxg
	A7HZBHQlFvU0M4HYogJhEr2vzzFC1AtKnJz5BGyDCFD9tE832LsYOTiYBcQl+v+BhYUFvCSu
	rJwLNkZIwECi4+9NMJtTwFBi+41DYKuYBXQk3vU9YIaw5SW2v53DPIFRYBaSDbOQlM1CUraA
	kXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkigCu1gXH9S7hCjAAejEg/v
	0hfsgUKsiWXFlbmHGCU5mJREebe+4QgU4kvKT6nMSCzOiC8qzUktPsQowcGsJMKroAaU401J
	rKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4F3zDqhRsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDtlX0Psre4IDEXKArReorRmGP/k/bnjBzb
	fwNJIZa8/LxUKXHeTyCbBEBKM0rz4BbBUtQrRnGgv4V5tUEG8gDTG9y8V0CrmIBWGbWxg6wq
	SURISTUw7hJicprd2S0/W9GnyM24/BNDvMfO5oReqS19TzSkJv87/8YjMCly3f7zV8t/9526
	0BDKb9fhuE6hxm+Rf1n+A894753nq6QUjjG3M+UtmRc+T32x5CreuqpLXpeP2iaF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215007>

On 01/29/2013 08:08 PM, John Keeping wrote:
> These are kept short by simply deferring to PEP-8.  Most of the Python
> code in Git is already very close to this style (some things in contrib/
> are not).
> 
> Rationale for version suggestions:
> 
>  - Amongst the noise in [1], there isn't any disagreement about using
>    2.6 as a base (see also [2]), although Brandon Casey recently added
>    support for 2.4 and 2.5 to git-p4 [3].
> 
>  - Restricting ourselves to 2.6+ makes aiming for Python 3 compatibility
>    significantly easier [4].
> 
>  - Advocating Python 3 support in all scripts is currently unrealistic
>    because:
> 
>      - 'p4 -G' provides output in a format that is very hard to use with
>        Python 3 (and its documentation claims Python 3 is unsupported).
> 
>      - Mercurial does not support Python 3.
> 
>      - Bazaar does not support Python 3.
> 
>  - But we should try to make new scripts compatible with Python 3
>    because all new Python development is happening on version 3 and the
>    Python community will eventually stop supporting Python 2 [5].
> 
>  - Python 3.1 is required to support the 'surrogateescape' error handler
>    for encoding/decodng filenames to/from Unicode strings and Python 3.0
>    is not longer supported.
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/210329
> [2] http://article.gmane.org/gmane.comp.version-control.git/210429
> [3] http://thread.gmane.org/gmane.comp.version-control.git/214579
> [4] http://docs.python.org/3.3/howto/pyporting.html#try-to-support-python-2-6-and-newer-only
> [5] http://www.python.org/dev/peps/pep-0404/
> 
> ---
> Changes since v1:
> 
> - Set 3.1 as the minimum Python 3 version
> 
> - Remove the section on Unicode literals - it just adds confusion and
>   doesn't apply to the current code; we can deal with any issues if they
>   ever arise.
> 
>  Documentation/CodingGuidelines | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 69f7e9b..db7a416 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -179,6 +179,19 @@ For C programs:
>   - Use Git's gettext wrappers to make the user interface
>     translatable. See "Marking strings for translation" in po/README.
>  
> +For Python scripts:
> +
> + - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
> +
> + - As a minimum, we aim to be compatible with Python 2.6 and 2.7.
> +
> + - Where required libraries do not restrict us to Python 2, we try to
> +   also be compatible with Python 3.1 and later.
> +
> + - We use the 'b' prefix for bytes literals.  Note that even though
> +   the Python documentation for version 2.6 does not mention this
> +   prefix it is supported since version 2.6.0.
> +
>  Writing Documentation:
>  
>   Every user-visible change should be reflected in the documentation.
> 

Nit: s/it is supported/it has been supported/

I think this would be a good Python policy.

I would hate to junk up all Python code with things like

    ' '.encode('ascii')

though, so maybe we should establish a small Python library of
compatibility utilities (like a small "six").  It could contain b().

Another handy utility function could be

    def check_python_version(minimum_v2=0x02060000,
                             minimum_v3=0x03010000)

which checks our default Python requirements by default, but is
overrideable by specific scripts if they know that they can deal with
older Python versions.

But I haven't had time to think of where to put such a library, how to
install it, etc.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
