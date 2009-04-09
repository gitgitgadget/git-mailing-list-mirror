From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git over http not re-authenticating after 301 redirect?
Date: Fri, 10 Apr 2009 01:20:06 +0800
Message-ID: <be6fef0d0904091020r45927bddq9751885f8e3f28b3@mail.gmail.com>
References: <5591393c0904061914y5ea26812kcfc0d14b52ed4300@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Vincent Craven <paul@cravenfamily.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrxwi-0007Pw-6a
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295AbZDIRUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757177AbZDIRUK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:20:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:47336 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbZDIRUI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 13:20:08 -0400
Received: by wa-out-1112.google.com with SMTP id j5so381916wah.21
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ouc1XipeAACUUyfn0zvKv4xlXldGynJMkH/FR37llOE=;
        b=AVzoTkd3RXnXkVoojpEpiKJjJS/xlbQVuVAbn79wNW1M08p8jCPh+4TPIDOvRIboVa
         bQ8zB+JdldJmaElIeRwPE3wSmUnSCpKLQsa0yb/Kq0pgijnulXuyMHg90Anu/PUVz+2O
         JKFhJi7kRvmb2IC+UBBN2YZKaV9CaVLfif118=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MkucCLaShduSR60fYVBUhKB1Gi3kZg/9X/g75dsB4AYUdC4NaUjnD4WvKootQrPPxu
         8QqPKVsIO0AJVgbVTvQBFXeok9hnh4+JMRGCuJ1mAZghe2bTlvwW//7q91BdjFBF6f4z
         93pdiIOmdPTOX+6iVCOtk8sA0pC4XwZJGenz0=
Received: by 10.114.13.18 with SMTP id 18mr1498662wam.149.1239297606363; Thu, 
	09 Apr 2009 10:20:06 -0700 (PDT)
In-Reply-To: <5591393c0904061914y5ea26812kcfc0d14b52ed4300@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116182>

Hi,

On Tue, Apr 7, 2009 at 10:14 AM, Paul Vincent Craven
<paul@cravenfamily.com> wrote:
> Note that after the 301 redirect, I don't seem to have a username sent
> anymore. I'm not sure this is the issue, but is seems like a
> possibility.

could you check what version of git you have? This should have been
fixed in 1.6.1.1.

-- 
Cheers,
Ray Chuan
