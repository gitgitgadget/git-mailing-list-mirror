From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: bug/feature request: apply textconv in "git add -p" diff output
Date: Sat, 20 Jun 2009 09:58:02 +0200
Message-ID: <adf1fd3d0906200058o3e48018fg32c0efba5e4d62a4@mail.gmail.com>
References: <fcaeb9bf0906200017x6cc63c29q5515c11c202e424e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 09:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHvUP-0007bk-16
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 09:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbZFTH6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 03:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbZFTH6C
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 03:58:02 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:39368 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZFTH6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 03:58:01 -0400
Received: by bwz9 with SMTP id 9so2152935bwz.37
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 00:58:02 -0700 (PDT)
Received: by 10.204.122.141 with SMTP id l13mr3466893bkr.106.1245484682523; 
	Sat, 20 Jun 2009 00:58:02 -0700 (PDT)
In-Reply-To: <fcaeb9bf0906200017x6cc63c29q5515c11c202e424e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121937>

2009/6/20 Nguyen Thai Ngoc Duy <pclouds@gmail.com>
>
> Hi,
>
> I use git to manage bdf font files. It it quite cryptic so textconv
> for diff output makes it much easier to keep track of changes. The
> only problem is that "git add -p" does not seems to use textconv, so I
> have to run in parallel "git diff" and "git add -p", then add chunks
> accordingly. Can somebody add textconv support to "git add -p" please?
> I'm not so good at Perl to do the job.

While at it it would be great if one could toggle between normal diff
and --color-words in "git add -p". I tried to do it but the logic in
"git add -p" is base on lines (and not chuncks) and git diff
--color-lines changes them and my perl-fu is not so good either.

Thanks in advance,
Santi
