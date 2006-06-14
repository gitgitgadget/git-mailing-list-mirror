From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: oprofile on svn import
Date: Wed, 14 Jun 2006 15:32:58 +1200
Message-ID: <46a038f90606132032o7ebfb688u81500d78f4240162@mail.gmail.com>
References: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 05:33:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqM8O-0000ha-DJ
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 05:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWFNDc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 23:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWFNDc7
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 23:32:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:62703 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751091AbWFNDc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 23:32:59 -0400
Received: by wr-out-0506.google.com with SMTP id i31so29182wra
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 20:32:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oqf9+g/z8/tw7/QTqvSJ8xcJ3+46yDv7dNs5Xk9eyR+hSQtU0QkrGKoUrqNCSSyt8UKPocYy/BjvriCyhMlFFW3dTRoxcQI/Di+wUCO8HLk7bb9Hx2hpfDWdxsEGjRQ381dnkIIFzNvx1V7UEhYh4Zje+GWe8A/Eq39Jfj/RBQ8=
Received: by 10.54.124.15 with SMTP id w15mr239396wrc;
        Tue, 13 Jun 2006 20:32:58 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Tue, 13 Jun 2006 20:32:58 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21826>

On 6/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> I'm going back to cvsimport tomorrow. My svn import that had been

For best results, make sure you remove the -a from the git-repack
line. Once it's done, run git-repack -a -d manually.

cheers,


martin
