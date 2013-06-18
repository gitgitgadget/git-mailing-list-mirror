From: Alexander Nestorov <alexandernst@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 16:39:05 +0200
Message-ID: <CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <vpqsj0fr19j.fsf@anie.imag.fr> <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
 <vpq7ghrqzrv.fsf@anie.imag.fr> <CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
 <vpqppvjpjz3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:40:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uox4Y-0007sF-Dw
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab3FROjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:39:46 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:52438 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab3FROjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:39:45 -0400
Received: by mail-qe0-f45.google.com with SMTP id w7so2493594qeb.18
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LtHUAnBf621LbKTRH54+s5N+UhSy66m2ovh7ID+zOck=;
        b=ENKpb0nPdxdMCYHVaNxhfBKjiiEigha0jYty8R6o4Ts6igb8+/tLZdcVInZ7p/QmnQ
         5aUFFl/+c6i3L5LE9xkDaftj8GgGM+OtKaS+VZC5O+Woq9vcGdpTLL17gCXNpm2wtwKk
         3RqEMXjv5AW/yehOLs5ybnBSLkdjdsaKkgYNEguBwV7IY2U61zpj2jsBCv2pPlPHYTgZ
         +Wg1Stppq7pqhTMaWhbSMTlvxQBeCdqVYS8FkpfwH0adDEefhcSI/7ds+uM/5lpsq8Hj
         FLiQjSTj4Ao8RmkkyeH8HVVAVzTAj/yTDMJP7n3L+Jc9vNgN+r7pCFXQ7vtlSBOTUJ1A
         2xaw==
X-Received: by 10.224.13.19 with SMTP id z19mr23512023qaz.12.1371566385143;
 Tue, 18 Jun 2013 07:39:45 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Tue, 18 Jun 2013 07:39:05 -0700 (PDT)
In-Reply-To: <vpqppvjpjz3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228243>

Sorry for not keeping everyone Cced, I wasn't aware of the rules.

Yes, writing about that in the docs seems more reasonable than patching reset,
as as you said, that'd just run update-index before the reset.
Let me get at home and I'll try to push a change :)

Regards
