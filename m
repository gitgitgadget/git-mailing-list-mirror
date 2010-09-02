From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 24/25] gettextize: git-status basic messages
Date: Thu, 2 Sep 2010 15:28:46 -0500
Message-ID: <20100902202846.GD2531@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-25-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:30:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGQw-00033X-TD
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988Ab0IBUan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:30:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46268 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949Ab0IBUam convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:30:42 -0400
Received: by fxm13 with SMTP id 13so606840fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w7ah/RN3wnRPBuy53WoCeJSfPcXCMVSEuka49QwtGG4=;
        b=pr42gNqbyKhfKpJwQJrgGbNduTwWja47pAj9yiZKA6Ert/6tPSfL1sChDBI2xbju2u
         mOXvtPjMoRTaVjRcI0t0MiQzIhzEvXiV6REMuJPV0EZ1nAiGgfaMYr8AslPPpjfW/tJq
         +zMBiwSPqbrzkkq+cfHFFGqns+VKkWzwwPWqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=i+SU976nVC1s0Ew1oAwZr00pp4lQ0UH5jN1oLh0rPJPA5lUyDPiVbXJpohya/t7jfK
         0wLD+VrtKD+LidUstOanrXuuvLNBcnKIzcExspDJb7ZiXQU1Cl3FCGOaBfGHIr1um6nO
         alOMWROPvixlrZfATJVG41FMy/O64iQG87s2A=
Received: by 10.223.115.207 with SMTP id j15mr6550052faq.105.1283459440347;
        Thu, 02 Sep 2010 13:30:40 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j14sm470521faa.47.2010.09.02.13.30.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 13:30:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283456446-22577-25-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155197>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The only change is the removal of two messages that didn't really
> belong: _("#\t") and _("%-20s%s\n").

Hmm, isn't it better to let translators tweak the output format to fit
their constraints?  Especially 20 characters might not be enough to
hold the "deleted by them" et al messages in some language.
