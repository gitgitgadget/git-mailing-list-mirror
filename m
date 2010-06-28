From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH] git-rev-parse.txt: Add more examples for caret and colon
Date: Mon, 28 Jun 2010 12:03:43 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483CEF65C@xmail3.se.axis.com>
References: <7vocewff4b.fsf@alter.siamese.dyndns.org>
 <97667b60355ab334a390985cae56a28f7a622eb3.1277712897.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 28 12:04:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTBCa-00050D-5i
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 12:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab0F1KE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 06:04:26 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:45744 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab0F1KE0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 06:04:26 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o5SA3sEN020115;
	Mon, 28 Jun 2010 12:03:54 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Mon, 28 Jun 2010 12:03:53 +0200
Thread-Topic: [PATCH] git-rev-parse.txt: Add more examples for caret and
 colon
Thread-Index: AcsWmrbg44qHqxN5RTew0eE+kQry4wACZq1g
In-Reply-To: <97667b60355ab334a390985cae56a28f7a622eb3.1277712897.git.git@drmicha.warpmail.net>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149826>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Michael J Gruber
> Sent: den 28 juni 2010 10:18
> To: git@vger.kernel.org
> Cc: Junio C Hamano; Matthieu Moy
> Subject: [PATCH] git-rev-parse.txt: Add more examples for caret and
> colon
> 
> Several items in the caret, colon and friends section contain examples
> already. Make sure they all come with examples, and that examples come
> early so that they serve as a visual guide, as well.
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> This is on top of the ":path" patch to git-rev-parse.txt.
> 
> I chose not to rewrap the paragraphs so that the diff is clearer,
> especially with --color-words.
> I don't know what the best patch workflow guideline is here. Maybe
> rewrapping a v2?
> 
>  Documentation/git-rev-parse.txt |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-
> parse.txt
> index d525e57..da5cdf4 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -256,7 +256,7 @@ the `$GIT_DIR/refs` directory or from the
> `$GIT_DIR/packed-refs` file.
>    the branch the ref is set to build on top of.  Missing ref defaults
>    to the current branch.
> 
> -* A suffix '{caret}' to a revision parameter means the first parent of
> +* A suffix '{caret}' to a revision parameter (e.g. "HEAD^") means the first parent of

Shouldn't that be

* A suffix '{caret}' to a revision parameter (e.g. `HEAD{caret}`) means the first parent of

for consistency?

>    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
>    'rev{caret}'
>    is equivalent to 'rev{caret}1').  As a special rule,
> @@ -282,23 +282,24 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
>    and dereference the tag recursively until a non-tag object is
>    found.
> 
> -* A colon, followed by a slash, followed by a text: this names
> +* A colon, followed by a slash, followed by a text (e.g. ":/fix nasty bug"): this names

Most examples in this file seem to use `` rather than "".

>    a commit whose commit message starts with the specified text.
>    This name returns the youngest matching commit which is
>    reachable from any ref.  If the commit message starts with a
>    '!', you have to repeat that;  the special sequence ':/!',
>    followed by something else than '!' is reserved for now.
> 
> -* A suffix ':' followed by a path; this names the blob or tree
> +* A suffix ':' followed by a path (e.g. "HEAD:README"); this names the blob or tree
>    at the given path in the tree-ish object named by the part
> -  before the colon. ":path" (with an empty part before the colon)
> +  before the colon.
> +  ":path" (with an empty part before the colon, e.g. ":README")
>    is a special case of the syntax described next: content
>    recorded in the index at the given path.
> 
>  * A colon, optionally followed by a stage number (0 to 3) and a
> -  colon, followed by a path; this names a blob object in the
> -  index at the given path.  Missing stage number (and the colon
> -  that follows it) names a stage 0 entry. During a merge, stage
> +  colon, followed by a path (e.g. ":0:README"); this names a blob object in the
> +  index at the given path. Missing stage number (and the colon
> +  that follows it, e.g. ":README") names a stage 0 entry. During a merge, stage
>    1 is the common ancestor, stage 2 is the target branch's version
>    (typically the current branch), and stage 3 is the version from
>    the branch being merged.
> --
> 1.7.1.621.g01d76

I tried to find a document describing documentation standards for 
git (i.e., something similar to Documentation/CodingGuidelines),
but could not find any such document. Did I just miss it, or does
it not exist?

//Peter
