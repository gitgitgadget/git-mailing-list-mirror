From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Get correct column with for options in command usage
Date: Tue, 5 Feb 2013 19:18:20 +0700
Message-ID: <CACsJy8Ci05C1mKDGp_YzP0H6G0Y40K8MUUq+D6NzjtPGRNms0g@mail.gmail.com>
References: <0b035132df6de2cac56ac59d66b04f30e90ad760.1360049671.git.worldhello.net@gmail.com>
 <20130205121552.GA16601@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 13:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2hUY-0002PR-JL
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 13:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3BEMSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 07:18:51 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:38127 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab3BEMSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 07:18:50 -0500
Received: by mail-ob0-f182.google.com with SMTP id va7so62628obc.27
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 04:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iO7W+reztX6dKzXOs/K42b6MawkVHYLSdZ5bj5G4D1k=;
        b=ReyUJ+XKKiA9gxzpG9/u3A9zIYMb38TtjKc1+2iMpVABbpLvuva4+dxgUAV4wbIHJQ
         OAvPCJO/RPIfh4F/LqsXfYDeQ42rDrg96GBEqy2AtHZF5Kfnk2TJSVYNicyvNMgjWHnT
         TlB/HUDh2/05tR2Rvk3iXjuj0mv1HepgvE4jCmtWMy/ZjD1TAFr0IKQMWGZ15Ksvm9mI
         3Gq9pbKAhu4jR1iObuL2U8pEszmFMrq3sMTz2agnoc7frSbuVPqLrETEIvln1eXyXcBO
         1ZyAI0Gi8duuEr+4CB2qDK/MSTEmIqr8EAh94AUYy+lv4DOBlb/cjxAHKWK8dQotVQDG
         jyMA==
X-Received: by 10.182.183.2 with SMTP id ei2mr17688719obc.84.1360066730086;
 Tue, 05 Feb 2013 04:18:50 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 5 Feb 2013 04:18:20 -0800 (PST)
In-Reply-To: <20130205121552.GA16601@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215497>

On Tue, Feb 5, 2013 at 7:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> +       fprintf(outfile, sb.buf);

Use fputs instead. I looked up fputs man page but somehow still left
fprintf there.
-- 
Duy
