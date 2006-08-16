From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compression and dictionaries
Date: Wed, 16 Aug 2006 01:50:24 -0400
Message-ID: <9e4733910608152250h1bcb8bf5qebb29ef84b971abd@mail.gmail.com>
References: <9e4733910608150755q54757386n13c705b0043e8308@mail.gmail.com>
	 <20060816003712.32000.qmail@science.horizon.com>
	 <4b73d43f0608152243i15b37036x7aa50aa3afc2b02f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 07:50:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDEIa-0006yM-C0
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 07:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWHPFug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 01:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWHPFug
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 01:50:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:40553 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750769AbWHPFuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 01:50:35 -0400
Received: by nf-out-0910.google.com with SMTP id x30so579363nfb
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 22:50:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dW8LFSYOswveAlVeKXG+kCqM5+NDz8IsfN7sGZnzUjBBHcbCR6TF+YmsLNoEXyKPo3axLMz7OoKjoeW+2jAu18It/AofYfdIYOTf5HivEKbAbyunpDlqb43CHisAzD0BbXOX9GGLgFua6i4NKKT3fdYpLY5WYww7pJ3AP10bGaA=
Received: by 10.49.8.15 with SMTP id l15mr274826nfi;
        Tue, 15 Aug 2006 22:50:34 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Tue, 15 Aug 2006 22:50:24 -0700 (PDT)
To: "John Rigby" <jcrigby@gmail.com>
In-Reply-To: <4b73d43f0608152243i15b37036x7aa50aa3afc2b02f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25498>

On 8/16/06, John Rigby <jcrigby@gmail.com> wrote:
> Sorry if this is off topic, but could the dictionary be used to make
> git-grep alot faster?

It would be almost instant.

Inverted full-text indices are what Google uses to grep 20B web pages in 1 sec.

-- 
Jon Smirl
jonsmirl@gmail.com
