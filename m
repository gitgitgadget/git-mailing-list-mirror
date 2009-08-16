From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Sun, 16 Aug 2009 22:27:40 +0800
Message-ID: <be6fef0d0908160727r7dfa9b46l4d493e3954c21de3@mail.gmail.com>
References: <200908161557.26962.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Thomas Schlichter <thomas.schlichter@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 16 16:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcgi5-0007zz-WC
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 16:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbZHPO1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 10:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbZHPO1k
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 10:27:40 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:38084 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbZHPO1j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 10:27:39 -0400
Received: by yxe5 with SMTP id 5so3016218yxe.33
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=euoLARQYfkZzfP93p2zB+CGCq5le1ZvxCh2QPJHJbUo=;
        b=bKaH1DZUORnJ9TVwDqM8KCn0JrSqAW/gvPr6wt6eEk2jJnjTh33Rg1EDTUoaDG4Pqp
         PZ6YsCd3ZfRSd0sbm3QFCztWX4NQPesBYJfvjUmu0DIOjlV2OpjCglLWFu97BpYx1wFO
         kROhzrLBRPxVge3CqRsXKt586+J1dIfAWdW7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dyC5tPULpU/+gZy1hURjUiD2i349eQZTVAEQGMz0KE1QXpyHNPnEOrY0BhrwB2fYD4
         t7+zNVCNnvFR4O7CrwikGxy9+Q+gs6nML/pOHkXxcmMTAgrmz3Q7WSxwBnqFyXOQLcVP
         o0wv5ARDP1LLc/kDZOjQMrm4PXwuo5YJz4hSE=
Received: by 10.231.33.137 with SMTP id h9mr2097375ibd.15.1250432860859; Sun, 
	16 Aug 2009 07:27:40 -0700 (PDT)
In-Reply-To: <200908161557.26962.thomas.schlichter@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126062>

Hi,

On Sun, Aug 16, 2009 at 9:57 PM, Thomas
Schlichter<thomas.schlichter@web.de> wrote:
> Current "master" and "next" trees also have this problem. But as git =
version
> 1.6.4 does not have this problem, I was able to bisect it down to com=
mit:
>
> =A0 5424bc557fc6414660830b470dd45774b8f5f281
> =A0 http*: add helper methods for fetching objects (loose)

Interesting. Please do provide:

 -steps to reproduce,
 -your server's access log.


--=20
Cheers,
Ray Chuan
