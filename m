From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git: problematic git status output with some translations (such
 as fr_FR)
Date: Fri, 20 Dec 2013 06:59:31 +0700
Message-ID: <CACsJy8Cw+YpG3C8PFuBOddDWLTBZB=bHDFBtTwYzLO=1a15LuA@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Dec 20 01:00:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtnVi-0008QF-T9
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 01:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab3LTAAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 19:00:04 -0500
Received: from mail-qe0-f48.google.com ([209.85.128.48]:40996 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab3LTAAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 19:00:03 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so1719513qeb.21
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 16:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Kj6uAHOj2hsznRy62Fiat7tx6lUE3sWUWZzRzz0ETvE=;
        b=phKoKfnBzbBnqinykqHug+H1n2MdBiPHeOP37UPvf8om/QD4h2rru2tlzMI2+2rCU8
         P5pFI7/JqjhehBGkaJXAKPT+kFqeeMFjt1Ou1R3k6Vl2qvSm+hcckcpSVH7YbXASK3Cb
         /iSjPdQDX6Kx5KymuwNbtWees5/SYcXgZLkuNxIZYPsEhnofYEwpitDFCPaNLNewbtGd
         TsAiJYXPZ6IkfQVokQ1G6DoMVMP0g9EzSt6V3tN1FdIBHKdJoWseQJQRkUto8zZELrD3
         Ckrn1241GChSq5v4gOKgVJCvqUyK7iHeq4ZtIoS06lHMSgRxYF+G+B/ri2SMGkzClulL
         LMVQ==
X-Received: by 10.49.39.165 with SMTP id q5mr8628627qek.48.1387497601620; Thu,
 19 Dec 2013 16:00:01 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 19 Dec 2013 15:59:31 -0800 (PST)
In-Reply-To: <20131219205049.GE20443@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239560>

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

i'm fine either way.
-- 
Duy
