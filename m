From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 6 Jan 2013 01:29:33 -0500
Organization: PD Inc
Message-ID: <BB541ECCD3F04E479F06CA491DDB598D@black>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 07:33:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjnb-0001m5-OK
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074Ab3AFGdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 01:33:13 -0500
Received: from projects.pdinc.us ([67.90.184.26]:48701 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751017Ab3AFGdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:33:12 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r066WtPH012916
	for <git@vger.kernel.org>; Sun, 6 Jan 2013 01:32:55 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1890551.8jTmplCF6O@thunderbird>
Thread-Index: Ac3r1dgdqlGMWLSfTF69aocuXxNQswAAOR5g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212777>

> -----Original Message-----
> From: Stephen & Linda Smith 
> Sent: Sunday, January 06, 2013 1:21
> 
> > Was it the commit before
> > 9fca6cffc05321445b59c91e8f8d308f41588b53 that compiles or was it 
> > 9fca6cffc05321445b59c91e8f8d308f41588b53 that compiled? I 
> am doing a 
> > cygwin update presently to look at it.
> 
> Since the email earlier today, I had blown away the 
> directory.   I just now 
> did the following
> 
> git clone https://github.com/git/git.git git-src && cd 
> git-src && make all
> ...   The make errored out as before
> 

No error for me.

> git co 9fca6c && make all
> ...   The make errored out as before

No error for me.

> 
> git co 9fca6c^  && make all
> ... and this compiles to completion
> 
> CYGWIN_NT-5.1 WINXPMACHINE 1.7.14(0.260/5/3) 2012-04-24 17:22 
> i686 Cygwin

This is old, do you have the luxury of updating it?

> 
> What else can I do to test this out (I will get a current 
> cygwin tomorrow to use in a test).

I would also check to see if your devel packages are up to date too.


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
