From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What's in git.git (Aug 2009, #01; Wed, 05)
Date: Fri, 07 Aug 2009 12:33:46 +0900
Message-ID: <20090807123346.6117@nanako3.lavabit.com>
References: <7vd479x6hx.fsf@alter.siamese.dyndns.org>
	<MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:34:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZGED-0007G2-MS
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 05:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbZHGDel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 23:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbZHGDel
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 23:34:41 -0400
Received: from karen.lavabit.com ([72.249.41.33]:34766 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbZHGDel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 23:34:41 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id A1F1511B867;
	Thu,  6 Aug 2009 22:34:41 -0500 (CDT)
Received: from 7759.lavabit.com (190-14-246-42.ip.mediacommerce.com.co [190.14.246.42])
	by lavabit.com with ESMTP id W9X2V4G44ZEQ; Thu, 06 Aug 2009 22:34:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=fTCpMktiq62kcYXQ9GSrRdy1WbYzdZTVXe89FPOHfh1qLkn3PSjO5OyFZAmgApbDqq9PqmVz1AS9aUz/6o/KMvWgrL4LmsySskD3eVqzMdorCVQBSVmKhqZa6YLgSGbWxmfGIyqTN2cRXpszKIlpgRLaSGuC29ljlynDnyCXWR8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125169>

Quoting Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>

> Junio C Hamano wrote:
>> The 1.6.4 release seems to have been quite solid, and there is no
>> brown-paper-bag bugfixes on 'maint' yet ;-).
>
> Found one.
>
> I didn't realize the whole git-am discussion did _not_ result in a
> fix being applied.  But git-am will currently refuse to apply any
> patch from email that does not have "From " or "From: " in the first
> three lines of the email.  For those of us whose mail servers prepend
> many lines of the form:
>
> Received: from XXX ([XXX]) by XXX with Microsoft SMTPSVC(6.0.3790.2825);
> 	 Tue, 14 Jul 2009 07:24:06 -0500

According to an already hashed out discussion, that isn't a mbox format that has been supported, so it isn't even a bug. For details, see e.g.

    http://thread.gmane.org/gmane.comp.version-control.git/123338/focus=123355

And Nicolas Sebrecht has been working with Junio to implement an enhancement to add support for the "individual piece of email" format.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
