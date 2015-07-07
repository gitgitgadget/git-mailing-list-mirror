From: Karthik Nayak <karthik.188@gmail.com>
Subject: [GSOC] Update 4: Unification of tag -l, branch -l and for-each-ref
Date: Wed, 8 Jul 2015 00:29:04 +0530
Message-ID: <CAOLa=ZSwqwmGSj-mR6EOagrFbX5Vngfp1QjiSa1m=KDnPZhaEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:00:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCY68-000816-4g
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 21:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370AbbGGS7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 14:59:50 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36554 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933145AbbGGS7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 14:59:35 -0400
Received: by obdbs4 with SMTP id bs4so135344504obd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=dDkq8O0T+IIKsF9/19hds0YROnpT+/kL1HjKkqhFN8E=;
        b=cK58w4N7n5p/pw5cKgte88GhBtFAE7yILnwAseR3/1Km+pmEtrdtqKmKjnuuRQOXJ3
         ejMoPsLCmkEwmp8mdR0Qs09FWNDdFUtV6DR14gqo08Y70ODBzV1bdk0LcQywMvMxbwW+
         XUXlY1EPCZ+8p7JWhsrPjdh5P1V1yMS4fGB5FCEH327nKTKxwQiS+QCLM06kApqVpFmq
         A1QLAogCUsN7ZpborXSCJlvywkp6iF/Et/owA6XOIrQSGmz5nbs0R0yQxEvmm69ZEy15
         F4I0wPmV5a/74LmHXoZ78KkaQo4McDjKV9KvZ5Qkn70v9rd0KFrucSRnFJhDgzph2RJ8
         YxUQ==
X-Received: by 10.202.180.133 with SMTP id d127mr5454157oif.104.1436295573827;
 Tue, 07 Jul 2015 11:59:33 -0700 (PDT)
Received: by 10.182.95.174 with HTTP; Tue, 7 Jul 2015 11:59:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273594>

Hello All,

As part of GSoC I'm working on the Unification of 'for-each-ref', 'tag -l'
and 'branch -l'. Sorry for the lack of update since Jun 14, was a
little busy with an exam I had. Now thats over, I will be working more
on the project.

Current Progress:

1. Building ref-filter.{c,h} from for-each-ref.
This is the process of creating an initial library for the unification
by moving most of the code from for-each-ref to ref-filter.{c,h}.
Merged into next

2. Add options to ref-filter.
This includes the porting of --points-at, --contains, --merged,
--no-merged options from builtin/branch.c and builtin/tag.c, Also the
implementation of these options into for-each-ref.
The last version (v8) is posted here:
http://thread.gmane.org/gmane.comp.version-control.git/273569
Currently waiting for comments.

3. Port builtin/tag.c to use ref-filter.
Here we port tag.c to use ref-filter and also port the --format,
--sort and --merged and --no-merged options to builtin/tag.c.
The "RFC" version is posted and I'm waiting for comments from the list:
thread.gmane.org/gmane.comp.version-control.git/272654
Will post v2 soon.

Next Plans:
I'm currently working on porting over builtin/branch.c to use
ref-filter.{c,h}, will be pushing intermediate code to my Github repository.
Currently looking at what all branch.c needs in ref-filter and adding respective
options to ref-filter.
https://github.com/KarthikNayak/git

Thanks to everyone who has helped :)

-- 
Regards,
Karthik Nayak
