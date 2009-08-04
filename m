From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] send-email: remove debug trace
Date: Wed, 5 Aug 2009 01:22:45 +0200
Message-ID: <40aa078e0908041622p7cf2097cy4e8a673313a9a2a1@mail.gmail.com>
References: <1249423054-3416-1-git-send-email-kusmabite@gmail.com>
	 <7vbpmvfcgz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, madcoder@debian.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 01:22:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYTLK-0004J5-Si
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 01:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbZHDXWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 19:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbZHDXWq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 19:22:46 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:33508 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115AbZHDXWp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 19:22:45 -0400
Received: by fxm17 with SMTP id 17so3582715fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j2w2IU34YAYMrN3B1xRvHPd1mRJuujikKIT9B+vtVvw=;
        b=f8F9OvK26RbalRte5RClLwyUPX4mbP8Vh3WAQAwkxRpWLMzSAmeBTUcdisSopfuEbI
         WQuOm0zTPj3Ag+fi7+0qXi8t/upSVqp5g6IsQSCqg2PPaRncuKvhHBqlE/2MazMTTypm
         ZnJCLl8gW+xJHvZJar1pJJb2zoqHKJP3DH72I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uUJr8LjRrcKC+1dJIKPU2F/4p805cxvHu5ONCNeoCP8SmOnUTQEqc8D220GbZr3FgO
         hxHlMUMzI9aBLaUYY1do4EhRmdj+JM9ezl4WxGfGUvVajFtG/xoXAt+GbmFG20KHiWuD
         JWEdyjPTtNrjmwqTFBEuFCUdUB7IIAI09gJPI=
Received: by 10.204.56.4 with SMTP id w4mr243778bkg.25.1249428165470; Tue, 04 
	Aug 2009 16:22:45 -0700 (PDT)
In-Reply-To: <7vbpmvfcgz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124832>

On Wed, Aug 5, 2009 at 12:20 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Nobody noticed for the past 9 months? =A0Interesting.

My guess is that not that many people are using --[no-]format-patch,
since it's only really useful if you have file names that collide with
git references. Who calls their files things like "HEAD~5..HEAD~2"? :)

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
