From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Why 'git commit --amend' generates different HEAD sha1 each time when no content changes
Date: Sun, 30 Dec 2007 19:19:29 +0800
Message-ID: <46dff0320712300319s72dfc865oc71463cfe4e20cd0@mail.gmail.com>
References: <46dff0320712300256g36e825a2g711d98b565e361f9@mail.gmail.com>
	 <1199012360.15996.6.camel@futex>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Matthias Kestenholz" <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Sun Dec 30 12:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8wD7-00031X-KQ
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 12:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXL3LTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 06:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbXL3LTb
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 06:19:31 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:49655 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXL3LTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 06:19:30 -0500
Received: by py-out-1112.google.com with SMTP id u52so8547068pyb.10
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s0TPXRZ1U/OC9mR+wtIpFY+tHQT2doN+QlSiOOBmObU=;
        b=c4COElLKbHU6p5/8eOjDX1P/g0GbNjdVIBqpivpD2k7Wfr54E6mEKNdd5TOm5WgSsboKcufBLMrqQMQ5/0uWExmivSf74OgJvpLE55I0TfvvUxJBF6Go5muJY8kEQwCLSncYCxbDm7iTlXChZ9IdSWXOm+LTQvNk9k+A7fZZcNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wp6VqdphEZLv0Nd1pLbIj8oxEdqLd4u9aUdgmaky1B7o7vYd1jEbbnZOU3fum6qMJ8Eu8+yRZDYnuE6OezzGDKYBUmgpYmzSgZUBVOSI7Tk1tC3utAsNdqRcZNeU5Ui5k8w4K4i884WO/44F4//jrtX4hP2y7oKsFV/PsRd7z5Y=
Received: by 10.35.34.19 with SMTP id m19mr9300193pyj.2.1199013569692;
        Sun, 30 Dec 2007 03:19:29 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 30 Dec 2007 03:19:29 -0800 (PST)
In-Reply-To: <1199012360.15996.6.camel@futex>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69351>

On Dec 30, 2007 6:59 PM, Matthias Kestenholz <mk@spinlock.ch> wrote:
>
> On Sun, 2007-12-30 at 18:56 +0800, Ping Yin wrote:
> > AFAIK, commit sha1 is only determined by commit object content (say
> > parent commit, tree sha1 and so on). So why 'git commit --amend'
> > changes the commit sha1 when no content changes as following shows.
> >
>
> The full commit includes a timestamp too, which changed. Try setting the
> GIT_AUTHOR_DATE and GIT_COMMITTER_DATE environment variables, you should
> get the same SHA-1 everytime.
>



-- 
Ping Yin
