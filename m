From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 15 Oct 2009 18:52:53 +0900
Message-ID: <20091015185253.6117@nanako3.lavabit.com>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
	<7v63ah85ss.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 11:56:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyN3t-0006wy-3G
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 11:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbZJOJxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 05:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756718AbZJOJxy
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 05:53:54 -0400
Received: from karen.lavabit.com ([72.249.41.33]:46435 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756241AbZJOJxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 05:53:53 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 6ABED11B955;
	Thu, 15 Oct 2009 04:53:17 -0500 (CDT)
Received: from 6277.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id ZNCNMSCWS6N9; Thu, 15 Oct 2009 04:53:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=icogZIw0kF1kB91RDoMeqBBWk2aZuo0fvxKEP1pABzTBzPvB+5BKZnwOfsDALgGcZFk/7yLw8Nv9VL4TeKE5X8vdFaX2Ym+kKB1oH0eHOC6ayj9QjKocDQnSUOPHEWi/0au+F1azruWvNmJQIkSULtrJx5S4t/BmpVZGHKoc9M0=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v63ah85ss.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130384>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> This v3 series is a respin, and includes fixes to address reviewer
>> comments from v2.
>
> Thanks.

Junio, you merged this series to your "pu" branch, but it breaks "make test" (t9801). Shawn's "sp/smart-http" topic doesn't have t9801 and passes all the tests.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
