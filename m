From: David <wizzardx@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 09:13:18 +0200
Message-ID: <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
	 <7vmym1zny4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 09:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3nCJ-00085R-NG
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 09:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbYFDHNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 03:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYFDHNW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 03:13:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:1861 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYFDHNV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 03:13:21 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2000263rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O075UdznHDcVjdOW7RKVkti4uIBsnLKXhFaZM6qK/Ek=;
        b=V3LxBOWKHqCaLjmgE8nZuhvM9awB2cy4gsbnuGN3fqUYzvlysXuSbLLmjCIBn04G4H8OIRbXNuC+mRVdcJgkqI2MfB/D1Q3DsaoiFclgfldaZdE5hV3/yCi8kXoFSZUIGgfeNUr+uuGvfmHw0hCYn97NN92CQkp9bgtvxK78q54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HUMAUMfhCR838sAnabbbPX4uMwTd+Jcn95EwE+G1drD9nR1sZD7QLJPY9tUCKmjrSNCjE8YqfM8azfc7XmqNkWu3tmF+QhUlbUhFWClXyC/WzoqFizxn+0YyXIQKOJPqPm/CJwJL7gQA2MqVzWf1suCV9znet6IMnfs21f4i+8Y=
Received: by 10.141.69.1 with SMTP id w1mr6427734rvk.147.1212563598309;
        Wed, 04 Jun 2008 00:13:18 -0700 (PDT)
Received: by 10.140.194.15 with HTTP; Wed, 4 Jun 2008 00:13:18 -0700 (PDT)
In-Reply-To: <7vmym1zny4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83752>

>>
>> for C in $(git log --reverse <commit1>..<commit2> --pretty=format:%H);
>> do git-cherry-pick $C; done
>>
>> Is there an easier syntax for doing this?
>
> rebase --onto?
>

Thanks, I checked the manuals further, and it looks like this will
(mostly) do what I need.

What's still missing is multiple cherry pick ;-)

In other words, is there a simple way to *copy* a large number of
commits from one branch to another, without rebasing?

David.
