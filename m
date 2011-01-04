From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: make logo optional
Date: Tue, 4 Jan 2011 10:29:18 -0600
Message-ID: <20110104162918.GA30141@burratino>
References: <20110104050206.GA8280@burratino>
 <20110104050555.GC8280@burratino>
 <201101041252.40254.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 17:29:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa9lV-00046O-5b
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 17:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab1ADQ3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 11:29:36 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63106 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab1ADQ3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 11:29:35 -0500
Received: by fxm20 with SMTP id 20so14220047fxm.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 08:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WOTp4DzQY/zIyzoR+7Xgv2elLM0002zcKUHoEbDXeIs=;
        b=piWtM3HGOLL/wo01OJC+42AMYBM8gFtdiV7por9LowheDRyLrfN9DjsWwDh7uAbjdI
         4NSyz/VKWsf4+ax5kZq8NEuFG8N7C1sBFKW9enEiien3kY8lEADq3XaK20yCRAUVh92+
         v+fXbwp60aCdnwev2F6gJyGMZBK5tIq3aco1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fO1Zr/W0F+Fx1eOyP3qlfyLm0G6JoHcresZfXPHOpiJfH+wzpKv01Xmxh33E9yyrJL
         Bj5lLmNYFV5wBaecU63kAokPMkVoWfB5tlm/ZWgXGG7y2qGogDK2NWx84wXHTBZctwaF
         PxPClnJJt3zdtmFL4XaUoUwt458cscB834Egw=
Received: by 10.223.96.200 with SMTP id i8mr1753416fan.76.1294158573974;
        Tue, 04 Jan 2011 08:29:33 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id n1sm5153869fam.16.2011.01.04.08.29.31
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 08:29:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201101041252.40254.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164500>

Jakub Narebski wrote:
> On Tue, 4 Dec 2011, Jonathan Nieder wrote:

>> Some sites may not want to have a logo at all.  In particular, git
>> instaweb can benefit from this.
>
> Why do you think that git-instaweb can benefit from not having logo?
> You need gitweb.css anyway, so it is not much more trouble to serve
> additional static file, git-logo.png.

Yep, that sentence is stale (it only applied in 1.7.1.x days) and
should have been removed.

> corelist (Module::CoreList) says that Perl 5.8.0 has CGI.pm version 2.81;
> IIRC gitweb requires something later than 5.8.0 for good support of
> Unicode (Encode module).
>
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> For what it is worth it:
>
> Acked-by: Jakub Narebski <jnareb@gmail.com>

Thanks for looking it over.
