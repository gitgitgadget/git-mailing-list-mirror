From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/8] Add treap implementation
Date: Thu, 15 Jul 2010 21:18:39 +0200
Message-ID: <20100715191839.GL22574@debian>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-5-git-send-email-artagnon@gmail.com>
 <20100715190902.GB2774@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:17:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTvh-00068P-Vl
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934471Ab0GOTQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 15:16:54 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47790 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934274Ab0GOTQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:16:53 -0400
Received: by ewy23 with SMTP id 23so360976ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=B4s0j8Wbs5H45ukF7TcqASAKlWYASOnqHFBoA4n//DY=;
        b=XfK8fuNnJAi9xvreDuHGpHfrM+q3APcXtbjYIVIqEaPO5x1RpBnYprLYQQcCisXExH
         wPZQnhHckVF8caTyJ2CbJ6QKvUQO9u+9uquvo8ER43kWzvZcwzKa1di5EY0HEv6Sd+GS
         lYoaMVSqpkvz+xESCQANkCFaSz//R4ATy3JWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TJcCk+JKYBHox2ohuEhm24MEnuYNHvh4msHYYF29I0jMhohR6ia+7reG0pG5tnQjeN
         Zhsb72W16wIj5zCRb+QLvsItHjHNASLe6xdOJK0DbUZkZ78Htc+htjTSOVbUg41cWZst
         ww3F8z83Tl6iKB1hMxUSzo2VM2muDExpee5uk=
Received: by 10.213.10.147 with SMTP id p19mr110642ebp.66.1279221411946;
        Thu, 15 Jul 2010 12:16:51 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id v8sm10595517eeh.14.2010.07.15.12.16.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:16:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100715190902.GB2774@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151113>

Hi again,

Jonathan Nieder writes:
> I like the documentation updates.  What else changed from the
> previous round?

Nothing else. I should have posted a diff from last time.

-- Ram
