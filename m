From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] teach update-index --refresh about --data-unchanged
Date: Sun, 14 Nov 2010 11:34:54 -0600
Message-ID: <20101114173454.GC26459@burratino>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino>
 <20101031222644.GA31257@arf.padd.com>
 <20101031222805.GB31257@arf.padd.com>
 <7vzktqwbob.fsf@alter.siamese.dyndns.org>
 <20101103183621.GA14019@burratino>
 <20101103220243.GA6777@arf.padd.com>
 <20101114165819.GA8714@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgUG-0008W4-MQ
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab0KNRfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 12:35:30 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58630 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0KNRf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 12:35:29 -0500
Received: by ywc21 with SMTP id 21so1370648ywc.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9xUtoaU2h5JMU6QheIIfnmZNiKo+j8QGlOr4OdkO8Ec=;
        b=Ic8ezjThvXKZQ2lH6Y/YK5EihFCyhd5YWda0OWuYLsJPom8TkKAdY5QU4aHpPpsImG
         tiIdjRH1pmVbe8Yg7BxUXibObPKcbnEIS7i610q7ogfvnhFqODnu5eqCrxfyvh+53SYS
         JZ+uJgdfgAyysrKDOOTIa4hZA9qjAlCpO+w3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Di09WpvWM2jAzkLLQnWxojOj1haosfJHNV35qBbqnINM/Ge/jNXssBtqfZGzstQGYI
         PNhx63IfYrSsHOM4TQvxBcmh5objX7bJyXKx9bhYcD1v5S5hqtu+eOT6gKY8ArfjnUHZ
         c+h0ULy/dpZvGtfmTrvnUEpE8Y+aXtrzQr95o=
Received: by 10.150.226.8 with SMTP id y8mr7879015ybg.269.1289756127720;
        Sun, 14 Nov 2010 09:35:27 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w5sm2426167ybe.10.2010.11.14.09.35.25
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 09:35:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101114165819.GA8714@arf.padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161423>

Pete Wyckoff wrote:

> The script uses dulwich to generate a list of index entries,
> stats each file and updates the entries, then writes it back
> out.  I won't submit it to contrib, since it is so trivial and
> because it depends on dulwich.

Maybe we can add Dulwich to contrib? :)
