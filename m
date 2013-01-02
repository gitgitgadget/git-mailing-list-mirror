From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 2 Jan 2013 07:39:33 -0800
Message-ID: <20130102153933.GA30813@elie.Belkin>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com>
 <20130102080247.GA20002@elie.Belkin>
 <20130102105919.GA14391@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 16:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqQQF-0004EN-LC
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 16:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab3ABPjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 10:39:45 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60624 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3ABPjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 10:39:44 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7947695pbc.33
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9z6NsAbbDfnXSNyfMAYZPtsVUoobADmb5EJu5Wpe9Hs=;
        b=RqYweAleoMJdQBpb85/erp2UdjBxNKrdUufyOVxavaSa6fR4V02yDFzC8bYsiiIqzf
         qPCy4iH7rv31tJ9gq6OE2lYGAp+v0b755T+Zn+bSDJznOiO8G00xEYGQfdWfTQKt/05X
         n/pwVoRDmPdb0IkpizCm8kt0WB8VwnQNKRfVE9RBLjoMVeJjUyAaJtQgwxGZQMzjeMgl
         qNQnwF2nF+ILMCkMbUcDdgQFYOkItOKi16ygyptCRn/Jd7vc/NJutCfNR+A0m7HzXEZ8
         A34t9jP+SbTMy8zH4d0uKxohCYw+/ADhN+qh/4jP1eKJfd+SDQ72p4B3LR1zM49m0/rb
         bTeA==
X-Received: by 10.68.232.101 with SMTP id tn5mr145709326pbc.125.1357141183679;
        Wed, 02 Jan 2013 07:39:43 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id d8sm29497829pax.23.2013.01.02.07.39.41
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 07:39:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130102105919.GA14391@thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212516>

Eric S. Raymond wrote:
> Jonathan Nieder <jrnieder@gmail.com>:

>> Speaking with my Debian packager hat on: the updated cvsps is not
>> available in Debian.  "git cvsimport" is, and it has users that report
>> bugs from time to time.  With this change, I would either have to take
>> on responsibility for maintenance of the cvsps package (not going to
>> happen) or drop "git cvsimport".  That's a serious regression.
>
> How does going from "it silently damages imports" to "it fails with
> an error message" constitute a regression?

The former is already loudly advertised in the package description and
manpage, at least lets you get work done, and works fine for simple
repositories with linear history.

Taking away a command that people have been using in everyday work is
pretty much a textbook example of a regression, no?

Hope that helps,
Jonathan
