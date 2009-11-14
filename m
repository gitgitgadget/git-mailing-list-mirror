From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Sat, 14 Nov 2009 18:01:23 +0900
Message-ID: <20091114180123.6117@nanako3.lavabit.com>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
	<1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
	<20091114071946.6117@nanako3.lavabit.com>
	<4AFDE421.5050307@fastmail.fm>
	<20091114081040.6117@nanako3.lavabit.com>
	<4AFE41AF.8050802@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Sat Nov 14 10:02:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9EWq-0006Ol-Q3
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 10:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbZKNJB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 04:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbZKNJB1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 04:01:27 -0500
Received: from karen.lavabit.com ([72.249.41.33]:40328 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470AbZKNJB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 04:01:26 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 9304F11B8B8;
	Sat, 14 Nov 2009 03:01:30 -0600 (CST)
Received: from 6995.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id QP8G7PK2F9SE; Sat, 14 Nov 2009 03:01:30 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ohsTTR/VBya4C/mHo7o/jaNVfJnKEYMWFrBmygtULhlU3F0xicRoEBeIOV7OAy+QJx1gQhYvAPp0EPm81BVO0mN1aHqPL66U2SjnxLaXH3sB0qIG7E9JZs0iYwF+S5cQpZ6N/+IKLQ46DvrrapL2Z93GCVPBwD9oeHAMHGObFeU=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4AFE41AF.8050802@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132864>

Quoting Raman Gupta <rocketraman@fastmail.fm>

> Ok, another dumb question: since you have now submitted a patch on top
> of my patch, what is the proper etiquette for proceeding? Who
> maintains this patch series until it is committed? Since your patch
> applies on top of mine I can't really make any more changes without
> affecting your patch right? I can't find any guidance in the
> SubmittingPatches document.

What usually happens is that we wait now.

In this case we are in agreement that it is a good idea to apply 
both of our patches (mine was only repeating what Junio said in 
his comments), so if I were you, I would anticipate that Junio 
would apply both of them and start preparing incremental updates 
on top of them now, and send them when the patches appear in his 
'pu' branch.

Junio has gone quiet for the past few days; maybe he is too busy
to read or respond to either of our patch. Instead of preparing 
the final text you write in the document in a patch format, it 
may be a better to bring up your ideas here and discuss them 
first. What changes do you have in mind? I think the new section 
now already is in a reasonable shape.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
