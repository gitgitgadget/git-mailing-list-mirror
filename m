From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 10:31:22 +1100
Message-ID: <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpuN6-0000kd-R4
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583AbXKGXbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757550AbXKGXbY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:31:24 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:30804 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568AbXKGXbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:31:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2197229rvb
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2URuokzzHLBLRhWyFNOIgk1+GlOexMYCVXTQiYMMRX4=;
        b=quM0a3LBfjqai9dz7eE5r8RTqeJY41QDHSVn1vh/lRFXY39NwsZM1sTZkL0oR0g8mhoyFkfSZnBx6mLT2Xsapm1U5jfCgA8mtY9noBBJDAgN4g1/qUQLmwU/nAv39ZpeWSy+dFwu+xaqGp8q0jkKzV9AcDzktt2wZ9oItUpybfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YcPQoby6gwC34ZxZ137ZiJS0l3bSuH7OoF8VUOs54IMTnU/udg4/mTPfhZl/lmp2PTVLGHQMadzmyn0kKOetvsCJ9RaTB3ae1JJ6T3Gap6jup9Uh/IsZDuX8mBjYgpivoaQf9tXJj8NSIjba3P+RUv4u5APe5dq8syvT/0COX0Y=
Received: by 10.141.20.7 with SMTP id x7mr3900751rvi.1194478282537;
        Wed, 07 Nov 2007 15:31:22 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Wed, 7 Nov 2007 15:31:22 -0800 (PST)
In-Reply-To: <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63897>

On Nov 8, 2007 10:19 AM, Brian Gernhardt <benji@silverinsanity.com> wrote:
>
> However, Dave's suggestion of altering git-status output to be
> relative to (but not limited by) CWD has merit.  Too bad I don't have
> time to work on it right now.

I am happy to hack on this if there's not widespread revolt against the concept.


Dave.
