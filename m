From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] More readable 'Not a git repository' messages
Date: Tue, 10 Aug 2010 21:31:12 +1000
Message-ID: <AANLkTimeizUKBrwibUTnVPZWwU_M72uQTn8ucmjK_V70@mail.gmail.com>
References: <i3pdkj$hut$1@dough.gmane.org>
	<AANLkTinttmKi4+EbE54r-GeRbN3_2wxUHu_qJMn5Nysn@mail.gmail.com>
	<i3q0d8$m8f$1@dough.gmane.org>
	<20100809230132.GG4429@burratino>
	<i3q3ah$upb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ralf Ebert <info@ralfebert.de>
X-From: git-owner@vger.kernel.org Tue Aug 10 13:31:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oin38-0002bN-WC
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 13:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab0HJLbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 07:31:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38183 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0HJLbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 07:31:13 -0400
Received: by wwj40 with SMTP id 40so12741236wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=PE14JdXrMgas4aTas7oirHhCw0GcLLsHj3hj93bSTTA=;
        b=h8rAiM7Hrk4R7k6mrAKw9ANPsCXKlbMEq78xTQGbr6AaBR68pgajAr0L4LlcfxeLks
         +Ik8+fwZFsr0CVTLWqjFTBiJIbe1JCdb8seK2vj8SUbnFQP7mEFN0EQuzowRjDQ2Co4U
         kppKntVH03B4byfo33LsTAX50+/UjjD0/jwDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XQPdhtRY91+4XeFNQLTDlYUEmLQsefpmKt6rfcdLOBetTe5401moME2D2Ur2ZmXtiM
         lPKJxiCchHIXOP5rtwSKvHqnO79GWIbDEN5ZgkYpKqtf2NVQFXNX826ipJZYfGUm5PIR
         JhQCAdYQ9kZaobByNesvzgY23dCMaLPoleuUE=
Received: by 10.216.21.7 with SMTP id q7mr3830920weq.19.1281439872382; Tue, 10
 Aug 2010 04:31:12 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Tue, 10 Aug 2010 04:31:12 -0700 (PDT)
In-Reply-To: <i3q3ah$upb$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153093>

On Tue, Aug 10, 2010 at 9:34 AM, Ralf Ebert <info@ralfebert.de> wrote:
> I do, I guess it makes sense to rework the patch on top of that.

While you're working on that, I was thinking that cwd may be long as
it's absolute path. How about rephrase the error message a little bit
and give more space for cwd? Something like

Not a git repository: <reason explained>
Stopped at <current cwd>
-- 
Duy
