From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: git send-email: How to modify subject prefix?
Date: Fri, 24 Apr 2009 19:28:55 +0400
Message-ID: <85647ef50904240828i76cf5f0en14a9fd2dc496a89d@mail.gmail.com>
References: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
	 <b4087cc50904240820r567020d7gaa7cecaa0f3b78fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 17:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNMF-0004G6-Se
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbZDXP25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbZDXP25
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:28:57 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60740 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZDXP24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:28:56 -0400
Received: by fxm2 with SMTP id 2so1165469fxm.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=CgsMDMuVbbhKF/4jqkAmNAUlXHzz/g08n2+oXwO94iQ=;
        b=HzurEMoFrnpIEwB9j4rzH4wi1Olb9gpkf75a5l7DIHioJ1HqJpWFscF/3+hbtY8z5S
         EtbFm5okdccH6wU3IDF2tKLOwlg2x30TY3wAx3yhxR/KsrfoOzLanrrGiqAr2hvKaotj
         Ac22FvOxgQReMC9hmki8rDZ8QlPLmV6IP69L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=mJyZSQxUkqrtF/dne+g4Q4s36svlAdUa+DBddfVmZjNQSTLMI2I8PCTpAzBdYOo3SI
         gp/f2TKqcb/iOm5qZCvZ7qMKllsKCSlKk8owP1GTWEQaRN/xmkE9oFBqPrguPtMHQyTU
         TL55Gg9dXCiHKlpU9sgKSDEttzyoP8wT+LThI=
Received: by 10.204.76.129 with SMTP id c1mr2194455bkk.9.1240586935589; Fri, 
	24 Apr 2009 08:28:55 -0700 (PDT)
In-Reply-To: <b4087cc50904240820r567020d7gaa7cecaa0f3b78fa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117456>

This option works. Thank you.

BTW why this option is not in the man page? Is it discouraged for use?

On Fri, Apr 24, 2009 at 7:20 PM, Michael Witten <mfwitten@gmail.com> wrote:
> On Fri, Apr 24, 2009 at 10:18, Constantine Plotnikov
> <constantine.plotnikov@gmail.com> wrote:
>> I'm interested how to modify subject prefix when sending patches using
>> git send-email. I want it to prefix the subject with [JGIT PATCH]
>> instead of [PATCH] and I have not found any option that allows it.
>
> The option is format-patch's --subject-prefix
>
