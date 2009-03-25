From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Documentation: git-format-patch.txt rewordings and 
	cleanups
Date: Tue, 24 Mar 2009 23:21:22 -0700
Message-ID: <780e0a6b0903242321q252c4b44k3909bd79003ded6b@mail.gmail.com>
References: <1237803683-14939-1-git-send-email-bebarino@gmail.com>
	 <20090324220913.GN19389@fieldses.org>
	 <780e0a6b0903241636j4749daf3xddb6e4c200c00820@mail.gmail.com>
	 <7vskl2tr00.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 07:22:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmMVs-0003oX-HB
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 07:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbZCYGVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 02:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbZCYGVY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 02:21:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:33607 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbZCYGVY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 02:21:24 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3870823wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 23:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ajYUkhMkBU7H7LfWp0ECoaW1T3oMyuS8c8xCxGZoUPE=;
        b=CPab8Y+9TWHEowlLxRoGBiC3WraiMp4c/kbaTuT6IME1i4KquIrM/+Jlz7gbk0LmEM
         N+Cl2S0NauuehQ1QIbBRJJqdTwXFfj1l+OaIs1+XGJUJobQCWfUu2iocJ2ZIczYI0h7a
         9LYK4bg3TuFOjPS6azYP1LkKDOTY1nls8Yqow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YxsygylFxHXjHfwBVAvMhXKIAiy1FERhDRqd/EyvREKIYJfpxyBGtKfl8V9ZRc4TG0
         oGIC7CH4oaCgz31RxvqKfWH72TqtpPjMknaeqlg/Bqol8YqT9qB15zXdayYWnF3PncQT
         TB4/srTCV+DSzTZyvZuaITDCuTpwnP4nU4U4Y=
Received: by 10.142.144.16 with SMTP id r16mr3763759wfd.214.1237962082280; 
	Tue, 24 Mar 2009 23:21:22 -0700 (PDT)
In-Reply-To: <7vskl2tr00.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114566>

On Tue, Mar 24, 2009 at 4:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>
>> How about a sentence with no negation?
>>
>> "Note that the leading dot is required if you want a dot between the
>> patch name and the suffix."
>
> How about a sentence that does not sound requirement but freedom?
>
> "The leading character does not have to be a dot; for example, you
> can use --suffix=-patch to get 0001-description-of-my-change-patch".

Looks even better. Do we still want to start off by saying "Note that the..." ?
