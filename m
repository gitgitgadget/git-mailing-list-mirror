From: Tim Visher <tim.visher@gmail.com>
Subject: Re: [Feature Request] git export
Date: Mon, 10 Aug 2009 14:31:22 -0400
Message-ID: <c115fd3c0908101131n20237b8bsb5f5a06ec4b2189c@mail.gmail.com>
References: <200908101822.59940.thomas@koch.ro>
	 <c115fd3c0908100927v4d9e4a87we4502e91d3789138@mail.gmail.com>
	 <200908101841.00522.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Mon Aug 10 20:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaZeh-0006kq-R0
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 20:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbZHJSbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 14:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbZHJSbY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 14:31:24 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:43809 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZHJSbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 14:31:23 -0400
Received: by an-out-0708.google.com with SMTP id d40so3534307and.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cqFIe62P/l66IvOeM5QN2oUdkiIQl7DFvAIVeEWyXWY=;
        b=Yb/9fnnXdY3x2pI+xzCWQ/HRoj7Q+ebQLILd9yWr5WRtSK30Rd5IcxzFC0ZdCQVX2p
         F86WTY9trNdO4OQlWRjvDws+CPDQArhB+8FYYb2yVVncxNPihc/Cx4XHlNH0exF5LahY
         ijQ1IurTxvbinHeSNpTp/Yd8dUVVVXvRFEziM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D+pCOOs0JYJCPoAinfm0kZdihrML+Z16M4voGRBntyobDIz7Ecb6MSJCkCGtz3WoLq
         8IdX3YHLmoaXOshD5LCIiazNMIJP592qnvZ6LdDflPylcdCP2VvDrDdxw0i0jQJA8Xip
         7VOVpaCQ8s4ALIBnQ3FsbyzvuEE2j7O3BrwZ0=
Received: by 10.100.178.2 with SMTP id a2mr4052135anf.2.1249929082287; Mon, 10 
	Aug 2009 11:31:22 -0700 (PDT)
In-Reply-To: <200908101841.00522.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125496>

On Mon, Aug 10, 2009 at 12:41 PM, Thomas Koch<thomas@koch.ro> wrote:
> thanks for your explanation. Still I don't get how to do it with git checkout-
> index. The man page says "Just read the desired tree into the index", but I
> don't know what is meant by this.

No problem.  That phrase gave me some trouble the first time I read it
too.  All it means is 'do a `git checkout` of the branch that you want
to export'.  `git checkout-index` will then do an export of the
contents the branch that you currently have checked out.

Junio and Dscho's comments are possibly salient as well.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
