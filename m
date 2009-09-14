From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 13:56:29 +0200
Message-ID: <40aa078e0909140456l47cfce92yc44262c96b59bf2d@mail.gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
	 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
	 <20090914105750.GB9216@sigill.intra.peff.net>
	 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 13:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnAAe-0004vu-F7
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 13:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbZINL42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 07:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbZINL41
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 07:56:27 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43519 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZINL41 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 07:56:27 -0400
Received: by bwz19 with SMTP id 19so2015880bwz.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zo4bdYnW2rK9crytEAEMXuyTLPSOR+wn3+HyxbIi1+E=;
        b=cuczD1KQPaVk1gkzltTju0WeWcjvdf6eDxBHdJdwaHAUaLYxNV2Ubuif0JdyLAIqis
         j9DqX9TtHeTYJ1K+QZiA/LwnMpW/TGGHN9O1DU6Cl3E1Tw/D55FYTe326QlppAdGJOLO
         S9GbCVg7nz4P28aBtNQj6Ne+VS/NwLFb2aO5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KIfmiKUtqqSWtQQTx1o/hZU36V/oj2FCDfkyMIXZp4scaTvoIDpN0ptL6+QZpgAof4
         SeIxUkOjh/gEBZXkuc6btqDxhmJuQUtlAm3SIcNZVMO5bTPeqcKydCDDbF32hIMsgEV3
         IkZhZ8UBvFhLpo4Spqwzuxxu3vFjiYwcOeJvc=
Received: by 10.204.162.204 with SMTP id w12mr4959847bkx.18.1252929389544; 
	Mon, 14 Sep 2009 04:56:29 -0700 (PDT)
In-Reply-To: <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128449>

On Mon, Sep 14, 2009 at 1:40 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Mon, Sep 14, 2009 at 12:57 PM, Jeff King <peff@peff.net> wrote:
>>
>> I didn't see a patch 1/2, so maybe it impacts this in some way, but by
>> itself, I don't think this patch is a good idea. See below.
>
> That's odd. It's listed in my git-folder on GMail as sent to the
> mailing-list, but I can't find it in any of the list-archives. They
> were both sent through the same instance of "git send-email". I guess
> I'll just re-send it.

OK, I think I figured out why: For some reason, the From-field of the
mail had gotten changed from kus...e@gmail.com to
kus...e@googlemail.com, and that's not the address I'm subsribed to
this list as. I hope whoever manages the list is able to remove my
duplicates from the moderation-queue or something ;)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
