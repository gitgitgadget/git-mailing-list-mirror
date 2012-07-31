From: Edward Toroshchin <edward.hades@gmail.com>
Subject: Re: Centralized git
Date: Tue, 31 Jul 2012 17:40:46 +0200
Message-ID: <20120731154022.GB31773@phobos.chilli.itwm.local>
References: <CALZVapnwGK=cKdHbZRsN0Ust7TAvFqa3AmYD7pzgoxdDxQh+uw@mail.gmail.com>
 <CALZVapkUu+hckMRAaNULSW5s9Q7P+78eVt1Q+ZrKFdPYb5uFVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 17:40:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwEZ5-0002Wk-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 17:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab2GaPkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 11:40:52 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41790 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab2GaPku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 11:40:50 -0400
Received: by bkwj10 with SMTP id j10so3355291bkw.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ir60ZBe9h9pyKm64+KFuewP3eWkcM0oizeBjOweKl0I=;
        b=AT4td7HsJpLMzTd3+B2fyr4/0/+T3z/4EiTeR/O61tlayrx/yDZ+BZextyuzq8bT6N
         iJU/SS9RjQsOsOYwB68UBQZvsIjvDHZRrrqYIfMt8Ef3THShuIESABw7+gJ3xj+3ubQD
         U7+osBt9zCa2w4Z5AA+BS72MsfL4m+7LMbWbV9qS9VQpfUND5qdHe2m4kYeMxuH0S2pK
         FtsE93VGYr9rgQexWyFVRNPV9cOO+kx5bQ/EuRoaHfn440kXxP9fM8ICNBikmDl+tq85
         Bu4hQeJ2s8bTjGfBPcB1WP8s4+Zvnam3NzSQBQp9LOGtbjIxD8XXbl6GpmtUUMe0Xw2R
         jWdg==
Received: by 10.204.154.66 with SMTP id n2mr5424940bkw.138.1343749249499;
        Tue, 31 Jul 2012 08:40:49 -0700 (PDT)
Received: from localhost (ganymede.hades.name. [81.17.21.251])
        by mx.google.com with ESMTPS id hs2sm345112bkc.1.2012.07.31.08.40.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 08:40:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALZVapkUu+hckMRAaNULSW5s9Q7P+78eVt1Q+ZrKFdPYb5uFVQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202656>

Javier,

Are you sure you need git for those big binary files at all?

Branching makes sense only if merging makes sense, and I can hardly see
how you can merge three 700-megabyte video files.

-- 
Edward "Hades" Toroshchin
dr_lepper on irc.freenode.org
