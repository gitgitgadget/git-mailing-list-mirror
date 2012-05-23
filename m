From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 17:55:13 -0400
Message-ID: <4FBD5CC1.3060701@tedpavlic.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com> <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com> <4FBC0019.6030702@in.waw.pl> <7v4nr72bim.fsf@alter.siamese.dyndns.org> <CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com> <CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com> <CAMP44s3uW75O_jt2F7POxTAhX+qPyRSjOX9-DuEkg7a7WtnLsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpl?= =?UTF-8?B?d3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?B?VmlsbGUgU2t5dHTDpA==?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 23:55:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXJWd-000353-MG
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 23:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760829Ab2EWVzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 17:55:17 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64906 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab2EWVzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 17:55:16 -0400
Received: by obbtb18 with SMTP id tb18so11603495obb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tedpavlic.com; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=zkgr9qlL8ykBCNPszyk2qX3Bf/NhSIbfbtLUeRv4FPE=;
        b=Mw3Lf0U7iFu+GyZb815X5ZpA82NkJADZYm2NMsCUgUKDqrvsKPDV+w9KSrwW5YFXso
         eg11Fi5b0m4nymyvNowhcrVgnh1nsqB6+gvqQEwD5x0L7LYjy9UAsceHbEQGZBSYFNer
         VsAAToKZW8S70mQNyj6KLYgbem70nuP/xv9Pc=
Received: by 10.182.5.164 with SMTP id t4mr28803874obt.1.1337810115756;
        Wed, 23 May 2012 14:55:15 -0700 (PDT)
Received: from [164.107.119.81] (calgary.cse.ohio-state.edu. [164.107.119.81])
        by mx.google.com with ESMTPS id js6sm22180530obb.2.2012.05.23.14.55.13
        (version=SSLv3 cipher=OTHER);
        Wed, 23 May 2012 14:55:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CAMP44s3uW75O_jt2F7POxTAhX+qPyRSjOX9-DuEkg7a7WtnLsA@mail.gmail.com>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198328>

> There's no way git-prompt.sh can be sourced without modifications to
> the script, unless you expect it would always be named
> '.git-prompt.sh' and would be on the same directory, which many
> distributions would frown upon.

So, again, seems like a good argument for building a git-gitdir into git
proper. Maybe there are other utilities that could make use of it as
well...

-- 
Ted Pavlic <ted@tedpavlic.com>
