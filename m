From: Junio C Hamano <gitster@pobox.com>
Subject: Re: AW: Re*: AW: Getting the full path of a conflicting file within a custom merge driver?
Date: Fri, 05 Jun 2015 08:19:02 -0700
Message-ID: <xmqqoakutc7t.fsf@gitster.dls.corp.google.com>
References: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
	<xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468837AA7@DWPWHMS531.dwpbank.local>
	<xmqq4mmq3sug.fsf@gitster.dls.corp.google.com>
	<xmqqvbf3t98b.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468839F73@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Gondek\, Andreas" <Andreas.Gondek@dwpbank.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 17:37:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0tgR-0001By-Nh
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 17:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423574AbbFEPhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 11:37:13 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36132 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbbFEPhM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 11:37:12 -0400
Received: by igdh15 with SMTP id h15so929828igd.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=npeOWWbWS4Nrdpm8omyFz1FpKPVujzWlg/EiZZql+SU=;
        b=klInbc7zvGb8IwZprWp59zp13vf52Sn8m5Xksx/idNZO3Ddk3rW9czP5b827inkjC4
         gCF4/IU+NQb/VdEWWp4Lg81zUch3CpNfOLR6g5L3C52fQj1Engng86YMzy8MqAO5ZufB
         aMisck3Mki6xh7k6GMtxG3PmyZ1XySNgFVCflYw79eMEzR3e3Tlw8+LE/KYn4ew5IZLh
         ZEtQmYy5RhUwr7yoVDlhMN2hxf49Y2SB/IBgYkPjH9KE8Sa9jzfDLdwwHS6iLXwsLbcC
         cnnAPoIypX2ruvqkmK1EVXyiz72JnbUDx0VcTDab3d+0pqIjs97xfryCPyT6p0fNmJxK
         kicw==
X-Received: by 10.50.50.210 with SMTP id e18mr41750129igo.0.1433517544498;
        Fri, 05 Jun 2015 08:19:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id b15sm1539674igm.12.2015.06.05.08.19.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 08:19:03 -0700 (PDT)
In-Reply-To: <D8780C527EB1E642B3150E6D705B46D468839F73@DWPWHMS531.dwpbank.local>
	(Andreas Gondek's message of "Fri, 5 Jun 2015 05:56:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270843>

"Gondek, Andreas" <Andreas.Gondek@dwpbank.de> writes:

> One last question. If I don't want to compile Git myself, how long may
> the pu branch take approx. to get into a next release?

There is no general estimate; not all topics necessarily graduate to
the released version.

I'd leave it on the list (and in 'pu') for a few days so that other
people can poke a hole in it for me to fix or improve it.  And then
it will hopefully merged to 'next' for further testing by other
people.  It may graduate to 'master' before the pre-release feature
freeze for the next cycle in which case it will be in 2.5; otherwise
it may have to wait for the release after that.

We are at the end of week #5 (cf. http://tinyurl.com/gitCal), and
the pre-release feature freeze is expected to happen end of this
month during week #9 this cycle.  Given that the patch is reasonably
simple and straightforward, I'd say we will have it in 2.5 scheduled
for mid next month.
