From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Sat, 4 Feb 2012 14:12:18 -0600
Message-ID: <20120204201218.GF22928@burratino>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
 <1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 21:12:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtlyc-0006D3-NH
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 21:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2BDUMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 15:12:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62696 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2BDUMq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 15:12:46 -0500
Received: by iacb35 with SMTP id b35so6446440iac.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5jSicIYJgKsLtPErHy6wEVc92SlHwO4MhwtRUeosExE=;
        b=jNvsZxgOUmP9BUXrPLpRLeY8x4jWp/4kVzZIPu/Wpwp7D2yM/YPgc3bcgeW8g7tkc0
         PsDH7Pyt9v5FogG8SYk3ixdNpzu6VAc94OggNaWvNn8tqtKq4jdOqTaC/LpLlfrcueR6
         345JnIyyMm76xLkGTM7oVYW43g8lXb8U/DKUg=
Received: by 10.43.51.66 with SMTP id vh2mr11322671icb.39.1328386365819;
        Sat, 04 Feb 2012 12:12:45 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f26sm7741196ibc.9.2012.02.04.12.12.44
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 12:12:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189905>

Felipe Contreras wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Similar comments to the last patch apply here.  This time the patch
is even more mysterious, since it seems to touch a number of test
assertions, even while I assume not all of them relate to whatever
this is supposed to check for.
