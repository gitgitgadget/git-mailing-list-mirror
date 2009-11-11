From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 19:42:15 +0100
Message-ID: <20091111184215.GG27518@vidovic>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 19:42:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8I9K-0000lz-HO
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 19:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474AbZKKSmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 13:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758461AbZKKSmQ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 13:42:16 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:48738 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758457AbZKKSmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 13:42:14 -0500
Received: by ey-out-2122.google.com with SMTP id 9so334526eyd.19
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=yyBN0SA0yZlhDGePTw5XZIyLj8LZvs9pC4jJTXVspEs=;
        b=pV4PnzWM+Gl+MFfxVOQzldX//04O2jjlzaSlTgZ1U65Z3EIM3XRCpT42tHgQgla1sw
         KxQKbDfOpiB5d/sqhWh1216FxUpK4l9YQ43ALy8i9CJp6PQJye03pJcJTXwbvEMObnLC
         qyBSBsjPuqlQMar8+UK8I9qM/5D0DK5qwAUKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hCafvdeTJfWvyKW0qziDk9Kg1z/dCK2nFwWG2ZJArSQSIygmjNOg63WUXPMojKVupu
         cEblCPFqJmh3lT0mnIi1klabeNFgwGTDKrc76jhLk6TnWl8EUAEY3wlC8WwX1rq9CjvZ
         xGWOt9PviVgEa4Qi2KQWlG1zkdCjCRkr0HH2s=
Received: by 10.213.99.134 with SMTP id u6mr6737726ebn.66.1257964939539;
        Wed, 11 Nov 2009 10:42:19 -0800 (PST)
Received: from @ (88-121-116-229.rev.libertysurf.net [88.121.116.229])
        by mx.google.com with ESMTPS id 7sm997261eyg.25.2009.11.11.10.42.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 10:42:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132685>

The 11/11/09, Junio C Hamano wrote:

> I'll do the full-list at the end of my git Wednesday, but here are the
> current highlights I am sending out to hear opinions from people.

A bit OT, I've noticed the following output today:

  % git clone git://repo.or.cz/girocco.git
  Initialized empty Git repository in /home/nicolas/dev/official_packages/girocco/.git/
  remote: Counting objects: 3017, done.
  g objects: 100% (994/994), done.
  remote: Total 3017 (delta 1911), reused 2988 (delta 1896)
  Receiving objects: 100% (3017/3017), 403.99 KiB | 309 KiB/s, done.
  Resolving deltas: 100% (1911/1911), done.
  %

Notice the "g " at the begining at the 3th line. This is reproducible.

  % git --version
  git version 1.6.5.2.352.g8b8744


I can provide more test or bissect it if wanted.

-- 
Nicolas Sebrecht
