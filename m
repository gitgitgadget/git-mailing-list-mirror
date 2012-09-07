From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: poll() emulation in git
Date: Fri, 07 Sep 2012 11:40:47 +0200
Message-ID: <5049C11F.1080700@gnu.org>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org> <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de> <50476EFD.2000500@gnu.org> <010301cd8c38$4256bb90$c70432b0$@schmitz-digital.de> <5048B3D0.2070809@gnu.org> <000e01cd8ccb$e20301b0$a6090510$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
	'Erik Faye-Lund' <kusmabite@gmail.com>, bug-gnulib@gnu.org,
	rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 11:41:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9v3g-0005Gc-LV
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 11:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760242Ab2IGJk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 05:40:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51003 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533Ab2IGJk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 05:40:56 -0400
Received: by dady13 with SMTP id y13so1696411dad.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GbURulh6lZQL5tUx3RB3ydAXi5ISj0eif9zrdVAq9K0=;
        b=Q5FcP+TBjvYYanzFAUIrdeyqXWGCXhj8KzScjC7DfWi/JwEqB8XykAk8elmEvCrHFW
         fRWSki4RP4X/qoY/0+ttvX8VtuDfTHPeHNJuV53DifSvSSbjS+WxtelL2CQbFB8apgBF
         gIZoD8ygIXameYLblhSvwgt4rjA6uhwz+/SWXEYl4lkxbwAR0sUbfDuimbWbJGnwyo6N
         NZdnwuUCgFDqIDfphrHVMGg6AoVnInU7kdY6zwoT1i6durrcBvndyWAOVxrG2xMDDn6E
         OuV+WnI7H4icIT7WAbQyDzg1b1K5wIzpjE3rqBnax4kMqX2+WUYWZAAu+JZLHfSyi1Di
         6slw==
Received: by 10.68.218.166 with SMTP id ph6mr9201641pbc.132.1347010856341;
        Fri, 07 Sep 2012 02:40:56 -0700 (PDT)
Received: from yakj.usersys.redhat.com (93-34-169-1.ip50.fastwebnet.it. [93.34.169.1])
        by mx.google.com with ESMTPS id pq7sm2838049pbb.25.2012.09.07.02.40.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2012 02:40:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <000e01cd8ccb$e20301b0$a6090510$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204954>

Il 07/09/2012 09:39, Joachim Schmitz ha scritto:
>> > I suppose it works to always handle ENOTSOCK that way, even on
>> > non-__TANDEM systems.
> Will you be fixing this in gnulib? How?

I don't have access to the system, so it's best if you post the patches
yourself to bug-gnulib and git mailing lists (separately, since the code
is cross-pollinated but forked).

Paolo
