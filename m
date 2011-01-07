From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Mark gitk script executable
Date: Thu, 6 Jan 2011 21:01:19 -0600
Message-ID: <20110107030119.GA32290@burratino>
References: <alpine.DEB.2.02.1101061943140.6372@dr-wily.mit.edu>
 <7vlj2x8mr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 04:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb2aA-0007TW-Iy
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 04:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918Ab1AGDBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 22:01:35 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:63776 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab1AGDBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 22:01:34 -0500
Received: by yib18 with SMTP id 18so4425535yib.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 19:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jaZ+eEYoduykxl9tRcWDBJsLawq3nGPaqkKOD7ZSEwE=;
        b=QUvlwU1mJ0bcbj8sPGeCBI0f3U4GOWv2HVI43/4hBlCeY0pH6lFXDVWTc/VTOlW0jw
         p71Gia6E8sM2onhZ4P12jtGxpJaiW5eKfTevusORJPqksDZ4WOhcHgWBBBT0/UlXmkaD
         u/CIAG5zSWBwL3XmWmfSXbjQ98BXB0Hh+wab0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nSndwLxessVX4rh+G3WNM7RLZ5w52MLzvlu/oVNHNjG56CEaNlhcD3JTF3qaPuYucn
         dDswfsVBzjQ9vN8mP5L01fCdUrT7eyNHgSNgmJQ7Mnp9aKV0ArPHh9b9bB5QYhgXbVR5
         6Sx6OiCgTzfvWDVNE/xMcRhGFUIlOCmuVpNcA=
Received: by 10.90.80.18 with SMTP id d18mr2762313agb.31.1294369293565;
        Thu, 06 Jan 2011 19:01:33 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id b19sm23476245ana.27.2011.01.06.19.01.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 19:01:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vlj2x8mr4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164697>

Junio C Hamano wrote:
> Anders Kaseorg <andersk@MIT.EDU> writes:

>> The executable bit on gitk-git/gitk was lost (accidentally it seems) by 
>> commit 62ba5143ec2ab9d4083669b1b1679355e7639cd5.  Put it back, so that 
>> gitk can be run directly from a git.git checkout.
>>
>> Note that the script is already executable in gitk.git, just not in 
>> git.git.
>
> It did not lose the bit by accident but 62ba5143 pretty much was a
> deliberate fix.  "gitk" is a source file, and its build product,
> gitk-wish, is what is eventually installed with executable bit on.

How does this case differ from other executable source files like
git-am.sh?
