From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC - draft] List of proposed future changes that are backward incompatible
Date: Mon, 16 Feb 2009 00:38:23 +0100
Message-ID: <200902160038.24838.jnareb@gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <m3fxifticm.fsf@localhost.localdomain> <alpine.DEB.1.00.0902160009010.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 00:39:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqaZ-0000FY-CH
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbZBOXi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbZBOXi2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:38:28 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:63536 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbZBOXi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:38:27 -0500
Received: by fxm13 with SMTP id 13so5227181fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 15:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=t62lJuT4lLfHPdg4NSB2qefqKAEou3WeusGFCU1x6PE=;
        b=GRoE4W+gwo0XxKZ++2PhlIBd518fMsb6i9fPTeKtPmHyQtdGeglv+AGCkTr50Ak2wW
         YXrjTzXO7EPXK7p7wW0Drruhc57qR4HMSQeKFqpKRLpO0bl+TK2a4F3zTNSPmGy0vKwQ
         06yYtR9WLiDi4FY6lTfvYQgB5dK4NzSjobBi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=S1+pWGsTK8yXryswMCS/5lJ5WvouvcBAzhjG2L86Tl9d96hXh0mYHIdoBxAnB1mZne
         tfigiYMhTVlo8t43Pagr3Z6ICmDRIj50/AYqoCrT8ueNrn0nWgjWi7H+yGWJFOmpkjAf
         ASanQA1Q2TTcsZvJZQIOv78RN4d6mEu7sOrC8=
Received: by 10.103.131.18 with SMTP id i18mr2516179mun.74.1234741105761;
        Sun, 15 Feb 2009 15:38:25 -0800 (PST)
Received: from ?192.168.1.13? (abwt47.neoplus.adsl.tpnet.pl [83.8.243.47])
        by mx.google.com with ESMTPS id y2sm4139205mug.15.2009.02.15.15.38.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 15:38:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0902160009010.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110090>

Hello!

On Mon, 16 Feb 2009, Johannes Schindelin wrote:
> On Sun, 15 Feb 2009, Jakub Narebski wrote:
>> david@lang.hm writes:
>> 
>>> one thing that would help new users is if there was a way to create a 
>>> git config file that explicitly listed all the defaults. either as a 
>>> sample config, or to expand the existing config file with all the 
>>> defaults listed, but commented out.
>>> 
>>> I find that having such a config file helps me find config options I
>>> never thought to look for.
>> 
>> That is a very good idea... if next to impossible now, I think, as
>> there is (I guess) no single place that stores default values.  But
>> perhaps I am mistaken.
> 
> Of course, you have to ignore the fact that it would no longer possible to 
> update defaults for existing repositories.
> 
> For example, setting something like receive.denyCurrentBranch to a saner 
> default would not reach existing repositories.

You missed that it would be a _sample_ config (or commented out sample
config), and not the default config installed when creating repository.

But...

> 
> And you would also have to ignore the fact that sometimes, config 
> variables are deprecated, and this _also_ would not reach existing 
> repositories.  Of course, the same holds true if you set such a config 
> variable manually, but then you are _supposed_ to know the config 
> variable, and you are unlikely to learn the name of an obsolete variable.
> 
> Do keep in mind, too, that most of the variables are next to useless 
> without the proper documentation.  And do you really want to replicate 
> Documentation/config.txt in the config file?  If not, how do you want to 
> make sure that the two different documentations do not go out of sync?
> 
> Further, it would be much, much harder to see what is _actually_ set.
> 
> Summary: I do not like that idea.

... perhaps an alternate solution: add switch to git-config or git-var
which would list (only list, no description) all defaults.  Hmmm?

-- 
Jakub Narebski
Poland
