From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git reset --hard and uncommitted files in index
Date: Fri, 22 May 2009 12:50:40 +0200
Message-ID: <fabb9a1e0905220350i12d30d17udf078ec2ff76513a@mail.gmail.com>
References: <gv52s4$e7h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Guyot-Sionnest <dermoth@aei.ca>
X-From: git-owner@vger.kernel.org Fri May 22 12:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7SLE-0001MM-Q8
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 12:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZEVKvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 06:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbZEVKvA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 06:51:00 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:39626 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbZEVKu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 06:50:59 -0400
Received: by ewy24 with SMTP id 24so1757658ewy.37
        for <git@vger.kernel.org>; Fri, 22 May 2009 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bQTZe0Av0aYbILwqwssIaleU8fJn9oudiQERwmdda7Y=;
        b=kNdR/3icqXo3vNUK8RZWI3fhoQ97vnYrUW2mpN/Mhw4zc8iOY7DugigmTSbGOFRO/x
         bv5tRy5N2HKg+B9dg0xOz2tFAkEyqoaOhl5Mtd8trh19+uRWZ/oXbs2fgpHmtvhVPl6U
         M49ORyisEWGpE1ZDhy0KA9gQDmiKl6NJ5EmQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=M362gSMiR2CxAClT3Kj3Ouy+bqfqOU5A9cKg+vHp2TYUntvlybew/dIVwIgWuv8mHZ
         sLQTITCaQfXiX6DlX9Crd/rVfHUbK6OWg9ipldprdEc2bcgwhuKeqleypvy5EtL7EoiY
         xQXxAamg9YszmrTlIw2Na7Q5ZgjEigdGyon9g=
Received: by 10.216.29.66 with SMTP id h44mr740264wea.136.1242989460116; Fri, 
	22 May 2009 03:51:00 -0700 (PDT)
In-Reply-To: <gv52s4$e7h$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119724>

Heya,

On Fri, May 22, 2009 at 04:32, Thomas Guyot-Sionnest <dermoth@aei.ca> wrote:
> Shouldn't git just unstage it?

You can do that too, 'git reset && git reset --hard' will not touch
untracked files. The first will unstage all your changes, the second
will blow away all changes to tracked files.

-- 
Cheers,

Sverre Rabbelier
