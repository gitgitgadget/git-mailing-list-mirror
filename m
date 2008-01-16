From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 21:56:18 -0600
Message-ID: <478D8062.3090506@gmail.com>
References: <478D79BD.7060006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: fromlists@talkingspider.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 04:57:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzOc-0007EE-7j
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 04:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbYAPD4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 22:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756935AbYAPD4W
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 22:56:22 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:32379 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbYAPD4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 22:56:21 -0500
Received: by an-out-0708.google.com with SMTP id d31so22948and.103
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 19:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=xWs9N24Rcbljd90X+eWWFe3Kw6XErR5BHkQ5f4zrBt4=;
        b=gcv9hSFaHXeWSVTUe2+fQ1FcLa9McHc/KMl9jB8RxSKa2UlKUe7Fp3blAuz4mWyLp1xHm4bdCNlO4E0kcmcy61eO+ewYNwbQgNj7JxZP9k0+qXHadHq3Sr6cGi5XwIORTXipUZ35vIxauRRyS8qlKOJLOOecw9dsaa9RpP2z8MU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C3EX5cLgqcro/AQu2c5lOlWIcCuHQMQ0MbrrCGSN8qyuJeLJbfJYdQo7qQrGmQJntR9MgLTZdy/HTaphnSzL6yuGFb3T98KZT2Pjjw5LATFEAcUisaorDNAPC4BL9taL6JkpYS8rUoHmMLpTHSV62FclmqhIfm5guWsMKi0zFZY=
Received: by 10.100.249.9 with SMTP id w9mr611196anh.67.1200455780746;
        Tue, 15 Jan 2008 19:56:20 -0800 (PST)
Received: from ?192.168.1.100? ( [76.197.238.51])
        by mx.google.com with ESMTPS id a15sm420329rof.19.2008.01.15.19.56.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jan 2008 19:56:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071212)
In-Reply-To: <478D79BD.7060006@talkingspider.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70614>

On 01/15/2008 09:27 PM, Mike wrote:
> 
> How do I make the repository dir live somewhere else, the hell away from
> my code? Thanks

mv .git <location to move to>
ln -s <location moved to> .git

Did you try this before you sent your email?

-Dan
