From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] branch: honor core.abbrev
Date: Fri, 1 Jul 2011 14:05:58 -0500
Message-ID: <20110701190558.GC8929@elie>
References: <20110630181020.GA1128@elie>
 <1309500368-3729-1-git-send-email-namhyung@gmail.com>
 <7voc1doo8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Namhyung Kim <namhyung@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 21:06:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcj2a-000548-8l
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 21:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804Ab1GATGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 15:06:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64726 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab1GATGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 15:06:04 -0400
Received: by iyb12 with SMTP id 12so3028811iyb.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HWya/tNvtZ0VI2Gr1SjMcFDdpjQn9VZGGIqNi1JjHDA=;
        b=C82YO0Ib86VmfR5Cf5SrqDkGvDavma5reO5pHgiw6luWj7UDwfQo+q6UXjtaOJS1Ky
         3ZBs16nm8q4p7DA6kMlM0eiHoMQV4C9a2veKCCroXlHKKX7ghWhtyt9K3ipBMS7bbmEC
         ZGaY5A7t+hj3/a2LNT8T9CcZgQXrXwAWkTgQU=
Received: by 10.42.132.69 with SMTP id c5mr3616285ict.459.1309547164139;
        Fri, 01 Jul 2011 12:06:04 -0700 (PDT)
Received: from elie (adsl-68-255-110-41.dsl.chcgil.sbcglobal.net [68.255.110.41])
        by mx.google.com with ESMTPS id j7sm3622328icq.2.2011.07.01.12.06.02
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Jul 2011 12:06:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7voc1doo8v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176531>

Junio C Hamano wrote:

> It is not clear from this description when "git branch" needs to even show
> abbreviated object name.  I'll retitle it and/or reword the description to
> hint that you are talking about "branch -v", but do you know of anything
> in "git branch" that may be affected by this change other than "-v" output?

I think it's just add_verbose_info.  "git branch" also uses
DEFAULT_ABBREV in the message

	Deleted branch topic (was 980ab98c).

but that is not currently affected by the --abbrev option.
