From: "Vagmi Mudumbai" <vagmi.mudumbai@gmail.com>
Subject: JGit vs. Git
Date: Tue, 6 Jan 2009 12:20:11 +0530
Message-ID: <a55cfe9d0901052250k2be203dfvb0b437a523f2cecc@mail.gmail.com>
References: <a55cfe9d0901052249v1461c70cp1d89e184cfc05eb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 07:51:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK5mr-0006x7-NA
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 07:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbZAFGuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 01:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbZAFGuO
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 01:50:14 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:1590 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZAFGuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 01:50:12 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2443213yxm.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2009 22:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YW16gk176cyAz3emadkWV2FxDlX5LQvEOYzZbGDZ+iM=;
        b=MwOsz5M5ICIEUqOv9foL8KA5D/6NNrT00y3DWWcgLGHba/rpuvmzdpIvyb86AwlOnd
         8a5yzRSsCrYcyRBNLqxZ9vO9YxXdKFQwWGmh/kNhvyNgOgoVYMKrI/Nvh6/VVzS56VAU
         //9dbqEmOIWEf3GG5jqa/Xj+OM2503TzDRqck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qXf/MqSo6CWYX/RmxhN0RM3ywJIPX0C1o63odAuX8oQzb7QSotDcDA+rjHRVkVMRga
         lfySdVDMiSV+8QBb8TMUtV+Jqd4ohpPldnBaxA0FS6BKRp5BGVox0U3MmJaACDu3zxh2
         +r5WvS40JAJ6fuBvvvueBB2CNRR2nM5y1cWUo=
Received: by 10.64.241.15 with SMTP id o15mr16160179qbh.18.1231224611306;
        Mon, 05 Jan 2009 22:50:11 -0800 (PST)
Received: by 10.65.230.8 with HTTP; Mon, 5 Jan 2009 22:50:11 -0800 (PST)
In-Reply-To: <a55cfe9d0901052249v1461c70cp1d89e184cfc05eb9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104640>

Hi,

I am a git and a jgit noob. Be gentle. :-)

1) Is JGit a drop in replacement of Git? In sense, if I were to pack
in an SCM with my app, Can I pack jgit instead of C Git?

2) I noticed that there are no 'add' and 'commit' commands (at least
from the source) in the org.spearce.git.pgm project. I am looking at
the repo.or.cz/egit.git repo. I had a brief look at the
lib/GitIndex.java and lib/Repository.java. GitIndex has the add
methods to add files/entries to the index. I am still stumped on how
commits can be done with JGit. Any help is hugely appreciated.

I am working on Windows with msysGit behind a HTTP Proxy. (Life cant
get worse, I guess.) . I planned on using grit via JRuby but grit uses
fork which is not available on funny platforms like windows. And JRuby
guys do not have any plan on supporting fork even on platforms on
which for is supported. If JGit is a pure Java based implementation of
Git with more or less the same functionality, then my work becomes a
lot easier.

Regards,
Vagmi
