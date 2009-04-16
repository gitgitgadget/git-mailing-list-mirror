From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: integrating make and git
Date: Thu, 16 Apr 2009 22:50:39 +1000
Message-ID: <fcaeb9bf0904160550u1a2911eai7e51ed92e6f6aa31@mail.gmail.com>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com> 
	<alpine.LNX.1.00.0904151148030.19665@iabervon.org> <3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com> 
	<200904151930.32816.robin.rosenberg.lists@dewire.com> <20090416082615.GA27365@coredump.intra.peff.net> 
	<vpq63h42a9y.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	E R <pc88mxer@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Apr 16 14:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuR50-00050J-Ml
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 14:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbZDPMuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 08:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbZDPMuz
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 08:50:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:4028 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbZDPMuz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 08:50:55 -0400
Received: by wf-out-1314.google.com with SMTP id 29so379697wff.4
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6fjE5ZxsYM51fXd2achb7lOmrwW1iLO/NZJ8yij0cDU=;
        b=hEZs1JtcdePeDn79EGzKVgnziKqqplmsmgys4pwU3SGTIo6rDv4Z8Qa5X0J43ng8xC
         c3Z/oUwqHvfremmQ7r8rWGsZTetxham8NRzJgjccoiwnuzIaRrsp0DVMGVX7T0zmJhMu
         92qcT2sQHII2PDrzWlRwogyBkF0IAwsMi0txI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TzhVpOz5kHMRrWAJeWMrPNuWU/HWcnKkICggKPJMFhsl1AR2ShAm32RWFn1X/INOAm
         DXV874nBtkvvfD7RY8IoR+SoOESlbi6n1p7Io+7Y+kL+s/8cyIGfWENITiyrBv3a9umY
         DRKgL11v4GEaxe0LEDuSvQmHf3HJmEAWc1dbc=
Received: by 10.142.230.11 with SMTP id c11mr2099905wfh.305.1239886254102; 
	Thu, 16 Apr 2009 05:50:54 -0700 (PDT)
In-Reply-To: <vpq63h42a9y.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116696>

On Thu, Apr 16, 2009 at 7:55 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Jeff King <peff@peff.net> writes:
>
>> But one could probably design a system to replace both ccache and make
>> that relies on git's fast sha-1 reporting to avoid duplicate work. I
>> suspect nobody has bothered because make+ccache is "fast enough" that
>> the added complexity would not be worth it.
>
> AIUI, ClearCase does something similar to that. Call that an immense
> bloatware where everything has to come together, or a nice integration
> of different tools, I never used it, so I don't know (I heard the
> first option more than the second ...).

It does help on really big projects (complete rebuild may take one
day, complete recollect built objects and link them with clearmake
take about one hour). C++-based projects may like it due to long time
compilation.
-- 
Duy
