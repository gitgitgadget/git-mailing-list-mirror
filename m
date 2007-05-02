From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: FAQ Q: another version control system?
Date: Wed, 2 May 2007 10:25:21 +0100
Message-ID: <200705021025.22626.andyparkins@gmail.com>
References: <9e7886190705020012n72070874nae5a74b6d1387e3@mail.gmail.com> <9e7886190705020013k5721480aj767c1c8643fc8d23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Peter <petervanbohning@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 11:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjB5r-0007Lr-0G
	for gcvg-git@gmane.org; Wed, 02 May 2007 11:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992923AbXEBJZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 05:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992943AbXEBJZs
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 05:25:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:21129 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992923AbXEBJZr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 05:25:47 -0400
Received: by wx-out-0506.google.com with SMTP id h31so62228wxd
        for <git@vger.kernel.org>; Wed, 02 May 2007 02:25:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=efhDlLaHSFAvjnmCtgkdWdiZDaRMbqbxFNzHBaNJV4T8XVfx591n9WWb+3tso/eKAcIpzbrKbMTVBzlouFzNaJfmGri3ClusFqolk/1xY3rIUaa3PsSVmzFiXBRgFlYWXlx4zZOPJmNJzzr6/JhROeFQeAT6hfaSQc28k/Ir54Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XJI+aYSKpBljLCUWztjD/IejcgLin0+Ho6oQxuMyEL2knJkk2y/Gm8RyUk16Le+bgf5Wz41I9V3LQG6yCyqzLoSOtsvJ9iR2IpqRFX48t5utBqVwNAHHwZi4O73sAf8xw8OKL/u04WPzErohoNt9mdFS8Y17g5BZBZi4lSGzolc=
Received: by 10.82.189.6 with SMTP id m6mr996367buf.1178097942070;
        Wed, 02 May 2007 02:25:42 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y37sm2002926iky.2007.05.02.02.25.32;
        Wed, 02 May 2007 02:25:38 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <9e7886190705020013k5721480aj767c1c8643fc8d23@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46007>

On Wednesday 2007 May 02, Peter wrote:

I suspect you are a troll as your questions have such obvious answers that 
they hardly seem worth giving.  Despite that, I'll answer them for the sake 
of the googlers who stumble on your message.

> Do we really need another version control system?  As I understand it,
> this is like a distributed, central-server-less, CVS, sorry, SVN
> server.

Why didn't the subversion guys just add their features to CVS?  The subversion 
guys are not stupid people - why haven't they added these features to 
subversion?  The answer is that they fundamentally don't fit.  Distributed 
version control is not just something you patch in later as a feature - it is 
designed in from the beginning.  Have a look at the monstrosity that is svk 
(distributed version control with a subversion backend).

> But why isn't such a feature set added into SVN?  Why do I have to
> download another version control system just so that I can "git"
> libxcb and X11 so that I can compile gtk so that I can compile xchat
> so that I can go onto the IRC server for madwifi so that I can ask
> someone there why their wifi drivers don't create a /dev/wifi0 on my
> system so that I can get my wireless working????

Given that git is converting a lot of subversion/CVS users - including the 
projects you list above, do you not think that they might have had a reason 
for doing so?  Don't ask git developers why they wrote git - go and ask those 
projects why they are using it.

Practically, I think you're overstating the difficulty of "downloading another 
version control system".  On debian/ubuntu you would do:

 $ sudo apt-get install git-core

If you really did want to compile these things, then you would do:

 $ cd src
 $ git clone git://anongit.freedesktop.org/git/xorg/xserver.git
 $ git clone git://anongit.freedesktop.org/git/xcb.git
 ... etc ...

But are you seriously suggesting that you need to compile the latest and 
greatest X11/xcb/gtk/xchat just to chat on IRC?  Why not just do

 $ sudo apt-get install xchat

If your distribution doesn't supply an apt-get equivalent then you must have 
picked one where you compile everything from source by hand - in which case - 
what are you moaning about - you did this to yourself?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
