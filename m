From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Mon, 16 Apr 2007 10:03:05 +0100
Message-ID: <200704161003.07679.andyparkins@gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <200704152051.35639.andyparkins@gmail.com> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 11:03:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdN7K-0001u7-16
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 11:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbXDPJDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 05:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXDPJDS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 05:03:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:19820 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbXDPJDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 05:03:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1057738uga
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 02:03:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KHEUz98hMQDkKL8s4vCutPOfG1NotY9tORRfKPP+KE9Sb8/3/zGSpFMirEWemFEfIahYTojS25VKRbUT4NaohUPMjICOBnntNHsZAfB5rE+Up3XOV7sb2PnJy4Gvv/VNVDZ6PJ1wM2OyB1XQw3oDi9lgAZ6nulN6YePbvNQMARQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Kn1wV8HFPIUXH5VV3JEN5BihYTLJNejc+IyViujGPLCeyLIX2DKaHNMXV7rJ2G1yaZug/HKhwZqA4TDCFLNasNA4yYPCOS6fGW16itZd8pQHb/LzpGC49KE1Eo92pg19rH1+XtBvFtgC3I9CHiczGtbRCwJcyUi0l6jydt4fCgI=
Received: by 10.66.255.7 with SMTP id c7mr4185525ugi.1176714195260;
        Mon, 16 Apr 2007 02:03:15 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c22sm12026191ika.2007.04.16.02.03.11;
        Mon, 16 Apr 2007 02:03:12 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44634>

On Sunday 2007 April 15 21:51, Linus Torvalds wrote:

> > Now, I print out that diagram and pin it to my wall - sometimes copies
> > of it are given to others.  I do this on a regular basis.
>
> And is there *any* reason why you don't just do that as an "export"
> option, when it's very clear that people won't send diffs that include it

Of course there is a reason - the file I edit is the SVG itself, in inkscape 
while editing that file I press "print" to get a print out.  Why on earth 
would I want to jump through hoops by closing the file I'm editing, running 
some export script to a temporary file that I don't want, then open up 
Inkscape again, check the export looks okay and then print - on what planet 
is /that/ simpler?  Worse, there is more chance that I'll lose changes once 
there are two copies of the same file floating around.  Which one am I 
editing and which one am I printing?  Have I run the script yet?  When I 
accidentally make changes to the wrong one, I've now got to merge those 
changes by hand back to the file they should have been in in the first place.

> It's not a valid use because there are many SO MUCH BETTER WAYS to get the
> same thing, that have none of the downsides of keyword expansion?

I'm sorry, but we have different definitions of SO MUCH BETTER; it is _more_ 
trouble for me the user to have to run scripts just to print the file that is 
already on my screen, than not.

> Your argument is akin to saying that "Why isn't it a valid use to replace
> the steering wheel in my car with a mouth-operated joystick under the
> passenger side seat?"

I'd actually say that that is your argument - you want me to add steps to a 
process to get the same result.  I just want the steering wheel, you want the 
steering wheel plus script that I run first to install the steering wheel and 
correctly adapt it for the current car.  In my version the process is "I 
press print"; the fact that is hard for the version control system is 
irrelevant - the whole point of tools like git is to do work for me, not the 
other way around.

> The fact that you *can* do something is not a valid argument for it being
> a valid use. You *can* do stupid things, but if you can get to the same
> end result by not doing stupid things, wouldn't you prefer that instead?

It's not an accurate analogy at all.  Your conclusion is your supposition - 
it's stupid because it's stupid.  I don't understand what the huge problems 
are - all you've done is say again that it's a problem to have keyword 
expansion.  Why?  What problem does it actually cause?

I'm not just being argumentative - I still have not understood what terrible 
evil it is that keyword expansion causes but crlf conversion does not.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
