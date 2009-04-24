From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 18:29:22 -0500
Message-ID: <b4087cc50904241629u76454b1chc6e84e95066a9100@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <alpine.LNX.2.00.0904241911590.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUrB-0001u5-Ok
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbZDXX3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbZDXX3X
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:29:23 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:58795 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZDXX3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:29:23 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1147092qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1iN3K26yfssi/CfoLhfNuo81O4CsGpRaqBgIR061WxQ=;
        b=C3Cr2gzfnFaFfeshk7Yvl5JyhQHOjeJ1bYseB1ZLb0z6tgXdoKHyH5icpvd501QwCw
         X10tnbLxz2c2G9cpysrtM5kGHioYKZ394ywaiUDTcnOq0gl0BT+uNbtuxn70Pb7tL6Xz
         i85u7O80f5ejJUqoxAE4B81fv90yl1f1893XY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cUgvmVTtYWWLtFlvzbYmOkNVNveV0Wd2HNyjrzXgaQ7AW/2n5YxnU38PO3FlC+57G4
         OHZChqAMtLgB4sXKhCTk4slUCVNCzA3xUyr8zMRApHK+jU9XMtP+no+CtmS+V0yS6VmR
         BuoK3rpjfJxu0QJGK72h4uJeid6vxmsdVKY6U=
Received: by 10.224.67.78 with SMTP id q14mr3631235qai.162.1240615762210; Fri, 
	24 Apr 2009 16:29:22 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904241911590.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117521>

On Fri, Apr 24, 2009 at 18:21, Daniel Barkalow <barkalow@iabervon.org> wrote:
> "git blame 1a2b3c:Makefile" worked despite this technically being
> incoherent.

It seems to work on my end, and it's perfectly coherent if you
consider git-blame to be overloaded to handle both pointers and
addresses (or references and object names, if you prefer).
