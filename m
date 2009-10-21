From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git push: say that --tag can't be used with --all or --mirror in help text
Date: Thu, 22 Oct 2009 06:21:35 +0900
Message-ID: <20091022062135.6117@nanako3.lavabit.com>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
	<4ADB4AE8.5070007@hartwork.org>
	<20091018235240.GU6115@genesis.frugalware.org>
	<20091019115412.6117@nanako3.lavabit.com>
	<7vpr8kcc00.fsf@alter.siamese.dyndns.org>
	<20091019125701.6117@nanako3.lavabit.com>
	<20091021144203.GA30485@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Pipping <webmaster@hartwork.org>,
	git@vger.kernel.org, Bjorn Gustavsson <bgustavsson@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:21:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ict-0000zz-Ks
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbZJUVVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbZJUVVh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:21:37 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36344 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657AbZJUVVg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 17:21:36 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 4F4B911B8B9;
	Wed, 21 Oct 2009 16:21:39 -0500 (CDT)
Received: from 9509.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id YV9UXFXGTJ8R; Wed, 21 Oct 2009 16:21:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=yAybJQDoYrnD8BrZUScpgo/krzc0URUTH1O/f3EsvCVIxRKyo1Z/QWobal7ETCp/Dai7S86Fk5Jw62tlVf+FeHyzXKj/bnOZGlSM9je+KKb9lfRx+542ai/3hhileNGoAie2YwaEVII7e5JNO3zAFjFjH/AZ7L6Ybp0zuXsc9Q4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091021144203.GA30485@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130964>

Quoting Jeff King <peff@peff.net>

> On Mon, Oct 19, 2009 at 12:57:01PM +0900, Nanako Shiraishi wrote:
>
>> -		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
>> +		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all nor --mirror"),
>
> Hmm. We apparently all managed to miss this typo. It's visually hard to
> notice because of the ")" closing the macro.

How embarrassing. Thank you for a fix.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
