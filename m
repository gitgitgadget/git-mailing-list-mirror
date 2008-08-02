From: "Lee Marlow" <lee.marlow@gmail.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Sat, 2 Aug 2008 09:37:14 -0600
Message-ID: <7968d7490808020837m57a7c48fjf40c0a715f7f39ce@mail.gmail.com>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
	 <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
	 <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org>
	 <cb7bb73a0808012241s80a06fq1ac54a3350169f6c@mail.gmail.com>
	 <C871A30D-F2AF-4385-ABD4-C57F474D7F01@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kevin Ballard" <kevin@sb.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 17:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPJBT-0002bk-Pu
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 17:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbYHBPhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 11:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbYHBPhQ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 11:37:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:36860 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYHBPhP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 11:37:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1491901rvb.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=To6h8/wMGmSwu0S+6jUaaqbIEp1+rVIp21KA+XJmzhM=;
        b=thzjOVtHHtwC2IaCwD0/P2BkMiZsPy9i3GTzN+ecmsFH315HfmjZbx5erWFrQK0TcJ
         tC7ZPhnNYv9iaiImm/ajo9iltHbaeKL0dLn2k1m5lnqDadNEjQ0CKtXWdXsa+xjDxipJ
         vGhbGSxws1xOaEyJZQ0yG5B/jrpN+kiBZf9lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ceTxDQWQXnksHrl1JXsgr9UWH8WgWJtMgmyT5EWYjK63AVx45mYRJSYGZ5m8QuHzZ0
         pslGLli1uG/0XEYS3BuMkW0DtZJEhLjK394edg0oymtA2RNliTF1i5+dQ3ECaM5gmvDF
         xoGDWXJ9hCRyWxmth7Ki7U5h0K8TH7DzxM+ms=
Received: by 10.141.78.14 with SMTP id f14mr6590407rvl.119.1217691434140;
        Sat, 02 Aug 2008 08:37:14 -0700 (PDT)
Received: by 10.141.69.4 with HTTP; Sat, 2 Aug 2008 08:37:14 -0700 (PDT)
In-Reply-To: <C871A30D-F2AF-4385-ABD4-C57F474D7F01@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91148>

On Fri, Aug 1, 2008 at 11:47 PM, Kevin Ballard <kevin@sb.org> wrote:
> On Aug 1, 2008, at 10:41 PM, Giuseppe Bilotta wrote:
>
>> On Sat, Aug 2, 2008 at 2:31 AM, Kevin Ballard <kevin@sb.org> wrote:
>
> I think it's far simpler to stick with class/module/def.
>

I agree with Kevin.

It's simpler and I'm not sure what value it would bring to show
anonymous code blocks.  The funcname is just to provide some
additional context around the diff hunk, so you know where you are.
What would be shown for an anonymous code block or proc in the diff?
The module/class/method seems to provide the most useful context.

-Lee
