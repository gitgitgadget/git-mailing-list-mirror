From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in
 an ignored directory
Date: Wed, 18 Aug 2010 19:00:52 -0500
Message-ID: <20100819000052.GA11081@burratino>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
 <1282123788-24055-1-git-send-email-gdb@mit.edu>
 <AANLkTi=UJmXx0-fV6OqDTOzuTdQQWioUb=3vrVx01qi6@mail.gmail.com>
 <vpqk4noc9ro.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Greg Brockman <gdb@mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 19 02:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olsaq-0002nN-4V
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 02:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab0HSACk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 20:02:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45806 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab0HSACj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 20:02:39 -0400
Received: by yxg6 with SMTP id 6so430962yxg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Or0K3h+JOwbB98ZBhBYw5A9VC2clCl3W9UstnyAEKWU=;
        b=MzP/Z3+cm3uyfB95vf5imPic0d5ysxTHRDA+bFOU4DXPbzbi5x6DxV02Fwi5qR1661
         lbZzDV/znVW0u0bJ/AgqRfk9e6YLptsUgzrlbSttaRN56+Uyr5ZYdobriufLd/oGnCgK
         mwvTanVdl18SN8wyEbESNSPv4uq7Ae72u8wcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bp3T7XklxAyNmJCAL96S/T9B360vOUpFrIP+Ukgp09MCwBpXVK9LGYGDgB8hwYKUmo
         09f4xEV6K7iiVw9j8773eb0XF+7hF66ts01JDPH8ipTiuMpyBlGlgx7G8PGlZ+z8HVsS
         /5AQKLbXyZ6hcSWNmepA/RKeZ+ZZmqusAOCVo=
Received: by 10.150.56.21 with SMTP id e21mr1260578yba.141.1282176158324;
        Wed, 18 Aug 2010 17:02:38 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id q31sm1868843ybk.1.2010.08.18.17.02.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 17:02:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqk4noc9ro.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153899>

Matthieu Moy wrote:

> Not sure what is the gain by doing so, and the vast majority of tests
> already there use the style of Greg's patch ...

Right.  The usual rule when contributing to an existing project is
"imitate the surruounding code", but there is often a tension between
global style guidelines and the local conventions.

In this case I have to agree with Matthieu: the test script is
easier to read if it follows a single, consistent style.  The cleanup
can happen another day.
