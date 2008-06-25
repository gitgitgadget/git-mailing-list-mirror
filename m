From: "Adam Brewster" <adam@adambrewster.com>
Subject: Re: [PATCH/RFC] Created git-basis and modified git-bundle to accept --stdin.
Date: Tue, 24 Jun 2008 21:14:41 -0400
Message-ID: <c376da900806241814v22782818w57f53bce5d299ad5@mail.gmail.com>
References: <1214273297-8257-1-git-send-email-adambrewster@gmail.com>
	 <m3iqvzl091.fsf@localhost.localdomain>
	 <c376da900806240830p2a48aff0uaf6f22372fead5ef@mail.gmail.com>
	 <200806242055.53776.jnareb@gmail.com>
	 <c376da900806241655q85fc1d9r5bf67096a7930f94@mail.gmail.com>
	 <8fe92b430806241721j43f9443eu80e16dcd64b8d143@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 03:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBJbn-0000nr-3T
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 03:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbYFYBOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 21:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbYFYBOm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 21:14:42 -0400
Received: from hs-out-0708.google.com ([64.233.178.250]:4246 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbYFYBOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 21:14:42 -0400
Received: by hs-out-0708.google.com with SMTP id 4so593169hsl.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=JVN/BpXxL9b/lHOKCSargKxaHkxSy4xbUqznk7zZTHo=;
        b=W1sJoWJebNmTpDhxzqTd9QNFrt+V2lt+Q8ty1Ix9jxlneRJCHI+lyRyqqn++yO05dD
         ptnWMZHrocIhhhr1IWUJJnzBfpJeJV2MtSfnGRRL+QffaiZ507jSkrclAAIRBKbssSuj
         LK0FN8s9hNTcEb9bNVuYQCDTu3oRJcdziiBxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=knYnKcNvphJ1cbNvZAj5rmHEezJ9a8LN/8qLxZAynIKIxg3MAx+RyI7tk87lZTqjvW
         QDaAivClQFNHnVYjbZ5nIvcqv+282hzZOTviXBgz5YfZMpVYTKk+1wNNv3pxWQnXbLgN
         cRTo0NBnWlggMWynpfw9hVa/SVBHtPG6dGfoU=
Received: by 10.100.166.10 with SMTP id o10mr17212768ane.0.1214356481099;
        Tue, 24 Jun 2008 18:14:41 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Tue, 24 Jun 2008 18:14:41 -0700 (PDT)
In-Reply-To: <8fe92b430806241721j43f9443eu80e16dcd64b8d143@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 68d5d47a18505db6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86194>

>
> Does it prefix bases with ^, i.e. ^basis (negative revision)?
> I think it should, then there would be no need for strange --stdin
> semantic, or implementing --stdin in such way that --not--stdin
> works as expected.
>

Yes.

I figure that patching to make --not --stdin work how I'd like would
break something else, and implementing --not-stdin seems hackish.

Adam Brewster
