From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #08; Fri, 20)
Date: Sat, 21 Apr 2012 22:25:07 -0700
Message-ID: <xmqq8vhomj7w.fsf@junio.mtv.corp.google.com>
References: <xmqqobqmkkxv.fsf@junio.mtv.corp.google.com>
	<20120421102335.GA29660@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 07:25:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLpIU-0005lH-9f
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 07:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab2DVFZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Apr 2012 01:25:10 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:33214 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab2DVFZI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2012 01:25:08 -0400
Received: by ghbz15 with SMTP id z15so1227252ghb.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 22:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Go4S96mDblNNZ9OqJW/RfAU2pn1k2Lctq9cKSPBFXsg=;
        b=GBH97fWWsY1l1f6cOdEluLnMr/a5vs3ScX4G2hzcw73suDqla+QWgBitv3uqPWvyH2
         DtLZ2ZjGFZtK20/B+65QN+xHOn5daMPcTk65/tPUtJ1K5hWNNHZG5u+N5CjX8FJ4cAle
         2Lj4UvsLzUsFHrYl/MUDo6MrvKIv6w5uxupuGkm2Q+qVzs1SWmrjcsFCNzUQm/4lAib+
         V61J5e7cPGZzuufxhfxH0qhSz5B0u0PvExMLXRJkF9G/QZCEI2LrONECmCZ1s0owVfup
         Gq7Zb1L6yUfoI815CX1QF9sDGYTI4Fmwcjdq3lqWmVJmwBD9+0Nf66AlPWwG4tjB8gqN
         AMkQ==
Received: by 10.236.125.170 with SMTP id z30mr14382405yhh.4.1335072308101;
        Sat, 21 Apr 2012 22:25:08 -0700 (PDT)
Received: by 10.236.125.170 with SMTP id z30mr14382387yhh.4.1335072308015;
        Sat, 21 Apr 2012 22:25:08 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z48si10714610yhn.7.2012.04.21.22.25.08
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sat, 21 Apr 2012 22:25:08 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id E3A6010004D;
	Sat, 21 Apr 2012 22:25:07 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 8DEB6E120A; Sat, 21 Apr 2012 22:25:07 -0700 (PDT)
In-Reply-To: <20120421102335.GA29660@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Sat, 21 Apr 2012 12:23:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlq7/XMKdUNC0aAKk1qQHmrHC3vmn2e9hyuFk7455YElBWZf82hUB0pajwdGPInEt9/Do6MU71bylyXat4UTnQOQt3/6oQyD8xkBQCx8gnwWqpqzhzIWvmNJ+BItAz+aRygiV9lgygN9/czaRagNm6Vrip1IWp76h0KY03QlGhXE2mQNoc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196076>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Fri, Apr 20, 2012 at 05:06:20PM -0700, Junio C Hamano wrote:
>> * fc/completion-tests (2012-04-18) 7 commits
>>  - tests: add tests for the __gitcomp() completion helper function
>>  - completion: fix completion after 'git --option <TAB>'
>>  - completion: avoid trailing space for --exec-path
>>  - completion: add missing general options
>>  - completion: simplify by using $prev
>>  - completion: simplify __gitcomp_1
>>  - tests: add initial bash completion tests
>
> Perhaps you could move 'tests: add tests for the __gitcomp()
> completion helper function' from the top after 'tests: add initial
> bash completion tests', to show that Felipe's 'completion: simplify
> __gitcomp_1' doesn't break any of the tests.

I don't mind.  Felipe, what do you think?
