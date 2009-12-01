From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit RFC PATCH 0/6] add support for git send-email
Date: Tue, 1 Dec 2009 08:38:19 +0100
Message-ID: <b8197bcb0911302338x39f06c1du2023d76c9f094121@mail.gmail.com>
References: <20091128194056.949.88791.stgit@bob.kio>
	 <b8197bcb0911291405i6f052216q8717c34063320592@mail.gmail.com>
	 <20091201000258.GM12733@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 08:38:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFNJb-0000JB-A0
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbZLAHiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 02:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbZLAHiP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:38:15 -0500
Received: from mail1.space2u.com ([62.20.1.135]:52997 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbZLAHiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 02:38:14 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nB17cDtB025343
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Tue, 1 Dec 2009 08:38:13 +0100
Received: by bwz27 with SMTP id 27so3192759bwz.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 23:38:19 -0800 (PST)
Received: by 10.204.48.131 with SMTP id r3mr5449744bkf.195.1259653099464; Mon, 
	30 Nov 2009 23:38:19 -0800 (PST)
In-Reply-To: <20091201000258.GM12733@ldl.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134172>

On Tue, Dec 1, 2009 at 1:02 AM, Alex Chiang <achiang@hp.com> wrote:

> * Karl Wiberg <kha@treskal.com>:
>
>> Did you remember to run the regression tests? It's very helpful when
>> reviewing to know that the regression suite passes at every point in
>> the series.
>
> Good idea. I've been running t/t1900-mail.sh at each stage

Perfect.

> since my changes seem rather localized to sending mail.
>
> Should I be running the entire suite?

Just running that single test should be sufficient in this case; as
you say, the changes are rather well contained.

Running the whole suite takes a few minutes, so it might be worth
doing once in a while.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
