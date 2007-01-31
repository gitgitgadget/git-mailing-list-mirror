From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 10:58:28 -0600
Message-ID: <3c6c07c20701310858v488ebbd4k98cd14340661f086@mail.gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	 <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net>
	 <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
	 <Pine.LNX.4.64.0701310959220.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 17:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIn5-0007Qf-3I
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967AbXAaQ6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbXAaQ6b
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:58:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:34584 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932950AbXAaQ6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:58:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so609168nfa
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 08:58:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sME9mhlOIVk8ARc5d/o0YvUz2u0OQ8Dpav0hDGP9bYrP7h/f7pPBtU52lu+HSzA9ADAJ9rNMObpZo3fVjPj2sOsI1/9yGmVvqHyTjAfhmuW1s7BO5BYHc/OvdpjpaJhKag4g2zEsJSGNxtyoUWaZ23kjSwKM/kzwpVul9QY2hjc=
Received: by 10.49.36.6 with SMTP id o6mr2841879nfj.1170262708908;
        Wed, 31 Jan 2007 08:58:28 -0800 (PST)
Received: by 10.48.246.15 with HTTP; Wed, 31 Jan 2007 08:58:28 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701310959220.3021@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38277>

On 1/31/07, Nicolas Pitre <nico@cam.org> wrote:
> Matt Mackall said himself that some core portion of hg have been
> rewritten in C in order to improve performances.

For what it's worth, sloccount reports the following:

git: 52K C, 17K Perl, 10K sh, 6K Tcl, 300 Python

hg: 14K Python, 700 C

Speculating wildly, I'd be surprised if the C part of git couldn't be
reduced below 5K, at a cost of an 8K increase in Perl (or Python), and
not more than a doubling of runtime.  (This speculation is for
entertainment purposes only--I'm not suggesting a course of action.)

Mike
