From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git: problematic git status output with some translations (such
 as fr_FR)
Date: Sat, 8 Feb 2014 16:51:47 +0700
Message-ID: <CACsJy8AvnYsWCxwJbiSVtva7Evbn9Y4sPi3jgav1Ke2GirBQvQ@mail.gmail.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
 <20131219104613.GA18379@x230-buxy.home.ouaza.com> <20131219194319.GB20443@google.com>
 <xmqqk3f0efhe.fsf@gitster.dls.corp.google.com> <20131219205049.GE20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Raphael Hertzog <hertzog@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 10:52:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC4aH-0003Sd-W5
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 10:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbaBHJwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 04:52:21 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:47844 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaBHJwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 04:52:17 -0500
Received: by mail-qa0-f48.google.com with SMTP id f11so6770981qae.21
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 01:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M56KuGJrGvdUrq9PjfgAVZ+1yguN9r+MxrcXBbDRvH8=;
        b=t1vj1w/dHm3nJol7eWuu2xG0R4amjyMF9b+X3TuFfSA7QvDRBcbqBR1zqGFypOEUUS
         0fofFgNBNnvu+l88nwYvKY2oI5muc8UZahIpj0kHCaChoa3g+L8CLjBLeZZidj+AdpG4
         CLB2l8mgOtZ0EbUSoIQdV+Tj9G+v8bruKNeKhzUvI39RD0noKH7M0ZqqCMIebpX8nNrj
         FyhKGBXc49mzt2yLB7XqiEpCGOVLvHEIQbpTKRX6dK1KOroRd4vpagyvkPFYO9AreiHP
         ogYH196a/hlJI1n248I0cZgbNhs59aUNLEnL5xbu+4ezp+nesQ1sUAfA2Bk9SGFMIipk
         VX7w==
X-Received: by 10.224.26.71 with SMTP id d7mr30035943qac.89.1391853137140;
 Sat, 08 Feb 2014 01:52:17 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 8 Feb 2014 01:51:47 -0800 (PST)
In-Reply-To: <20131219205049.GE20443@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241832>

On Fri, Dec 20, 2013 at 3:50 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> This includes the colon in the translated string, to make it easier to
>>> remember to keep the non-breaking space before it.
>>
>> Hmph, recent 3651e45c (wt-status: take the alignment burden off
>> translators, 2013-11-05) seems to have gone in the different
>> direction when it updated similar code for the non-unmerged paths.
>
> Yes, if this seems to go in the right direction, I'd add a follow-up
> for that when rerolling.

Just checking. Did you reroll it or did my filters move some mails to
spam/trash folder again?
-- 
Duy
