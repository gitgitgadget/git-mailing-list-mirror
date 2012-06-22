From: ryenus <ryenus@gmail.com>
Subject: [RFE] option for find branches in a remote repo which contain a
 certain commit
Date: Fri, 22 Jun 2012 22:58:12 +0800
Message-ID: <CAKkAvazRfb0kTphLKoRQxSEBZwHfVZeaM0xEbcxEw7Mt5RMg8A@mail.gmail.com>
References: <CAKkAvazNqZWk=QRmSFsFL33M6z+nZZ_yyxxbxwAh=fQk5DVt-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 16:58:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si5Ju-0008N3-4F
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 16:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751Ab2FVO6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 10:58:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34296 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402Ab2FVO6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 10:58:33 -0400
Received: by pbbrp8 with SMTP id rp8so3658899pbb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=WpDrlKJp7legHBcGn+2ZpFp7VoVjQoamoL/4M7IFTkk=;
        b=KA2ijiN8MHWYdWweiI5oea2KAYmKZjssK+Kstu5h+MptakBG/a05XXAv9QgsRpapym
         pzccUfwEjqK7006AlzFVmbgK5iK4M4ahGoZ5piV5y5w6kGqX4pWsxe0oEvYT8lTXYVZT
         tPm3/LSJSLqpAE2OK2PDA5YqcFCzIYY0VvpunNk9K6NzZi2ja/O4av//939j9vhB5bvo
         /V/IGOrWtDKtQFUnUPArM/HK6fYrmhBFfyxJ55h/x6pKvnpSDrJOOn9f43qfdxEf4kru
         +pU1U34OQvFJwiRISsoeVU8sHx2zSbj0pSWLWZlr9712PifsB16abl2snweMfR+MNoFt
         uYWw==
Received: by 10.68.197.136 with SMTP id iu8mr10613267pbc.111.1340377113257;
 Fri, 22 Jun 2012 07:58:33 -0700 (PDT)
Received: by 10.68.54.73 with HTTP; Fri, 22 Jun 2012 07:58:12 -0700 (PDT)
In-Reply-To: <CAKkAvazNqZWk=QRmSFsFL33M6z+nZZ_yyxxbxwAh=fQk5DVt-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200439>

Given a certain commit, I want there's a command/option for git to
make it search the remote repo (e.g. origin) and tell me the
branches there which contain that commit.

So that I can pick the wanted branch and fetch it afterward.

The reason I need this is that there are hundreds of (could be more)
branches, but I just need a few of them, and don't want to fetch all
other branches.

I guess this could be an option for git-remote, so that with a given
remote and commit, it returns a list of branches (or even tags).
The list size might default to a number and should be customizable.

Thanks
