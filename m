From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFH] How to get git-gui.sh history
Date: Sat, 21 Apr 2007 11:38:29 +0200
Message-ID: <e5bfff550704210238gfdb5a51i2a7f4a8d16396b28@mail.gmail.com>
References: <e5bfff550704210204p1f231076p6a68cb9d6038f4e3@mail.gmail.com>
	 <7vtzvaulwe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 11:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfC3J-0008OR-F0
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 11:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbXDUJic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 05:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbXDUJic
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 05:38:32 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:28750 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbXDUJib (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 05:38:31 -0400
Received: by an-out-0708.google.com with SMTP id b33so1231917ana
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 02:38:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eHSOmh5ekgxUwkGaTY9E6i73MRY6MSx3qeuZnxOv1jSfw+FirzqWRmMWBqj2M4WkiE9lUhHi4BFaGrLV2n2MKp2wvYejMVjIdeZVp87zzFdDuMHUfOJVnvnIWIqknQen2YKooxSBL2yz5QCemZ0fCbeVBVvxdxpraXYwTJLhMxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVI1oJ7THAHhYnDisGrAtd3XSh2zgTpHPxs8CigIS00iS3//FY9BOmFeQv4fiR/mWtaGT1w00AJ52xjQX6dX0CKNt1QYLQwR7/sqq8o/9EzZp2IRDfuqrfw71tiI9844mSMefNptOzNt3MS4G3ZJPxGKBjQsw99DYQYExZSvbOQ=
Received: by 10.114.160.1 with SMTP id i1mr1628746wae.1177148309664;
        Sat, 21 Apr 2007 02:38:29 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 02:38:29 -0700 (PDT)
In-Reply-To: <7vtzvaulwe.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45159>

On 4/21/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> $ git rev-list -- git-gui.sh | wc -l
> 158
>

This is strange....

On my box I have:

$ git --version
git version 1.5.1.1.190.g74474
$ git rev-parse HEAD
744747ef1d75c85fb3a1785cb08d36497128d3d3
$ git status
# On branch master
nothing to commit (working directory clean)
$ git rev-list -- git-gui.sh | wc -l
usage: git-rev-list [OPTION] <commit-id>... [ -- paths... ]
  limiting output:
    --max-count=nr
    --max-age=epoch
    --min-age=epoch
    --sparse
    --no-merges
    --remove-empty
    --all
    --stdin
  ordering output:
    --topo-order
    --date-order
  formatting output:
    --parents
    --objects | --objects-edge
    --unpacked
    --header | --pretty
    --abbrev=nr | --no-abbrev
    --abbrev-commit
    --left-right
  special purpose:
    --bisect
    --bisect-vars
0
$
