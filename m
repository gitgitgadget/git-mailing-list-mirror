From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Sat, 20 Feb 2010 15:58:14 +0200
Message-ID: <94a0d4531002200558r70087153i5c43ab669458e817@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 14:58:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nipr0-0004i9-IQ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 14:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab0BTN6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 08:58:17 -0500
Received: from mail-iw0-f177.google.com ([209.85.223.177]:65031 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554Ab0BTN6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 08:58:15 -0500
Received: by iwn7 with SMTP id 7so1172758iwn.4
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 05:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=DiqMF2Ir2c0C9wALF7HIE/sepR4v3IiAjvK8HYrrNzA=;
        b=VDaNc1yvv8w0L6jgalSq5yDoXpQM7FFD+NFRCXpW9Q1yVbo0xYVMldySqFg8kvkkgh
         wCnFgX5HdlmoMegyMS6XwpBjvKEhac7N8kJQBOSQVdLGXAD5ECR92GKyj55e8FIfRl9J
         GErRpBZX8aeVHlfNT9oeqm5lYS7R6QmnH8G/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nghW5VDRjz93ohBVkpcw1eDhDNpKJ0IuRSF85HZuVIMTpOpjqASfeSuYy5hFRPpdwz
         sVyNWRQrFx+pgTpZ+Kse8I114ZP8+IS/L+/Oq5rn/Ovrdjc5ed9yQ531ipMzpNWxjrh0
         P6tNHd5vAb1/qqjTS/04WStxotDK3YlEZxrbQ=
Received: by 10.231.153.141 with SMTP id k13mr2392551ibw.95.1266674294590; 
	Sat, 20 Feb 2010 05:58:14 -0800 (PST)
In-Reply-To: <4B7D8358.1080108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140529>

On Thu, Feb 18, 2010 at 8:13 PM, Gabriel Filion <lelutin@gmail.com> wrote:
> Hello,
>
> I started collaborating on a script on github that tries to bring
> bidirectional integration of git with Bazaar repositories. It is the
> script originally written in ruby by Pieter de Bie and converted to a
> shell script. You can find it here:
>
> http://github.com/kfish/git-bzr
>
> There is probably much left to be done to call this script functional.
> Currently, it is possible to fetch revisions in a local branch, but I've
> had problems with pushing revisions.
>
> So, first things first: in order to make this thing see some substantial
> progress, I will surely need help from people who are well acquainted
> with git's internal plumbing, people from git-svn for their valuable
> experience with extraneous vcs integration and also with people
> acquainted with bzr's inner workings.
>
> Is there any interest from people of this mailing list to see this
> script make it to a usable state?
> If so, having some code review would be more than good. What do you
> recommend on doing: using this mailing list or putting one up that would
> be specific to the project?

I'm interested in a tool that's fast (uses git fast-import). Is that planned?

-- 
Felipe Contreras
