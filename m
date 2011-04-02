From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fast-import: use struct hash_table
Date: Fri, 1 Apr 2011 21:48:03 -0500
Message-ID: <20110402024803.GC6039@elie>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Stephen Boyd <bebarino@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 04:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5qsp-0004wu-2O
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 04:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab1DBCsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 22:48:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37145 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab1DBCsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 22:48:08 -0400
Received: by iyb14 with SMTP id 14so4085014iyb.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 19:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P8H96nFXaI6UQ6g3qPCVlpyIEom1FlkwzUu9qnu8C8s=;
        b=pnLF1XLnuxbCDU3CwO4phwucpZRZtu/k0abSQhHQFlXiSlrVPXLdNZOQguGzJckSNA
         kGsIuDl4J8+PieZozyxJIbfC1skEtsJunr28JyXrFe9msaJaKsbk1WZ0C0eUvfHctdCS
         gKJ2nhCzh8JwdpFH3IDSqIoPSXWPajsq06rYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L0g9qvS8KLwrE/j3qwnSfUW8wKO7TaScJmexrXhGg7SF1X/LHHlff1bheaK8gBG8/8
         Qmd1XEzcF4rKS7XmoiqmLuGUrXxRus6XCPfOFmMyOD8AO4Kp6YZt3CDbGgvy8YpHXEGk
         0uOaOkAVHm6VcCZReRwF4TrXUEbGgZJRX9k3s=
Received: by 10.42.152.1 with SMTP id g1mr6488902icw.494.1301712487311;
        Fri, 01 Apr 2011 19:48:07 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id d9sm185086ibb.19.2011.04.01.19.48.05
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 19:48:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170640>

David Barr wrote:

> If anyone is interested, I think the hash API documentation
> could use an example or two.

Yes, please. :)  At the very least, a "here is a quick checklist
for how to use it" tutorial would be very nice.
