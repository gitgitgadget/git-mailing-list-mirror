From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 11:50:32 -0700
Message-ID: <20130325185032.GB1414@google.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <7v38vjz7sx.fsf@alter.siamese.dyndns.org>
 <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
 <20130325182023.GA1414@google.com>
 <CALkWK0kx_uQy-97nByNXBOU4UruhvdjOeXCpKHR9mNUQHs5o=A@mail.gmail.com>
 <7vppynxre7.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOHPrid3V5tPWBaf5eh1t7tM_oXqsQFnXugBKUGKGpUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:51:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKCU6-0006BF-HV
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933074Ab3CYSuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:50:40 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:36938 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920Ab3CYSui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:50:38 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so3361187dak.16
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dbxAUE0hw6ModPtr1nAbIeWZKBpbJhnTSPgw790CSyk=;
        b=hIAb5S/pOcupuBrbuDeQPgbXbfO1bkZwwW1cW1f5AYXAfwwnOAIZxLdrz3F5SDAQY6
         oODdoipN98FmShI0VTdrBQxRC6l+fiIhkNiK8H7xEXvfGtWklpVwT+w2GmBj1tHuGH8+
         eYobvG+sHvcxCOgGmzfTLWjV7YwQDooABBWyDHpKR0fqt/WWrAFb1p9v3yxZ04I3eKi+
         W0e0m3ZW6g01cuS7m315UPDEzLLxYKY/w1e4H4y+IvF7ALsxYV29aWU0/Xkqrcr6umLn
         GlvI4OSDrLtrn4rCsyvXtDcda8W897uz3bvEFyEltBcPApUHdPDx9mPHEWTIpTVILMm3
         fgPw==
X-Received: by 10.66.252.101 with SMTP id zr5mr12365911pac.130.1364237437823;
        Mon, 25 Mar 2013 11:50:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id fc8sm15795987pad.21.2013.03.25.11.50.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 11:50:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kOHPrid3V5tPWBaf5eh1t7tM_oXqsQFnXugBKUGKGpUA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219065>

Ramkumar Ramachandra wrote:

> Okay, I'm confused: why are you waiting for 2.0 to change push.default
> then?  Isn't that just a "slightly better default at the porcelain
> level" and hence a "regular enhancement"?

No.  Among other aspects, "git push" is used heavily by scripts.
