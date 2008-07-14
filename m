From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Mon, 14 Jul 2008 03:04:33 +0200
Message-ID: <487AA621.40701@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <7vmyklpiqk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 03:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KICVc-00084S-H9
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 03:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYGNBEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 21:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753598AbYGNBEl
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 21:04:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:16207 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbYGNBEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 21:04:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1987106fgg.17
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 18:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=e70ZOQp+S/1jQfZeGrUBwz8ARWzFpm07T5w7s7vB9Fw=;
        b=pP7RO8UQtDKyFyIWY5C4u+yOKavwZQE2nMcecsnp7xMfG9JxKE/M7hRDnsGlQLvnKr
         z8AhzWqyqkshAXsf38q4J8mnN1q5uqezty36q/6dQktrx+qYwcMdZ3n1mi+kPiqC2Kvf
         LOWHkhrsL/hXN0svbmK58KI/ZpMfwmnAnQzTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=eb5Vm6gsB/FM0Kyy/puFt7fTfnbn8wE7i6ROpJUq7Y8vuq+7LFcBnE7OnZlGhtgCiC
         YICUSZVOhEVrR8F/eLO+UviUtJ6zPZBUth8GJx7AXEMrZRIHR33PW27NWPifWnh8txdu
         9zUfiGsrWDET8WBjCivEGJCWFIsGN8tP1ypPI=
Received: by 10.86.1.11 with SMTP id 11mr13539402fga.27.1215997476614;
        Sun, 13 Jul 2008 18:04:36 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.204.92])
        by mx.google.com with ESMTPS id e11sm6071872fga.4.2008.07.13.18.04.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jul 2008 18:04:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vmyklpiqk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88364>

Junio C Hamano wrote:
> This probably is something the person who mentors you as a GSoC student
> should tell you, and shouldn't come from me,

No, thanks for telling me.  I'm actually keeping John quite busy with
the server side on kernel.org, and wouldn't currently expect him to look
at the patches I'm sending.

> I would have preferred to see the first paragraph of yours stated more
> diplomaticly; it sounds rather unilateral ultimatum to me.

Apologies; I was trying to hold off developers who'd see duplicate
functionality and run off at me screaming "unacceptable! impure!!one".
I should've phrased it more carefully.

> This patch was not signed-off, but I assume it was simply forgotten

Yup.  In the unlikely case it gets applied as-is, feel free to add it.

(I'll reply to Jakub's email shortly, unless I fall asleep in the
meantime. ^^)
