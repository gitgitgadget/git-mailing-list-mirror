From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: First round of UGFWIINI results
Date: Wed, 11 Mar 2009 03:27:05 -0700 (PDT)
Message-ID: <m3wsawgxto.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 11:28:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhLg0-0005x3-FU
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 11:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZCKK1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 06:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbZCKK1L
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 06:27:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:34971 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbZCKK1K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 06:27:10 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2686336rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=udAUdED1l11DF6Xpm/ZN/PvEWVLV23jRfjuhOAljt2k=;
        b=wyvKTSYkCU0mlUvbfeWeaXNyl+iQy2BCd6CcpTcXY5mmLoZWjUwX/DyR1+CBnnlSQh
         29gYIHfqm1MNr3wHxpAEb9u/oOzLtE6XtTLJU1SpCSNnTeoQHy5ZgCW586zEo2f7tLvz
         NPNecEg3mjtQlOJmNevLJ0VAwTgY48xPX3bcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mdvL5qfIK86nJRvEMT0BLOZrul2841h0atFniZXW/knyHjkbEu8wvHIU7n6O5BU0Wl
         SNgqsP7ijICEnC2cqKFOw7c996i12/hM1ouwgY0wQsZzq4a1eyWWdfUX+umhV8CznlBR
         +zCddiA7hiM3a2sUONlwxZDl5clJL5wEoYbyQ=
Received: by 10.141.50.11 with SMTP id c11mr4314955rvk.28.1236767227698;
        Wed, 11 Mar 2009 03:27:07 -0700 (PDT)
Received: from localhost.localdomain (abwo62.neoplus.adsl.tpnet.pl [83.8.238.62])
        by mx.google.com with ESMTPS id f42sm12626186rvb.3.2009.03.11.03.27.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Mar 2009 03:27:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2BAQSHF005339;
	Wed, 11 Mar 2009 11:26:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2BAQCJU005335;
	Wed, 11 Mar 2009 11:26:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112905>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Dear fans of Git,
> 
> a while ago I announced the UGFWIINI contest, a glorious battle of ideas
> how to
> 
> 	Use Git For What It Is Not Indended

[...]
> Number 2:
> 
> At the GitTogether, Sam Vilain presented his idea to use Git as a DB backend:
> 
> 	http://utsl.gen.nz/talks/git-db
> 
> Just think about it: committing by "INSERT INTO"!

And something very similar: "Using Git as a versioned data store
in Python" by John Wiegley (similar to 'shelve' which uses database)

  http://www.newartisans.com/2008/05/using-git-as-a-versioned-data-store-in-python.html
  http://github.com/jwiegley/git-issues/

And similar solution for Ruby

  http://github.com/georgi/git_store

by the way of GitHub Blog: 

  http://github.com/blog/374-git-as-a-data-store-in-python-and-ruby


P.S. When there would be next round of UGFWIINI contest?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
