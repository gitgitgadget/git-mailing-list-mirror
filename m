From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 02:02:58 -0400
Message-ID: <9e4733910606092302h646ff554p107564417183e350@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
	 <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
	 <Pine.LNX.4.64.0606092043460.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606092109380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 08:03:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FowYq-0005ne-Bv
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 08:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWFJGDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 02:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWFJGDA
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 02:03:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:43745 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030290AbWFJGC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 02:02:59 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1255404nze
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 23:02:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DKmMGRWwLN8d3BrC20EZIfFXWwWNAukIA5xx6+iYkJEKBWwwrfzzb2MnfnVydC4MLZnRrt34icMI7MkBPlxjmfpKezneTTxEmzvD5T+OjybxE/2dnSr7xOcCyCSVk2No73iHprG5oC8g7XEhRpWw3qEE3MTilhqSF3rk2HUgdJw=
Received: by 10.37.15.20 with SMTP id s20mr3777732nzi;
        Fri, 09 Jun 2006 23:02:58 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 9 Jun 2006 23:02:58 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606092109380.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21598>

Here's a new transport problem. When using git-clone to fetch Martin's
tree it kept failing for me at dreamhost. I had a parallel fetch
running on my local machine which has a much slower net connection. It
finally finished and I am watching the end phase where it prints all
of the 'walk' messages. The git-http-fetch process has jumped up to
800MB in size after being 2MB during the download. dreamhost has a
500MB process size limit so that is why my fetches kept failing there.

-- 
Jon Smirl
jonsmirl@gmail.com
