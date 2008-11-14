From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2 09/11] gitweb: git_is_head_detached() function
Date: Sat, 15 Nov 2008 06:17:21 +0900
Message-ID: <20081115061721.6117@nanako3.lavabit.com>
References: <7vk5b69p87.fsf@gitster.siamese.dyndns.org>
 <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
 <7vk5b6dd3t.fsf@gitster.siamese.dyndns.org>
 <cb7bb73a0811140052h1b7aac6cp6b0b376fa59548a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:19:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L164x-0004rM-Gq
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 22:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbYKNVR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 16:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbYKNVR6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 16:17:58 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60502 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbYKNVR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 16:17:57 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 7D5FBC8429;
	Fri, 14 Nov 2008 15:17:56 -0600 (CST)
Received: from 1211.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id Z87MUBKTE8ZG; Fri, 14 Nov 2008 15:17:56 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=V0hoTA+LtZXo5PaYxqk++HIKBpXM/kO+BYBNgsRF+zbbF5pdAsW79c+UDJBSiDS4QwfFMQvmDiOMHtwZ8med8vfEkVTZC8vvNoUyGVheGh0HHCCHtgEKy7LGSe2LwFmcVa+uJ2qQwZNkFMNsoTB55TCf0ZIAfc3IrUzPLTKPy98=;
  h=From:To:cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vk5b69p87.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101016>

Quoting Junio C Hamano <gitster@pobox.com>:

> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>
>> I have been thinking about making this detached HEAD thing an
>> additional option, but it _really_ seemed like overkill.
>
> I agree that it does not make much sense to make this feature an option.
> Detaching the HEAD in the repository itself is an enough clue from the
> user to the code that the user wants to trigger the feature.

Shouldn't the feature to show remote tracking branches also be unconditionally active, then?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
