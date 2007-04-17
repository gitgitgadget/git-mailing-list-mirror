From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Tue, 17 Apr 2007 22:51:18 +0100
Message-ID: <200704172251.20831.andyparkins@gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <200704162155.25114.andyparkins@gmail.com> <7v8xcqofru.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 23:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdvaS-0008TK-TN
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031258AbXDQVvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031257AbXDQVvh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:51:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23802 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031258AbXDQVvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:51:36 -0400
Received: by ug-out-1314.google.com with SMTP id 44so278675uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 14:51:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CZrM9h5XnwuvJn5tobu0F7StkPUmhwYMR8msvNcgEdq2PZ7ESFvXJ+FfE09FsmyOXJ/oRJfTcFjQegX3UzruY4VOtQXTd8XHhrlNhk70UnFuH1noJlyMDZIXOoWJeeaFE0pwjM4JMjKNgu0uFV4CB1XA//7M0pR/jqBqAxhrWNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kplv0m6SE8dP03e1FfJhAHucy1cVDg6vI0pZjmanrBd8Xd6n4LyOM2k8oi+2uFCzPbi+RnioOzsjuo++oTCflCgPM6saiUTE3YJlRu5TJu3mX0IlMNlRTwmFlmLYDbEh65iWRzpDH130dihz1H3JlRuC5QEzp6lD753AZSnGrso=
Received: by 10.67.116.18 with SMTP id t18mr569004ugm.1176846694958;
        Tue, 17 Apr 2007 14:51:34 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id y7sm1797445ugc.2007.04.17.14.51.32;
        Tue, 17 Apr 2007 14:51:33 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v8xcqofru.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44833>

On Tuesday 2007, April 17, Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> > However, it's missing the point to take my example as an unsolved
> > problem - there are plenty of ways I can get what I want; I brought
> > it up merely as a counter to the statement that there were no valid
> > situations for wanting keyword expansion.
>
> That's actually quite different from what you said.

Sorry; I didn't express it very well - the thing that started all this 
was the statement that there was no valid use case for keywords.  I 
just gave an example.  I felt that the thread was moving away from 
keywords and towards solving my particular problem - which is all 
appreciated, but wasn't the point.  Running makefile recipes or extra 
scripts are all valid methods and pragmatic 
working-with-what-git-does-now solutions.  I wanted to distinguish 
between what I could do now and what I could do with keyword support.

> You were claiming that with built-in keyword expansion what you
> want becomes /simpler/.  I questioned that.

Well it does from the point of view of pressing "print".

> Maybe it's just me, who is not a GUI person [*1*], but to me,
> having to start inkscape, mouse around to find the "Print"
> button and print feels much more cumbersome than simply typing
> "make print".

Again, that was addressing my particular problem - good stuff.  However, 
it's just luck that inkscape has a batch mode - there's no guarantee 
for that.

I could just swap the example around a bit, what about if it was an 
OpenOffice document that I want to have transparent 
compression/decompression and I've set the properties tag to 
contain "$Id$".  There is no amount of scripting that will enable batch 
printing of that.

Anyway - I've wasted enough of your time with this foolishness now.  
It's dropped, consider me silenced on this subject ;-)



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
