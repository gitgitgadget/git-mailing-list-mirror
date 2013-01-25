From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v4 1/4] t6006 (rev-list-format): don't hardcode SHA-1 in
 expected outputs
Date: Fri, 25 Jan 2013 19:27:08 +0400
Message-ID: <20130125192708.291e62bc@ashu.dyn1.rarus.ru>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
	<cee3610fde1626c2854eb5b821529ab22a06e4bf.1359018188.git.Alex.Crezoff@gmail.com>
	<7v38xqba04.fsf@alter.siamese.dyndns.org>
	<20130125150620.3b9dc9c3@ashu.dyn1.rarus.ru>
	<7vmwvx5m4o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 16:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TylBn-0002aL-HQ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 16:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab3AYP1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 10:27:15 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:51410 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3AYP1N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 10:27:13 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so905384lbb.22
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 07:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=qyVmpKPTJNiN2W6PdnRj1Oajs9o8O1K3hIwhJrbILZk=;
        b=Zcsc/l4gVnk7GjDUt5lUAkeo+O36WRuPdOiJmK7D1sHqPTNujNwrUcowk4SnfwmCW5
         fW0Aa+8mEGjb+m375MhAAVroMYfSq+ixpgsLbLsvvIwEhLadlmxzt+ibf44hdWtG/od8
         ZUM3lMGzvXDqj0I5V4A+CLVtnulEmQ5tn1x2NRJmVQc3+8jxrIWEw0B1ojVCIDaExH0N
         aOs1DFPr4Hb/B3XbNqf4kOVWhShiFguHeaBybYycKd2/EwvpQQjhqj6InZLrKCuIWJn4
         cJff8b7HIUBmlDQFD7Kgy9jdmscWH7NAqKGt5533vB9MuutrYPSPPuHdqeFswOWUz0jp
         WgNw==
X-Received: by 10.152.104.199 with SMTP id gg7mr5472595lab.14.1359127632324;
        Fri, 25 Jan 2013 07:27:12 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id ml1sm640229lab.15.2013.01.25.07.27.11
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 07:27:12 -0800 (PST)
In-Reply-To: <7vmwvx5m4o.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.13; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214557>

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> >> Why do we want "whatever_7" variables and use "cut -c1-7" to
> >> produce them?  Is "7" something we care deeply about?
> >> 
> >> I think what we care a lot more than "7" that happens to be the
> >> current default value is to make sure that, if we ever update the
> >> default abbreviation length to a larger value, the abbreviation
> >> shown with --format=%h is consistent with the abbreviation that is
> >> given by rev-parse --short.
> >> 
> >>     head1_short=$(git rev-parse --short $head1)
> >> 
> >> perhaps?
> >> ...
> >> Likewise.
> >> 
> >> > +	tree2_7=$(echo $tree2 | cut -c1-7)
> >> 
> >> Likewise.
> > but is there "git something" to return abbreviated tree hash except
> > "pretty formats" that is implicitly tested here?
> 
> Does "git rev-parse --short $tree2" count?
Oops! Yep!
