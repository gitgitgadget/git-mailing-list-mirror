X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] document the <tree ish> <file> blob reference syntax
Date: Wed, 25 Oct 2006 20:40:26 +0100
Message-ID: <453FBDAA.50305@shadowen.org>
References: <38fafea491402334df335c486270ebe9@pinky> <7vwt6ob5zc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 19:41:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <7vwt6ob5zc.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30096>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcocg-00008L-Lr for gcvg-git@gmane.org; Wed, 25 Oct
 2006 21:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932243AbWJYTlF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 15:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWJYTlF
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 15:41:05 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:49419 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S932243AbWJYTlE
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 15:41:04 -0400
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gcobz-0000OV-3q; Wed, 25 Oct 2006 20:40:27 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> It is possible to specify a specific file within a tree-ish
>> symbolically.  For example you can find the contents of
>> a specific file in a specific commit as below:
>>
>> 	git cat-file -p v1.2.4:git-prune.sh
> 
> Didn't we document this elsewhere recently in git-rev-parse?
> How about this instead?
> 
> -- >8 --
> [PATCH] Refer to git-rev-parse:Specifying Revisions from git.txt
> 
> The brief list given in "Symbolic Identifiers" section of the
> main documentation is good enough for overview, but help the
> reader to find a more comrehensive list as needed.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>  Documentation/git.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 3af6fc6..b00607e 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -562,6 +562,9 @@ HEAD::
>  	a valid head 'name'
>  	(i.e. the contents of `$GIT_DIR/refs/heads/<head>`).
>  
> +For a more complete list of ways to spell object names, see
> +"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
> +

That section seems to have more compresensive descriptions of the
various definitions of commit-ish, but not a tree-ish.  Specifically,
there is no mentions of tree-ish:file

