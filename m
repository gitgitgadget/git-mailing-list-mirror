From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [NON-PATCH 3/2] Documentation/git-merge: format full commands
 in typewriter font
Date: Thu, 7 Jan 2010 14:25:13 -0600
Message-ID: <20100107202513.GA4573@progeny.tock>
References: <2e53c91e536e1ff585bc7464c1b8863e6cc45c45.1262883414.git.trast@student.ethz.ch>
 <ebbb4e2b0e98490a64b3cd52c33d3a995fa7e980.1262883414.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 07 21:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSyv6-00029D-Uu
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 21:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab0AGUZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 15:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230Ab0AGUZU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 15:25:20 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:58326 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0AGUZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 15:25:19 -0500
Received: by gxk3 with SMTP id 3so7955602gxk.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 12:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nZNNG6DW6A2ecveDIc5On6AQj4LLeREfittCLV80RHE=;
        b=TaGnNGDiniEDcbvIV4E/PBqRjBzBLVzCJATocYmiX+ElVZJ55H/7JugpBm55wznOZR
         1GC5++W6hpDUSL/SGhAq9wm9ANby6f81CogKIASlJBJPUXZyBCXe0jZC8lmZtxXeahE0
         H6hdVK9M1TeJ9/gfLprxWSROA7v/PcVZD0SBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KM/pXRaJdZKI8hWei46SwDiEa3NN3ijrAs8qRmIUNv+GoCXVJOOqmDOm2kUZyoOlFJ
         BpSF7BybQODH1b8QxZEyj8SbeJn9FHCA4y9UD90PPOkpbRiyghrJRbJ9tz9ZU/si82+V
         tN2xcfx7K+5fqsWQGvkDqEq2oPu2YXZgyV9/U=
Received: by 10.100.192.18 with SMTP id p18mr8847972anf.32.1262895917302;
        Thu, 07 Jan 2010 12:25:17 -0800 (PST)
Received: from progeny.tock (wireless-239-25.uchicago.edu [128.135.239.25])
        by mx.google.com with ESMTPS id 22sm20735050iwn.4.2010.01.07.12.25.16
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 12:25:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ebbb4e2b0e98490a64b3cd52c33d3a995fa7e980.1262883414.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136384>

Thomas Rast wrote:

> * More importantly, while `code` style seems to be an improvement in
>   HTML output (because it gives typewriter font), my local 'man'
>   renders 'emphasis' as underlines -- which actually makes the code
>   snippets much more visible than `literal` quotes which are not
>   rendered specially at all.

Maybe some point in the asciidoc/docbook-xsl/nroff chain could be
convinced to render `literal` quotes underlined on the console.

Jonathan
