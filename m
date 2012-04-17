From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 02:36:53 -0500
Message-ID: <20120417073653.GB20017@burratino>
References: <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
 <20120416200941.GD12613@burratino>
 <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
 <20120416203320.GF12613@burratino>
 <7v7gxftn78.fsf@alter.siamese.dyndns.org>
 <CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
 <20120416224411.GU12613@burratino>
 <CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
 <20120416231626.GW12613@burratino>
 <CAMP44s3OSepH_XpCcTWLN=bF0+P9fmHtyPnWdQnEocW25jHTpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 09:37:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK2yG-0005Lk-2h
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 09:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab2DQHg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 03:36:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55797 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab2DQHg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 03:36:58 -0400
Received: by ghrr11 with SMTP id r11so2895152ghr.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 00:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=o7HStTHefhSbFEfGp3Fje3FXmqC0ptB4G+C42ojLAkE=;
        b=rYnP+yYYChBs1dpgMpT369jtVRQ2UvFc2iRKpWMHQMFFxs45wOSIXUTaUzc8Nj8ePH
         tNsCe5kTN3Mp0xXHM++HkiNVLHtdel7QO4bAh6kISbFRm9xNiyAaQJ1jpnWd7lFTZMuq
         zGPtrtx/qZyjqbE5WYdV7Y9ePTUhaIV4NhZIv8twk6rx+lxhw1YwcMD4sFdZT0hr5H2C
         nTCLhZVYAYqTjCdqEIhokx2dH1+/KYgK5B2KAoxIYz2j+s5ods8Wa63idfdlH9qhlbQH
         z8gSc1f4jAgJtOl64u1vXX1TpyTqzs1lOgFApKXfEjTB8/C/zMAF3JSpmYxlUG6ZhvA1
         8cFQ==
Received: by 10.50.189.200 with SMTP id gk8mr8152304igc.8.1334648217279;
        Tue, 17 Apr 2012 00:36:57 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gf4sm14359945igb.14.2012.04.17.00.36.55
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 00:36:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3OSepH_XpCcTWLN=bF0+P9fmHtyPnWdQnEocW25jHTpA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195737>

Felipe Contreras wrote:

> You are the one who brought the argument that even public functions
> have the '_' prefix, so it's *your* responsibility to substantiate
> that argument.

No, honestly it isn't my responsibility to waste time arguing with
you.  What kind of crazy world would work that way?

And I did not mean to bring up any argument.  I only meant to bring up
the _datum_ that, at least in the context of the bash_completion
project, that is the current convention.  And then you started trying
to tell me that I had the facts wrong!  You might even be right, but
you haven't shown any sign of trying to check that, by, say, asking
someone from the bash_completion project what convention they use.

I'm sick of this.  Call it whatever you want.  I don't know why you
think this is productive.

Still annoyed,
Jonathan
