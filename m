From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Thu, 9 Jun 2011 11:09:00 +0200
Message-ID: <201106091109.01168.jnareb@gmail.com>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net> <201106081141.26994.jnareb@gmail.com> <20110609033817.GB6167@leaf>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 11:09:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUbEt-0003Jy-3d
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 11:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab1FIJJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 05:09:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34787 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab1FIJJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 05:09:12 -0400
Received: by fxm17 with SMTP id 17so839867fxm.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=C9AZkeMJEp/t5sOCXwc6b9sjdNw05fNEy2JmhfsAZGE=;
        b=XXB4JncgUEB+pQ6RmhR/tsQ2c77hjtibrhp4VYqKWoJYUsKW4tJlJWqDe3Z5IU7gkH
         dWLT2dqtUu9ZXvHlJs6oPEssqM1v1MajYef5iKoOijLqX9zZ389rqsbz/BybYRIkiSpv
         3V7RWlpqoj68LgUqne7mEj02Ums2U10VQSxt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fkwJ8z4711Dben1iDueWeBf08tz8L+na+cp5rIQ3O/e3n8HkhDZ7jFfbXeuREjexEP
         Y/L6B7soUEwEWxto8OvSMu6o6BdUVwEi3qhfwMNWplscQGTF/deBwPDrzDpZ30tNbvBr
         A5FVqSKEf2R0pJRYJzNcqGGEnndaknSw43sXE=
Received: by 10.223.21.140 with SMTP id j12mr511827fab.47.1307610550905;
        Thu, 09 Jun 2011 02:09:10 -0700 (PDT)
Received: from [192.168.1.15] (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id b26sm553587fak.24.2011.06.09.02.09.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 02:09:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110609033817.GB6167@leaf>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175509>

On Thu, 9 Jun 2011, Josh Triplett wrote:
> On Wed, Jun 08, 2011 at 11:41:25AM +0200, Jakub Narebski wrote:

> > BTW. what do you think about treating repository with own refs and with
                                                     ^^^^^^^^^^^^^
> > namespaces similarly to how "forks" are handled in gitweb now?
> 
> Different namespaces won't necessarily represent forks of the same
> repository; they may represent entirely separate repositories, with the
> use of namespaces merely a server-side implementation detail to save
> space.  I'd suggest presenting them as separate repositories.

What I wanted to say that if repository with namespaces has its own
not namespaced refs, then (sub)namespaces are probably forks, and
"forks"-like behavior would be a good idea.

If namespaced repository serves only to save space, then it wouldn't
have its own refs, only namespaced ones.  Then we would list them
as separate repositories.

-- 
Jakub Narebski
Poland
