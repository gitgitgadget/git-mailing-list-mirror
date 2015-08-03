From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Mon, 03 Aug 2015 12:53:20 -0700
Message-ID: <xmqqk2tc87yn.fsf@gitster.dls.corp.google.com>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
	<20150801201950.5d8c1951@jvn>
	<CAPig+cQwgYYYYsszaRdJDwFLLB0PmiDQ_WTa+Nzzoq0U1zuMiA@mail.gmail.com>
	<20150802184353.2a5da936@jvn>
	<xmqqwpxd8rz2.fsf@gitster.dls.corp.google.com>
	<20150803122432.21066d73@pcviktorin.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 21:53:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMLnb-0002c0-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 21:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbbHCTxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 15:53:23 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33336 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbbHCTxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 15:53:22 -0400
Received: by padck2 with SMTP id ck2so97208152pad.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 12:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=U9g8F6Uki0y8s2wl/F67VUQ2MuJlI3O+XzFfaJZW4Mk=;
        b=Bavm23LDunevdM3F1liOSFTsWEeEtoUR4ij/a8yIagCzAb33/+1sLTWMzyP7cXKiH2
         96ys6mx6c5xsT1IQkiVpHazLgCtJaTWLiWLPq7tyOaac2T5chCEzU+oE6d4D6f1DZpBf
         HJcErYz34ldPHKxjJ5RJEjW98/ivb4DCHcTXzVVd/0D8fuC8IgUon/L2wUHtU7PqH1I1
         bkfLK2udyUtEnVjvSsQFYa4+ARXNsrsaFX4DilTWBez27EXKTURGq159AIOM7oo5jZm/
         ATHR6tD3nZTQ4v6ZtTGgxeC/q+n2YiOwybwC50NOby9iNGE0a4wo47jqJusuwx+qCggk
         u0MQ==
X-Received: by 10.66.220.5 with SMTP id ps5mr5688154pac.157.1438631601894;
        Mon, 03 Aug 2015 12:53:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id hk4sm8789727pbb.80.2015.08.03.12.53.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 12:53:21 -0700 (PDT)
In-Reply-To: <20150803122432.21066d73@pcviktorin.fit.vutbr.cz> (Jan Viktorin's
	message of "Mon, 3 Aug 2015 12:24:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275192>

Jan Viktorin <viktorin@rehivetech.com> writes:

> I didn't find a way how to determine what mechanisms are supported by SASL.

Ok, forget the suggested approach, then X-<.
