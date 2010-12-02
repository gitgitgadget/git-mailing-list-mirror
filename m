From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7.3 1/4 (bugfix)] gitweb: Prepare for splitting gitweb
Date: Thu, 2 Dec 2010 20:01:31 +0100
Message-ID: <201012022001.31739.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <201012021117.16183.jnareb@gmail.com> <7vtyiwrs8e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:01:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POEPc-00085I-5f
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802Ab0LBTBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:01:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48982 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757569Ab0LBTBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:01:43 -0500
Received: by bwz15 with SMTP id 15so7550834bwz.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Xiag5/VcTUAIa2O/QMMvsd0bpAF/HnzUiF82q7Za5Os=;
        b=wRPm3EgWRsnJc6IJ46Ys8+XT/LEzvDAgRKqVGIgxjUylwW0O+rJR1X9u+1AZOrLzip
         2lnV7U6Aoruk+U9njhcDpZSG+7GxtG94VuyBlBQyyeScc+k1pIHIO44VHCQzzc2nMAvL
         q4OTAbrU1BF5UsisW6T0UY3M9Nnp9oQS9P+7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=d3V+F9Jlu7xaNKJXnMuusL+uuReIbzURMTFj+LHog4YY6H1Oq+hnxTRQOw8YTIketw
         aq2CZYbCEgkY7fSs065k98TkIN77FqJAfLezYJ4/n062YnEKuaAtwZUpOHRmpt4/N0rI
         mmMSXJk58hO9H0DMfEgxCoYieYZfATazQ4Q1U=
Received: by 10.204.98.15 with SMTP id o15mr1278826bkn.136.1291316501403;
        Thu, 02 Dec 2010 11:01:41 -0800 (PST)
Received: from [192.168.1.13] (abwq166.neoplus.adsl.tpnet.pl [83.8.240.166])
        by mx.google.com with ESMTPS id f12sm261891bkf.16.2010.12.02.11.01.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 11:01:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtyiwrs8e.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162732>

On Thu, 2 Dec 2010, Junio C Hamano wrote:

> Hmm, how did you find the issue, and more importantly, how did I or other
> people who saw this patch so easily fail to notice it?

When working on my total rewrite of J.H. gitweb caching series, available
as 'gitweb/cache-kernel-pu' branch in git://repo.or.cz/git/jnareb-git.git
and git://github.com/jnareb/git.git repositories I finally did a *clean*
reinstal (i.e. remove whole directory, then run "make install-gitweb").
This branch uses the same "gitweb: Prepare for splitting gitweb" patch
(cherry-picked back and forth).
 
> FWIW, I do run "make install" from the toplevel as part of my pre-push
> test, so I _should_ have noticed it.
> 
> Ah, I don't run the install step for a revision that does not pass its
> selftest, so I haven't run "make install" on 'pu' for some time.  That may
> explain it.

Hmmm... I thought that "make install" doesn't install gitweb, but it does
with "$(MAKE) -C gitweb install"... though I am not sure if "make all"
builds gitweb (runs "make gitweb").
 
> Anyway thanks for a fixup.
> 

Sorry for the bug.

-- 
Jakub Narebski
Poland
