From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Fri, 4 Jun 2010 00:20:01 +0530
Message-ID: <AANLkTilnEtoZmi0GDmaUBk6cVLyLx8JhhEmldqFuhySM@mail.gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
	<201006031755.29814.jnareb@gmail.com>
	<AANLkTimoA95U0vivTzrc0XZ8i6q-SfCFA6RgMWK67OWl@mail.gmail.com>
	<201006032043.14071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 20:50:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKFUY-0002kG-R7
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 20:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab0FCSuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 14:50:04 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48435 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab0FCSuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 14:50:03 -0400
Received: by yxl31 with SMTP id 31so198903yxl.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=/GCgjl8VNWQdMrtVLBV9tL8bdwM2U0Gyy372NIp8gOc=;
        b=YC61jVXy5RIKUxB95DWW75mZHy8LHwglSLvb/7jhwD9XHah1EZCEWZNpO2eBeRDNOC
         ytcX2hNR82ffwiyYRAEtPwnDymRkbhjPWCbzuozdMdHQDOYAD2+Hk8s/HJwkTujtb4/p
         PtFOImBaHuS/cp/aovd+7TlVTVfelaGrq0124=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Mfv0svB8j2jO/kKYbB3IqmgwHr85kJ0e82ZbCGLGqAVM5GiHInoZlbyal7mvViY2mo
         Sv7aKZW9itGBgiKcwU0TOrYGThLD2623vt4O2HVrYtdLmksrhLu2ncVeXz0mZhbXU8RR
         trRb4y3nvltEJ/7ePm6EbUiIHLRMeYnBUxrwM=
Received: by 10.101.195.8 with SMTP id x8mr11135626anp.186.1275591001709; Thu, 
	03 Jun 2010 11:50:01 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Thu, 3 Jun 2010 11:50:01 -0700 (PDT)
In-Reply-To: <201006032043.14071.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148353>

On Fri, Jun 4, 2010 at 12:13 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Pavan Kumar Sunkara wrote:
>>
>> Even though it increases the patch size, I don't think it will be much
>> of a concern when it comes to good redability of code.
>>
>> Jakub: Can you reply, what you think about this argument ?
>
> But I agree that first, 'our $var' seems to imply that it is _new_
> variable declared in current scope, and second if we make a typo in
> variable name it wouldn't be detected as different from exported
> variable: 'our' will create new variable.

And it's hard to detect the typo while debugging.

> So I agree that removing 'our' is a good idea, especially together
> with putting all variables that should be there in Gitweb::Config
> together with comments, even if they are configured during build
> process.
>
> Perhaps those declarations in Gitweb::Config should have in-line
> comment that they are defined in gitweb.cgi / gitweb.perl?
>

Yeah, Sure.

Thanks,
Pavan.
