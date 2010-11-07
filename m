From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Status of the svn remote helper project (Nov, 2010)
Date: Sun, 7 Nov 2010 11:42:15 -0600
Message-ID: <20101107174215.GA31242@burratino>
References: <20101107112129.GA30042@burratino>
 <20101107125054.GB16474@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 18:45:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF9JQ-0002EK-5K
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 18:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab0KGRmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 12:42:31 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50673 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0KGRmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 12:42:31 -0500
Received: by gxk23 with SMTP id 23so2964931gxk.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3kP1sVVFRB0gFniaJV2NqDIzN+slnaj/RfpZce0Z4qk=;
        b=EedzN+C7IoXJo3tWZjiHbeRDIY4QTfrD/aJBoFTbpu5G239fdCEMT2llVvAZEzFGqy
         yN7+DG2jQQh1QzP3aVzTmwvVWDiRqSniOq3LqObbC9OAUNGRjZVQ91DyCf9J5uDjAkFI
         DLEoIXyDZoLMj3mn8rNS7FM/GM8njqFxSnLaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oEnZzWjIsOCjIPU0m8QU10GZ75v9fIMjRMw+vg4gDbMchjz8zgEDpnZw14e08BP45F
         MUigNBWjpxIV4MdrhyvbePUKVeeZpibcL8gVA3R52ga/vfZYJoS0AvoNvKR3r6J5DBav
         J7pUL+gsiJihsK+wlI1cLmuFfvBjnoIZkHNzM=
Received: by 10.151.149.9 with SMTP id b9mr7192456ybo.114.1289151748288;
        Sun, 07 Nov 2010 09:42:28 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 43sm2875122yhl.37.2010.11.07.09.42.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 09:42:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101107125054.GB16474@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160891>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> 	git://repo.or.cz/git/jrn.git vcs-svn-pu
>
> Thanks for doing this! Now we have an up-to-date index that tracks all
> our work :)
>
> A note to the others: If we merge too early, we will be forced to
> either stick with bad decisions we made prematurely, or revert
> them. Therefore, we have decided to develop this on the side, while
> reporting progress on the list.

More precisely: it would be nice to see the usual flow of patches into
git.git; from my point of view, nothing is significantly different
in that respect from before, and this is just a convenient place for
remote-svn patches to park and be tested without bothering Junio too
much.

This should make it easier to keep track of the current state of svn::
support without regularly sending 46-commit patch series to the list.

Thanks for the updates and kind words.
Jonathan
