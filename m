From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Mon, 4 Jun 2007 20:03:59 +0100
Message-ID: <200706042004.01819.andyparkins@gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com> <200706041309.54279.andyparkins@gmail.com> <e5bfff550706040915v3689e8afwb3dffd5d4caf137a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Pavel Roskin" <proski@gnu.org>, "Jan Hudec" <bulb@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 20:05:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvGvz-0004ff-7a
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 20:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758537AbXFDSFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 14:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759981AbXFDSFg
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 14:05:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:18881 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759972AbXFDSFe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 14:05:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so831175ugf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 11:05:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OoAABbNAGGJWnm+9ROX7xCKHxx0ToLcQPRPPANOHICkCnVSlwRndFmB1BhCLtsdqr8+QB9PWGbImCa+YeXpBmBdP69jxU6/gRTFwrrY6Qe8d23zLE21vXIDkRF6NlkC99FcvzV2VvDKJ9/F7kb+0S1k/OhC2Jaq1/D7LeeCQvF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WgH3uuQurfvXDVA9mq5j9D6q693y2pgktcsepkbqmLCX6eCj5vKzLN2vsiI+0TlHqY+DaU2oiiNrG8fIUf9zu3VtLpqFSQz377dPOAHg08OK0A0V+9k5MyKaLPk2tp7SqK7WCsh3cbSrvVbW/A4uVLUCnn9s4zhQkzlXEHbO77I=
Received: by 10.66.243.2 with SMTP id q2mr3282038ugh.1180980331497;
        Mon, 04 Jun 2007 11:05:31 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id k28sm824137ugd.2007.06.04.11.05.30;
        Mon, 04 Jun 2007 11:05:30 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706040915v3689e8afwb3dffd5d4caf137a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49122>

On Monday 2007, June 04, Marco Costalba wrote:

>   I have to say that I really like your idea!

Hurrah!  See - even a blind golfer knocks one in eventually :-)

> Probably I will create a new branch called andy_gui where I'll
> implement your idea, while continue to refine the current approach.

Great stuff.  If I get a moment, I'll try and chip in with some patches.

> As example one enanchment I would like to implement is to keep the
> labels normally hidden and show the top (bottom) one only when user
> scrolls to the top (bottom) boundary of the view so that we could
> resolve two issues: knowing when a scrolling action will cause a
> switch (i.e. only when the corresponding label is visible) and do not
> have the arrows when not needed.

That's certainly an improvement.  I think in many cases both labels will 
be visible - especially in log mode - because most log messages fit 
completely inside one window.

> P.S: Your approach is simple and good, the only downside is the
> screen estate taken by the tab bar. But I agree it's absolutly not a
> biggie.

Yeah, that is a bit of a drawback.  How about not putting the tabs on 
the top or bottom, but on the left or right?  In fact if you put them 
on the right, they'd be almost exactly where your jump labels would be.

Maybe this is only better for me, but I tend to have more left-to-right 
real estate available in the lower half of the screen, primarily 
because the log messages tend to be limited to 80 columns, but the 
revision list contains the ever-widening graph.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
