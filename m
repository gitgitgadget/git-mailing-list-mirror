From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] path: optimize common dir checking
Date: Wed, 26 Aug 2015 15:15:42 -0700
Message-ID: <xmqqoaht1ysx.fsf@gitster.dls.corp.google.com>
References: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
	<1440618365-20628-3-git-send-email-dturner@twopensource.com>
	<xmqqwpwh21ky.fsf@gitster.dls.corp.google.com>
	<1440627031.26055.5.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	sunshine@sunshineco.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 00:15:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUiyz-0006OB-F9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 00:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbbHZWPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 18:15:45 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33178 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbHZWPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 18:15:44 -0400
Received: by pacti10 with SMTP id ti10so1394470pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5mwgKI05LCgLt1mbOUJlqEAMpcuNh+3AAVdlT0LcIf4=;
        b=06A0ULPqLoLnrS/OjPFKZFRR88fE1zf5nQV1dJ2nd+jM5zqbP7QfyMUb3BnsIPhrcg
         3cSzC+kxM0IFFWWjn+oWyBtZWrdJQoiEJx+ov953Gdz6IxZo6DAOtCa9nfcgw6pPOwHj
         S0rgPZSNcpMcJoSLCwgKUH1K5zTQxqD3Mxtq6CA+kfT2dI1rlLRmlEVdo5z95jKomq+a
         YC6W4zr39oTwtmXYQyi5iHb7yCcM08gegTFly7/5mue65dDVn506Cu7fjxCxO/ocujae
         ZBTtyEfMJ2DX19JFPqSJbhqf5SuCvLOP9UrKvxtqPgWkC4D8UYvkxY9k/mVOeVE6dG49
         AnBg==
X-Received: by 10.68.69.70 with SMTP id c6mr2089531pbu.28.1440627343993;
        Wed, 26 Aug 2015 15:15:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id fu4sm50608pbb.59.2015.08.26.15.15.42
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 15:15:42 -0700 (PDT)
In-Reply-To: <1440627031.26055.5.camel@twopensource.com> (David Turner's
	message of "Wed, 26 Aug 2015 18:10:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276644>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2015-08-26 at 14:15 -0700, Junio C Hamano wrote:
>
>> Thanks for a pleasant read.
>
> Thank you!  I'll re-roll with those last two fixes (re value=NULL)
> tomorrow-ish.

If these two "value = NULL" are the only things, I can locally fix
them up.  No need to resend.

Thanks.
