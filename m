From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] shell: new no-interactive-login command to print a
 custom message
Date: Mon, 11 Mar 2013 15:48:11 -0700
Message-ID: <20130311224811.GD20586@google.com>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130309215237.GA24777@elie.Belkin>
 <20130309220011.GC24777@elie.Belkin>
 <CALkWK0kK3YCwkv26cxVf61yUd8WHmHDG+mFwb2VRwNF3k_40qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Greg Brockman <gdb@mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 23:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFBWQ-0006QI-Oe
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 23:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab3CKWsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 18:48:20 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54867 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab3CKWsT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 18:48:19 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so4287433pbb.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=R7LflhK5pf+FBiWSawOxvhnfFvEt7ARgrH3J63xT734=;
        b=mAnBZH1MmGUP+z9XmBwqbSFJvLGhCyhyNc1PPqTBU9105tQqJxadqWzpfqMN+f+aQh
         e/M1/ePRNs9pQjVeVNP/WlXf3R6pFdrVTZ89wibcaCB45qF0K2M9pZcNZT6vx9Y9hN53
         Q87AjVgnGUgJkSglHXVpBBxk7jiYMF73usplkhGxqfnU5838zRf5GrDb3GQEXHMgV6wu
         qDDh6NiCCUt64lhIk51Fk7Oh4eW7F29n7Q0VrnAt9RdVUrZ1ZeXmCBifxkfE3mP+x5jO
         adW9rhX2ivli7lclWvvamUzIuLVgv276AsOIx+PxcMt5szRT4dDssYWenXHBInB/FPgX
         33dg==
X-Received: by 10.68.225.40 with SMTP id rh8mr32349221pbc.137.1363042099202;
        Mon, 11 Mar 2013 15:48:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id tm1sm22184744pbc.11.2013.03.11.15.48.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 15:48:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kK3YCwkv26cxVf61yUd8WHmHDG+mFwb2VRwNF3k_40qA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217923>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>>  * If the file ~/git-shell-commands/no-interactive-login exists,
>>    run no-interactive-login to let the server say what it likes,
>>    then hang up.
[...]
> If "no-interactive-login" doesn't have execute permissions, we'll get
> an error from here:
>
>     fatal: cannot exec 'git-shell-commands/no-interactive-login': Permission denied

Yep.  Intended.

Thanks for looking it over,
Jonathan
