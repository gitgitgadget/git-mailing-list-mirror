From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Wed, 2 Jan 2008 20:07:35 -0800
Message-ID: <a1bbc6950801022007w164d050bhf8a8a8c0ad6736b@mail.gmail.com>
References: <11956768414090-git-send-email-prohaska@zib.de>
	 <11956768412755-git-send-email-prohaska@zib.de>
	 <Pine.LNX.4.64.0711220121560.27959@racer.site>
	 <7v63zv9fel.fsf@gitster.siamese.dyndns.org>
	 <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de>
	 <7vsl2y90pm.fsf@gitster.siamese.dyndns.org>
	 <52415F60-C080-4260-86CD-32A379482341@zib.de>
	 <474552D6.5060305@viscovery.net>
	 <3B6B19E6-255F-4D8F-B6A3-255A9E8E0AB0@zib.de>
	 <0FFA1D0A-DB70-446C-9C43-A6FBAEFE7CA4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jan 03 05:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAHNC-00062N-MM
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 05:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYACEHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 23:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbYACEHh
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 23:07:37 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:46069 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYACEHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 23:07:36 -0500
Received: by an-out-0708.google.com with SMTP id d31so1030783and.103
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 20:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KG6fSIzudHaY/v4Y3C43P4KtlxeTq7iowrX58kVvbAk=;
        b=EpLDeJqpZbL2C7gR0yNhGC+cRqioysYE/cnqnsg7nzSSYykGBVyQCDwtQ5Z9O/v45kS6TCQLKmYyj3WjskS59cx/aSryc92YdWNxevgHhFT7LakLUpuZF0BYmc+8cxG51kZqvRXVp6vCfHSPmkCJP+QM5blXG13RrjgG2cxwN4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zx//8J2sjpDfsYRSBZToXFNB+qbm/+I9Iw9qbdi5hmoEIKyCx03SeVgXa6R59/JwJkDem9ICb2um4xjvqRuCHa/QXwAZwS8zbOeLpBVM54SXIBn39HjvgOCjPjvisiFVTNmjBGosVuUEYVRCXrmTN8zLMYPVmvehUJcoEnWP6Q8=
Received: by 10.100.255.10 with SMTP id c10mr31879657ani.54.1199333255482;
        Wed, 02 Jan 2008 20:07:35 -0800 (PST)
Received: by 10.70.59.16 with HTTP; Wed, 2 Jan 2008 20:07:35 -0800 (PST)
In-Reply-To: <0FFA1D0A-DB70-446C-9C43-A6FBAEFE7CA4@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69507>

On Jan 1, 2008 10:52 AM, Steffen Prohaska <prohaska@zib.de> wrote:
> In conclusion, using setenv() as in the original code instead of
> set_git_dir() should be safe and this patch is not needed.
>
> I tend to revert the changes in msysgit and see if we hit any
> problems.  But I'll wait until 1.5.4 is released.
>
>        Steffen

Please don't revert this change. I've made it in response to git clone
failing, commit 855f254b2b5b083a63fc8d7709a42e2cbdc5a136.

-- 
- Dmitry
