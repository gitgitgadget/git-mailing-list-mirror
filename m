From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 2 Aug 2007 16:56:48 -0400
Message-ID: <fcaeb9bf0708021356v57b29a70yb69a2fa000bd5b55@mail.gmail.com>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	 <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:56:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhj3-0003RX-MG
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbXHBU4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754333AbXHBU4u
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:56:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:13877 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbXHBU4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:56:49 -0400
Received: by wr-out-0506.google.com with SMTP id 36so256001wra
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 13:56:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I1BBvCZZKuM1AqKzcVziCwjmifXjAAIWqljEiRIkPuMaYNG76pDIS2/5iTyCSqkbLdI9+G/+DHgMyxjM6jR6rE3ThEoZgp95sjCa00+/1F+zoFDnLIw5qbmbUvQGXDmQwcfhPX0VqwN6C8jOWgNYNPDIa2BZQWTNpJxCBMTyFh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HR2Typ+UHdfKljGtNuxl0CMDkl6/F8BoeaK/BKKuYcLnVja+xEDT/6QgFtidsIK/Mtxmxz2bDwmLuklnUTxNsdfthGlQt2z6ybPDH8oAI/OjmxvuEmNDGpb/OF58OG0a2+k/YrG3KeXIor5/zF6qWjVdxsKIBr/64+seJk0zrwE=
Received: by 10.100.111.16 with SMTP id j16mr1355133anc.1186088208649;
        Thu, 02 Aug 2007 13:56:48 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Thu, 2 Aug 2007 13:56:48 -0700 (PDT)
In-Reply-To: <7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54608>

On 8/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> Non POSIX substitions such as ${parameter/pattern/string} and
> ${parameter:offset} are not to be used.  We do not want to
> depend on bash.

There is in a test (t5300-pack-objects.sh) but I guess the
restrictions do not apply on tests.
-- 
Duy
