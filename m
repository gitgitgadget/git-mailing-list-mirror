From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv4 1/3] gitweb: add patch view
Date: Sun, 7 Dec 2008 10:52:38 +0100
Message-ID: <cb7bb73a0812070152j3c7ecc51r9f19523cfef44d39@mail.gmail.com>
References: <20081207060430.GE4357@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt Kraai" <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 10:54:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9GKs-0007Tq-Mg
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 10:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbYLGJwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 04:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbYLGJwl
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 04:52:41 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:50842 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbYLGJwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 04:52:41 -0500
Received: by ey-out-2122.google.com with SMTP id 6so271082eyi.37
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 01:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ry8vC3xrmg6J7kgGlpkHP+/GvdkylY0Xj6naZJk8XHY=;
        b=S6/QiUv+CA/owV57QOOSAadxaUDQlMdvhIumztmW5DRDXL1DoroKjrP9JISfGJb5Ds
         cYlCx61WalhrC4yzCctCvgnr32oq3I7Fn6Ddz8TcBg0KnJcoDkTjjhI+E7/jnJNHTGAl
         apkQixwna/KP8YnfhJsaOlz7yqOSsPfcpM2SY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VkZNO2FLOiO1xlF3WGaDVMLXQL8DZWOC/8klAFf3RTc1g2uwtTxf8bU31vJBpWuAHS
         v2/DPQiCecDVKYajASHji3vXyabKNyGG4lWddcwc//p/t8XDxzdYi+DHgceqOuDzuHL7
         RHNtnnhXjSu0/aX9fbzeWw2WAKKdT7hC1s9wo=
Received: by 10.210.79.14 with SMTP id c14mr2156198ebb.194.1228643558744;
        Sun, 07 Dec 2008 01:52:38 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sun, 7 Dec 2008 01:52:38 -0800 (PST)
In-Reply-To: <20081207060430.GE4357@ftbfs.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102493>

On Sun, Dec 7, 2008 at 7:04 AM, Matt Kraai <kraai@ftbfs.org> wrote:
> Howdy,
>
> Why do you check $patch_max at the start of git_commitdiff instead of
> at the start of hunk which opens git-format-patch?  It seems like it
> would be clearer to check it later, at some small loss of efficiency.

Subsequent patches use the check to add a link to the nav bar, so it
reduces code shift from patch to patch 8-)

-- 
Giuseppe "Oblomov" Bilotta
