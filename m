X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: gitk feature request..
Date: Sat, 11 Nov 2006 16:08:22 +0100
Message-ID: <e5bfff550611110708r1ad9559ewf35b8abaceb21cc4@mail.gmail.com>
References: <452A37FB.60507@adelaide.edu.au>
	 <17745.1213.22769.420355@cargo.ozlabs.ibm.com>
	 <7vslgu28do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 11 Nov 2006 15:09:17 +0000 (UTC)
Cc: "Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org,
	"Pierre Marc Dumuid" <pierre.dumuid@adelaide.edu.au>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a9ukexxJgJawKhOLiuZCKPXnO32XVIFPXPKxE0Cgrs5j61WDgnf+RSqaFKEqW04alrH+GSNDFMmizi6XuzaWVc55rFqq0z3dLmczcUSk1Cblxdet+DtE4X4O2pp41sVXKCtMZLi6lYgxcl7NrWFI0IrA0xyQJPBoPX8v6kQ6Uhw=
In-Reply-To: <7vslgu28do.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31229>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiuTf-00055m-0v for gcvg-git@gmane.org; Sat, 11 Nov
 2006 16:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965964AbWKKPI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 10:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965942AbWKKPI6
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 10:08:58 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:6241 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S965964AbWKKPI5
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 10:08:57 -0500
Received: by py-out-1112.google.com with SMTP id a29so438811pyi for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 07:08:23 -0800 (PST)
Received: by 10.35.49.1 with SMTP id b1mr6053312pyk.1163257702903; Sat, 11
 Nov 2006 07:08:22 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sat, 11 Nov 2006 07:08:22 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/7/06, Junio C Hamano <junkio@cox.net> wrote:

>
> Having said that, is the gitk view supposed to be shared across
> users of a single repository?
>

Perhaps I misunderstand, but aren't gitk views a command line
arguments set for git-rev-list?

Couldn't  be defined as aliases and stored in .git/config? so to be
used also with other git commands, as example git log...and of course
other GUI tools ;-).

If I understand correctly the git documentation, aliases store both
the git command and the argument list. Perhaps for views the command
could be git-rev-parse.

Regarding the local / private views problem, perhaps we could use a
local, i.e. out of .git directory, config file that _extends_ and
_overrides_ the repository config file.

What I mean is that an alias, or also, in general, a config variable
could be searched by git, first in the local file, then if not found
in the .git/config file.

Of course the problem of per-repository _and_ private views stay open
(we could use sub-sections identified by repo path in private .config
file???) but I think this is a more general and porcelain agnostic
approach and could be better reused and extended.

