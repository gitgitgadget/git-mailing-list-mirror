From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 09:53:55 -0500
Message-ID: <9e4733910711280653q119f2c2n173eaebdda6cd774@mail.gmail.com>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
	 <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com>
	 <20071128093403.GB12977@diana.vm.bytemark.co.uk>
	 <20071128101718.GA13940@diana.vm.bytemark.co.uk>
	 <474D5482.5020609@op5.se>
	 <20071128121905.GA15953@diana.vm.bytemark.co.uk>
	 <474D69A7.6020404@op5.se>
	 <20071128132605.GB15953@diana.vm.bytemark.co.uk>
	 <474D7710.4090303@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxOIu-0001yw-2Y
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbXK1Ox5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbXK1Ox5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:53:57 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:53921 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbXK1Ox4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:53:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1757326wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o60vdjRKGLcYqPJEIIRvTOIfHWO6+s5653YRB1kLShw=;
        b=YvdjDNQZ/ary9ieQT1H20Lj5kPGz5X4dzdBCqd+3ufN3Q1RdOPunHnQleOdhtzlYo0kQct9Cm6frue3q4CS7SoQwnnGjxSCAZ12qGUqJZ+MNEu5VJcse9SFI5hd469s57g/kX7DWU+hTxQabbU195YhKJIPS+GyUX86KvQ5vgT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FcbUrq5tdKLFS4mWbdSK1x3OuqX6erbhOGoX0w+ndhLzwQnxyIX8GObEC1Ek14ZLEZ6I5DWvGwN8R0FRlyOfNDrVExr1yCiM0OSWoB3JFCMd4vSyxtc6HrtHe4cMd3UAPJNWo0ccDI9oihYrncAlTMPwS6etQSXYUSa9nQQaJXo=
Received: by 10.114.112.1 with SMTP id k1mr84307wac.1196261635462;
        Wed, 28 Nov 2007 06:53:55 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 06:53:55 -0800 (PST)
In-Reply-To: <474D7710.4090303@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66350>

I would expect 'stg init' to switch the branch to using the stgit
hooks and only those hooks. Branches that were not inited would
continue to use the user hooks. I don't have any user hooks, but this
is what I would expect to happen.

-- 
Jon Smirl
jonsmirl@gmail.com
