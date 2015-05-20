From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 01:53:48 -0700
Message-ID: <20150520085346.GA99001@gmail.com>
References: <1432107722-98613-1-git-send-email-davvid@gmail.com>
 <CAHGBnuMCvzBYRYgLxz-5QJ5x8Quhw6byf+cGteRXQzpU65B+Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 10:53:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuzlG-0005mA-8k
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 10:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbbETIxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 04:53:54 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33257 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbETIxw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 04:53:52 -0400
Received: by pdbqa5 with SMTP id qa5so61207071pdb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 01:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RQ8sjk45LfhbNP1m7DQcZJmWaXbTgLRwIrj78/9tpIg=;
        b=DhgETiZVN9hhAwyWdAaKegfdpTdFv3LEa+IVs1iaHB1bQydQigt52zgUXIv6jkRx5h
         xRZgvBGtkb8NzxsFlKMXmaYmWZ3RDH4IN2GF9X/O65sk3NZ0fixO72LfVah6azRhFCPI
         x45QAZPxsTT61HEjnEAXTgb1f8iU15OU8Em59rd9W3aOFH1zcns3O9dX0Hy/05XpF0S1
         G1mP6bB139wbtVB4Ik3q/Qy5iM45q9uAL5A+LUD9ryZEUnQPtLNrw9T/7+nAwyxzSQjp
         KHwCTgVDsvXmv9qcMQ+6SmxSfBlDBDmiMJNlccV9XgvPzTINWs04/4RPIuRnY0DhBL68
         xdxw==
X-Received: by 10.70.96.162 with SMTP id dt2mr61178876pdb.20.1432112031773;
        Wed, 20 May 2015 01:53:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id c10sm8883305pbu.81.2015.05.20.01.53.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 01:53:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHGBnuMCvzBYRYgLxz-5QJ5x8Quhw6byf+cGteRXQzpU65B+Jg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269451>

On Wed, May 20, 2015 at 09:47:56AM +0200, Sebastian Schuberth wrote:
> On Wed, May 20, 2015 at 9:42 AM, David Aguilar <davvid@gmail.com> wrote:
> 
> > +       OIFS=$IFS
> > +       IFS='
> > +'
> 
> I guess this is just a formatting issue with the mail export as it should read
> 
> IFS=$'\n'
> 
> Otherwise looks good to me.
> 
> -- 
> Sebastian Schuberth

Thanks for the review.

That's actually a literal newline inside a single-quoted string.

I'm not sure how portable $'\n' is, but the '<literal-newline>'
approach is used often in the git code.
-- 
David
