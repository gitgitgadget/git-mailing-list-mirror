From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] completion: add common options for blame
Date: Mon, 3 Jun 2013 15:02:00 +0530
Message-ID: <CALkWK0kR2fCQcO9XurzjOGF19vaC67p5kMpkJL=Vbu1Ovku18w@mail.gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-4-git-send-email-artagnon@gmail.com> <87mwr7zhv5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 03 11:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjR89-0006xC-SS
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 11:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab3FCJcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 05:32:42 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62974 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab3FCJcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 05:32:41 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so9713256ieb.20
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VjjqV/68KFc7/34huX6OYkc7+UGttrc/vCPIMqvxOO4=;
        b=yV8FLOJDNfQgZHy6+r5f6cijpnmdkSCf2miqW3MYy4XR6XEDyy4Ijhfs8Kfd7A1XOw
         bC2CgBSa8ulO1a5lK8CYvokwQFrBl+6rwv0BUzCpwOLyzFmlQmousqM6/jUw+GY7TuN1
         mw7MAiGAnnSVrj+wscU9oR+J4kJIUfUhLfnP3uag7erIAlmuYeIaYnt4rrBjtRwaS1Jg
         DYxfoBjNLZpcOEtyfpBoZfR2eFabMcY8qWakwBM0xaoaHVAon+QeWKDhYDwPMQf9rqDb
         MHyKydkUnd6EzaFzQeDMWE00SAoixSoDs8E3fqU3SbebvMfxXrbJC/zcnbeaTecEskPT
         r/1A==
X-Received: by 10.50.141.230 with SMTP id rr6mr7464927igb.89.1370251961033;
 Mon, 03 Jun 2013 02:32:41 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Mon, 3 Jun 2013 02:32:00 -0700 (PDT)
In-Reply-To: <87mwr7zhv5.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226208>

Thomas Rast wrote:
> Is this the first time we introduce completion (I guess you could call
> it "help") for short options?  I only did a quick search for /-. -/ but
> it certainly seems that way.

Yeah.  We generally prefer the long-form equivalents while doing
completions, but these blame options do not have equivalent
long-forms.
