From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK)] gitk: Add a menu option to start Git Gui.
Date: Tue, 18 Nov 2008 17:12:30 +0300
Message-ID: <bb6f213e0811180612k2183afcas2ba1dc379bfbb03b@mail.gmail.com>
References: <200811132312.42150.angavrilov@gmail.com>
	 <18722.35810.362792.501694@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 15:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2RKt-0003DY-GF
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 15:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYKROMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 09:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbYKROMc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 09:12:32 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:10059 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbYKROMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 09:12:31 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3170674wfd.4
        for <git@vger.kernel.org>; Tue, 18 Nov 2008 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yxtEKOGVVjwSZ/0Oiy9a6nRpssgQUBU+d9/x7LFpD+4=;
        b=rD7yFNTBmmzeOos4WEj59grG+pEre7mNm0HFwixXaYifp6yLzvfNspDZ68DuYvhCjI
         idHtPBZ+dZlzdCzPzz+oV0zIrtsKgKwbrMDJP2HcRMHdCD25ysptHehOAnJ6DBomSoMv
         QhbHjMfWhrVZEoIfi5nhMWqcnUhO9elrtaers=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PPgfPuxOYToTRX4R8rcdAo4i5vm+nTVvdT+532N+7F5TU/CmJZAV5UZZL0pzF66rnm
         H1KGnD0rUcKXzj2vNQYNVIA547hvtK6gi5+IU0cN+D8nthen7rpx92s0K7peZRK4I5PS
         x+WwPBnvXN+9bYt6LCKwLX+/h4D1OWPcFvX0M=
Received: by 10.143.9.9 with SMTP id m9mr1615766wfi.41.1227017550966;
        Tue, 18 Nov 2008 06:12:30 -0800 (PST)
Received: by 10.142.185.3 with HTTP; Tue, 18 Nov 2008 06:12:30 -0800 (PST)
In-Reply-To: <18722.35810.362792.501694@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101271>

On Tue, Nov 18, 2008 at 12:33 PM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>> Git Gui already has menu commands to start gitk,
>> and this makes the relation symmetric. Since gitk and
>> git-gui complement each other, I think that it is
>> beneficial to integrate them where it makes sense.
>
> I think it makes more sense to have this as an item on the context
> menu for the fake commit(s) for local changes.

Git Gui is useful for a lot more things than just committing changes,
e.g. you can interact with remote repositories, or do a merge, or
amend the last commit message. Also, not everyone has local change
display enabled in gitk.

Alexander
