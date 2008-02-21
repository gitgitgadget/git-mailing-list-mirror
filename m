From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [Bug] Segfault in git status
Date: Thu, 21 Feb 2008 11:53:01 -0500
Message-ID: <76718490802210853t23b0498fkfb9a14bcd50ca458@mail.gmail.com>
References: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm>
	 <D3C27E63-329D-4509-830A-099A7BCB72B7@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Dane Jensen" <careo@fastmail.fm>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Pieter de Bie" <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSEgD-0006kj-I4
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762600AbYBUQxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbYBUQxH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:53:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:9771 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761933AbYBUQxD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 11:53:03 -0500
Received: by wr-out-0506.google.com with SMTP id c48so159719wra.23
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iuoivjVPAMDuRzohCyQOuiVP/Kqr/tK6Su05+xwoR18=;
        b=ghN4OyBQEhZ/RruXsPnYiWbJCO+u/pyT+2ELQNHEpz3OrBtZe65r90J3qG7CY9CqE+z4rvhKRDkg2gZ3jZkiLkc4AJaY0bS1+Vd12+7iL67F9i3CHDXciPKhi/k+DCYladf1QB6m1dIvsoxCC2IMFcFFAxVo0Um+H8V2AMw7BBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aYRBLSqGTY0Auoab5vSzbm5UKMmGZ3IAJ/zw/sGxHaePGqh9P2caj5zbhkdxWkYhnU64gWUjWhRz5jQ+R4pV/sO8bDu01mKkUWE9I/lNwKEEBAL9pDcZ6mNEIEOK6LSFerMZLlbHDUuOYS2urfxgR8KHlZlIhZPyWJfxy0TUdVo=
Received: by 10.114.127.1 with SMTP id z1mr122742wac.26.1203612781596;
        Thu, 21 Feb 2008 08:53:01 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Thu, 21 Feb 2008 08:53:01 -0800 (PST)
In-Reply-To: <D3C27E63-329D-4509-830A-099A7BCB72B7@ai.rug.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74634>

On Thu, Feb 21, 2008 at 11:01 AM, Pieter de Bie <pdebie@ai.rug.nl> wrote:
>  Vienna:Project pieter$ gdb --args git status
>  (gdb) r
>  Program received signal EXC_BAD_ACCESS, Could not access memory.
>  Reason: KERN_INVALID_ADDRESS at address: 0x004a2010
>  index_name_exists (istate=0xeba80, name=0xbfffdc27 "Data/Cache/
>  Template/Peter_II_of_Yugoslavia.html", namelen=47) at read-cache.c:101
>  101                     if (!(ce->ce_flags & CE_UNHASHED)) {
>  (gdb) print *ce
>  Cannot access memory at address 0x4a1fec

Do that again, but type "bt" at the gdb prompt after the crash please. :-)

j.
