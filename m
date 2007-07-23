From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-apply versus git-am
Date: Mon, 23 Jul 2007 10:31:16 +0200
Message-ID: <81b0412b0707230131y666cff17vdcccb170b6034ca9@mail.gmail.com>
References: <a2e879e50707230054m60d45293ua1d57887367914c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sean Kelley" <svk.sweng@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 10:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICtKL-0002Vq-VL
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 10:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761327AbXGWIb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 04:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbXGWIb0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 04:31:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:50732 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761220AbXGWIbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 04:31:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1125495ugf
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 01:31:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uYUfjHyehU7FxP96dxPafhe50kvIeQXrl3DkbpyDIV4J5aXr/O7emt8LBRFINcmDLZ8YoQzbU7VXnjifkvFQO8cQ5Hm/o+O2hqnD8D61VD+B17bN6Q9iKMa29KWLGbTDrFpzw1wDwtW03p6jT2xdvPZ0IHCzDW4yN2zZfmQp18E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SJYJlf/Fl8n2iG0NiS0Zj49+clEm3Ii70E1tzxre9PTyxenS1CV32b2+6g+T4nb10Q48SbrtjbZk3FWWPc59iUZflO9Nfnp7BwAvCcKVuU/MnZpVfnSuL6+1R2hxRpEzMy0JTibRWISIzGlf7MkEijr6ikrhOcViTV6RvmVq8zo=
Received: by 10.78.37.7 with SMTP id k7mr698111huk.1185179476666;
        Mon, 23 Jul 2007 01:31:16 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 23 Jul 2007 01:31:16 -0700 (PDT)
In-Reply-To: <a2e879e50707230054m60d45293ua1d57887367914c1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53410>

On 7/23/07, Sean Kelley <svk.sweng@gmail.com> wrote:
> Why doesn't git-apply include an option for a signoff line like git-am?
>
> git-applymbox /tmp/mbox ~/.signoff
>
> Or am I missing something?  (most likely the case!)
>

git apply is just a safer patch(1). They serve different purpose.
