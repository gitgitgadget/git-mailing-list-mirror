From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Mon, 29 Apr 2013 20:50:44 +0530
Message-ID: <CALkWK0n=K1PK64xAvCUOQwhMUUtdSLyOGxNLZuqWYvVddZgmKw@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <20130426101946.433f2d12@chalon.bertin.fr> <517A3E47.6010606@viscovery.net>
 <7v7gjpxjw0.fsf@alter.siamese.dyndns.org> <CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
 <7v8v45vvuy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 17:21:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWptS-0005pb-PH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 17:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab3D2PV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 11:21:26 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:44653 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3D2PVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 11:21:25 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so7478102iec.14
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JvHnha9Vaa0+VaRbpvLawrPcCXkwnKkHW5U+7GRNbJY=;
        b=TmOydaqWAM+QiEijLsOHfxBK2euO9gwMQKo1XCjraRSwiKhhgw7mzVYQv377jlD4be
         CCpRwGwl9j9RZKquPFyneDWlPNwGzF3WDghdvezpdRu/WeeI0KogyXhJ4CxanG1nsYHd
         82OE+rrXDlqfnA/KVhVGwBzprq1sIxNToyVLUBJ3j/OifsMTf4oEOXponO7w/eRZgD8g
         TMxpcPuATqPTjwUgCum4kyeMUVZPAQ4m5Hs/+KFbgeGVsGa5NycezWienkCaKvqDsokd
         ztCBNCM/N+G87x6hkRN5TO674ekyjWIn1lNTAhpfXEMvnxwxa8pHiGTPE4sd3SxK69cj
         wIGQ==
X-Received: by 10.50.66.197 with SMTP id h5mr7460745igt.63.1367248885275; Mon,
 29 Apr 2013 08:21:25 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 08:20:44 -0700 (PDT)
In-Reply-To: <7v8v45vvuy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222802>

Junio C Hamano wrote:
>  - If the UI language for "rebase" were designed following the
>    "composition using common elements like ranges and revisions"
>    school, it would have started from "rebase --onto=X A..B".

I will try to drive the point home one more time.  What do you really
want to rebase?  B ^A or B ^$(git merge-base A B)?  They're two
entirely different things as I've repeated countless times.  And the
latter is what I always really mean.
