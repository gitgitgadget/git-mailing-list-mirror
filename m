From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 07:09:18 -0700 (PDT)
Message-ID: <20060927140918.65775.qmail@web51004.mail.yahoo.com>
References: <7vodt2nmft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 16:10:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSa6F-0003GZ-Gt
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 16:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWI0OJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 10:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWI0OJU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 10:09:20 -0400
Received: from web51004.mail.yahoo.com ([206.190.38.135]:13470 "HELO
	web51004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932259AbWI0OJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 10:09:20 -0400
Received: (qmail 65777 invoked by uid 60001); 27 Sep 2006 14:09:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IN6hiQ4IcM//RnBnsdJf8Kwo7/S2ezPWWd9pVYGqD9hipQKVBGYmDfHRr8DCUaGqC7zYUQeDS8jAqEGYdUNCOEZIJsBUNr7EB7YT5vOvJ5cZZ7sVDWGwv9Y5wG1CaJxAa+n/h9kOTWvm++GV7JH5075cyd4w9VXr4TLXpOP/2hw=  ;
Received: from [207.172.80.85] by web51004.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 07:09:18 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodt2nmft.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27905>


> Each commit object in git records two timestamps.  When the
> author made that change, and when the change was made into a
> commit object in _some_ repository. 

Perhaps git should record three(+) timestamps, adding when the change was committed into this
repository? Last weekend there was a committ in Linus' kernel tree with a timestamp ~2 days into
the future, which could be a problem in a scenario involving when an important bug fix was
merged/published in Linus' kernel tree, situations like that should be impossible. How can git be
said to keep an accurate record of history if time is uncertain?

-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
