From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [RFC] Documentation: --options in man-pages synopsys
Date: Tue, 8 Oct 2013 18:07:07 +0600
Message-ID: <CA+gfSn-o7cH3a-KWx_iggNc4-rYzQysbTj7OGdaggutLu-X-BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 08 14:07:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTW4H-00071h-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 14:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab3JHMHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 08:07:09 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:55621 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3JHMHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 08:07:08 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so397670obc.22
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2sTt6SwQ37FTqjYp18beN7Mj16qsh0jJmFAy15tvNG8=;
        b=StVaA13UZopfNTdVyVfYoCGsNU8eVNVa5NOQml9UoukN3rGu396o9uvbN2p3v8vIFv
         JsMaz/6iCI06jE8FbgLP+cgCbIGM6wm2MN9TNhVZNWLDlKgKcVVMFbEf8Ll3xdQ8lIQj
         xW/WbzdUgUZix3mMMFymdr4NupopUxIKas7rWzfrYsqZQH4bRQulK7R+t12vJYlR/jCh
         GSKyMtSicaA8zSKqIDZuiIizpk6VRuB6f/NeVHLhFhm8Uxs0Mu6YULJhWhlzkP7ie2N+
         nct/cFvPj9Jm5tym2f2Pw+7Vm3WKCkj7qmdwKplniclV8yCPYEgDlFutnKNZEjil3+Ef
         HAMw==
X-Received: by 10.182.98.162 with SMTP id ej2mr15648obb.61.1381234028006; Tue,
 08 Oct 2013 05:07:08 -0700 (PDT)
Received: by 10.76.107.75 with HTTP; Tue, 8 Oct 2013 05:07:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235772>

Hi,

I've noticed that man git-pack-objects describes cmdline as following

SYNOPSYS
'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
[--no-reuse-delta] [--delta-base-offset] [--non-empty]
[--local] [--incremental] [--window=<n>] [--depth=<n>]
[--revs [--unpacked | --all]] [--stdout | base-name]
[--keep-true-parents] < object-list

while OPTIONS sections has even more options, --no-reuse-objects for instance.

Should it be dealt with and how?
- add smth like ... at the tail of options in synopsys to indicate
that there are more options
- add all the [--options] to synopsys
- drop all the [--options] as they all are optional
- pick only the most common/important ones like -q --progress, per
command or per command classes (hard to maintain and/or verify?)
