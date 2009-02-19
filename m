From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 12:59:52 -0500
Message-ID: <76718490902190959y38685453h52d29bc4e5daac3a@mail.gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
	 <499D82BC.7020500@xiplink.com>
	 <76718490902190957td40d425p6b2ae1242060114d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 19:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaDD8-0004iZ-GU
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 19:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbZBSR7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 12:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbZBSR7y
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 12:59:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:4956 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbZBSR7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 12:59:53 -0500
Received: by rv-out-0506.google.com with SMTP id g37so516396rvb.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 09:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bW1u9dDmuZq0rmJyo6Wytn2VVByrWI1SPyneG3e6nhY=;
        b=CCH7EPJvazX8tNcOy0ly6dp5APJvgJnRvWRnvaniwTlDNXPyCnLtlTmfNCCwnVhwCG
         7AWUAj2yzT4lL5kIfZglbu4MVT4aoznsm07M7MXcLysGYwNld4LebzBwDZFslNuPGYjC
         rm+2LqRP5nSUbBjL0YW3/xKWEa54jscCja3wU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tg97iYbKmEijvHmsKfRsbA5AslEnLs+DsGFve6swmwzwVWQJU5EzbkPu6tn8NuAN3G
         SyqdISd0PEOkr5m1O438A4ZWwTKS6qT35Qz3GISMXpCwV/idCVYdsMIHfUaojqaALV1x
         LVMW74LaDbs7Ma5FW6zW0DHFU16xa1MfYJ95o=
Received: by 10.141.85.13 with SMTP id n13mr3733643rvl.102.1235066392303; Thu, 
	19 Feb 2009 09:59:52 -0800 (PST)
In-Reply-To: <76718490902190957td40d425p6b2ae1242060114d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110724>

On Thu, Feb 19, 2009 at 12:57 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I tried out a few different option and none was very satisfactory to me.
>
> 1)
>    master            rebases onto remote master
>    another-branch    merges with remote  next
>    some-other-branch rebases onto remote master
>
> Here, the unaligned "with" and "onto" is ugly.
>
> 2)
>
>    master            rebases onto remote master
>    another-branch    merges  with remote next
>    some-other-branch rebases onto remote master

I also had a version that used the word "upstream" instead of remote,
and another that put the actual remote name in place. e.g.

 master merges with upstream master
 master merges with origin master  (assuming remote is "origin" of course.)

j.
