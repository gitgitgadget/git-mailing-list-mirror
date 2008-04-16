From: "Richard Quirk" <richard.quirk@gmail.com>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Wed, 16 Apr 2008 21:11:56 +0200
Message-ID: <cac9e4380804161211h1f49dc0bg810cfa9c0d47af5d@mail.gmail.com>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
	 <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
	 <7vej96v2pk.fsf@gitster.siamese.dyndns.org>
	 <32541b130804160946s343d53d2l271b9391d89a7953@mail.gmail.com>
	 <7v3aplsl3p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Eric Wong" <normalperson@yhbt.net>, "Sam Vilain" <sam@vilain.net>,
	git@vger.kernel.org, "Avery Pennarun" <apenwarr@versabanq.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:26:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmD3l-0002Vg-Jw
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 21:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYDPTMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbYDPTL7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 15:11:59 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:9539 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbYDPTL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 15:11:59 -0400
Received: by el-out-1112.google.com with SMTP id n30so475097elf.21
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Fz+pbZpbxkFc3AkPTSjAhualZY6jdWgTVJI/uNMu8/o=;
        b=KpFeO8syqC2/2U9iJF49tRSqxOA4KYvYqGDJCS+PVK71OXojL15Fvd4BPJsd3PwsMNr5LzVUv5sonpV98pzSE61ckqM754z/0vLyfEMQaB3JkVNJohvi11n7JVRgNFzU7hK55gxZzaSCGISrXViUS0jcc+Em5SEatUKfPAuWl4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KMo5K5JaItFr1UTgZjkJpXDhO0lA2/m8hngflMzqOX8qe+1u9KW7BiBvowRFP028R/eGcbf/P6ofwaIlD9BellKIPt809LShIM2R1b2VZxDJ6OKRzQTyXwODevIg6YNgXoMkuDdVHBdH2ApoUiaEyelc+KjBWTS4+cb6y4uQFTo=
Received: by 10.115.18.1 with SMTP id v1mr571432wai.15.1208373116798;
        Wed, 16 Apr 2008 12:11:56 -0700 (PDT)
Received: by 10.70.52.19 with HTTP; Wed, 16 Apr 2008 12:11:56 -0700 (PDT)
In-Reply-To: <7v3aplsl3p.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79727>

On Wed, Apr 16, 2008 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:

>  For example, CVS honors LOGNAME to allow you to "lie" who the author of a
>  change was, which is the behaviour inherited from RCS.  I have to wonder
>  if SVN has a similar mechanism to tell it "Excuse me, but I am just a
>  secretary recording changes for my boss."

The author is stored as a property of the commit, so you can set alter
it with something like `svn propset --revprop -r N svn:author NAME
REPO_URL` providing you have server-side revision property changes
enabled.
