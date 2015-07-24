From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Thu, 23 Jul 2015 17:51:37 -0700
Message-ID: <xmqqlhe6nzs6.fsf@gitster.dls.corp.google.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
	<1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cRS0NcNcw-0wG4mThN_PW0RoN3b09Yu2GzCr=UFPLYd6A@mail.gmail.com>
	<xmqqvbdao762.fsf@gitster.dls.corp.google.com>
	<1437698706.22096.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"barkalow\@iabervon.iabervon.org" <barkalow@iabervon.iabervon.org>,
	"jacob.keller\@gmail.com" <jacob.keller@gmail.com>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 02:51:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIRDG-00020C-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 02:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbbGXAvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 20:51:42 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35239 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbbGXAvl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 20:51:41 -0400
Received: by pabkd10 with SMTP id kd10so4696190pab.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 17:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ls4qt6e7fD/+HQMJ8+Ks5AHhrTnGrsqyTPDG3QL69DA=;
        b=EvufCX76qHZzF7N3O66YVca3DNAFZME7Neo5c0PROfKNWaNjK60/bJnVlHuiH/Xc8r
         AFc6KANHw0vYbyYCpDQCa8EgPKyphDHZcysQHtxnhUAAes7Z1JteR+adUEYz9+wpoSyO
         jYG6UiTfBaGqVz5x/VoNffnsmJlafp+h6faCQPEStQ2hSVZiIf2WzFsbtsDOVdG4Fy2L
         j+XeMLS+FhaS+qcJLMb36VKBmwr3dPohvzutiQSgSSkd7esAkGZVQqEY6DCJ2Xet811q
         MEAza5fUby91BE7eAlqSUzxCVJL3LlWXxzU2bgWBKuJFfLpNLILqDDcdPbZTLhQVEfY/
         tQkg==
X-Received: by 10.70.135.129 with SMTP id ps1mr24465584pdb.110.1437699100619;
        Thu, 23 Jul 2015 17:51:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id e8sm11092908pdm.13.2015.07.23.17.51.38
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 23 Jul 2015 17:51:39 -0700 (PDT)
In-Reply-To: <1437698706.22096.5.camel@intel.com> (Jacob E. Keller's message
	of "Fri, 24 Jul 2015 00:45:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274534>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

>> > s/hangled/handled/
>> > ...
>> 
>> Thanks; here is what I queued yesterday.
>> 
>
> Woah. I bow to your imperative commit message abilities. The new commit
> message is very nicely worded.

Heh, imperative is secondary. I just wanted to straighten out the
use of "refs" and "refspecs" there.

Thanks for a patch that was cleanly done.
