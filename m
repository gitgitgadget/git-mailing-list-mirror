From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 0/9] gitweb: avatar support
Date: Mon, 29 Jun 2009 23:55:38 +0200
Message-ID: <cb7bb73a0906291455i6a5e8d91ha535a3a918875ac5@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906292337.18636.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:55:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOpI-0003Gb-8c
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbZF2Vzh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2009 17:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbZF2Vzh
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:55:37 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:64008 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZF2Vzg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 17:55:36 -0400
Received: by fxm18 with SMTP id 18so1262301fxm.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 14:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zeVDm2dseT3qq/z2wof3LG33BmrjuhA9gEP0poEstWc=;
        b=IvqHVUFJ0GpalCJKjmjXu/cJu+RtbqWRt4Ck4umJso2/Eg5rf3vcuxFLU28QvBJFXC
         innl7E6OJ6t/3+ZZWweAkqaN37WBiJJCQ/cgLSpfkdL85URGIdVX/iLMt3I2UNULgPdR
         Xfias05ExlnnVZz7D+3ysLPVkf5UAhZ60shlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KpZIsFZCfJGiO+Ntypi0Rg8C3mqtT011v9DdcPyAmEOwVdgHSQRQfDkWsNg7v2yfdG
         fueh/GHzzntkQtE2REYtBiOC68xAqwbzCrdExK2suE7QvdbEqPrs/NH8cYaQ2tlcjh1N
         uZKo9IeaSHhpem4Q071jJCPoFHqfrv1mR3Jh0=
Received: by 10.204.78.131 with SMTP id l3mr7539063bkk.186.1246312538211; Mon, 
	29 Jun 2009 14:55:38 -0700 (PDT)
In-Reply-To: <200906292337.18636.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122467>

2009/6/29 Jakub Narebski <jnareb@gmail.com>:
>> Giuseppe Bilotta (9):
>> =A0 gitweb: refactor author name insertion
>> =A0 gitweb: uniform author info for commit and commitdiff
>> =A0 gitweb: use git_print_authorship_rows in 'tag' view too
>> =A0 gitweb: right-align date cell in shortlog
>> =A0 gitweb: (gr)avatar support
>> =A0 gitweb: gravatar url cache
>> =A0 gitweb: picon avatar provider
>> =A0 gitweb: use picon for gravatar fallback
>> =A0 gitweb: add alt text to avatar img
>
> I think this patch series shapes very nicely. =A0A bit of refactoring
> upfront, so that the following patches are not very large, and don't
> need to repeat the same code in many places. =A0Separate issues such
> as right-align date cell, or making 'commitdiff' view use authorship
> info layout from 'commit' view are put in separate patches in such
> way that they can be accepted or rejected individually.

Thanks. I'll send a cleaned up version of everything we agreed on.

--=20
Giuseppe "Oblomov" Bilotta
