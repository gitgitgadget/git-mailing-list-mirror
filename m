From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Wed, 16 Jan 2008 22:46:21 +0100
Message-ID: <200801162246.21854.kumbayo84@arcor.de>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <200801162158.26450.kumbayo84@arcor.de> <m3y7aplbie.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>,
	Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 22:55:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFGEO-0006xc-1W
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 22:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbYAPVy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 16:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYAPVy5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 16:54:57 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:34657 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752834AbYAPVy4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 16:54:56 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id ACB6124B118;
	Wed, 16 Jan 2008 22:54:53 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 977A72D37E6;
	Wed, 16 Jan 2008 22:54:53 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 12CEC225122;
	Wed, 16 Jan 2008 22:54:53 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <m3y7aplbie.fsf@roke.D-201>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92/5487/Wed Jan 16 19:21:33 2008 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70751>

On Mittwoch 16 Januar 2008, Jakub Narebski wrote:
> Peter Oberndorfer <kumbayo84@arcor.de> writes:
> 
> > "git repo-config" will be removed soon
> > 
> > Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
> > ---
> > since i am not good at creating log messages, feel free to change it :-)
> > built on top of kha experimental patch
> > passes all testcases for me
> 
> > @@ -47,7 +47,7 @@ class GitConfig:
> >          if self.__cache.has_key(name):
> >              return self.__cache[name]
> >          try:
> > -            value = Run('git', 'repo-config', '--get', 
name).output_one_line()
> > +            value = Run('git', 'config', '--get', name).output_one_line()
> >          except RunException:
> >              value = self.__defaults.get(name, None)
> >          self.__cache[name] = value
> 
> Strange that StGIT didn't abstracted out reading git config, like
> Git.pm and gitweb.perl did.
> 
It is abstracted, that is why the patch only affectes stgit/config.py :-)
(beside tests)
Or do you mean another type of abstraction like loading the whole config file 
at once?
> BTW. will StGIT be using libgit-thin + PyGit, or is it not ready yet?
> 
I did not hear about it lately.
But since i do not create stgit patches very often i have to say actually i 
actually have no idea.

Greetings Peter
