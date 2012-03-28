From: Kevin <compufreak@gmail.com>
Subject: Re: Definition of working directory
Date: Wed, 28 Mar 2012 08:06:36 +0200
Message-ID: <20120328060636.GA2836@ikke-laptop.buyways.nl>
References: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl>
 <7vd37yj7h2.fsf@alter.siamese.dyndns.org>
 <BLU0-SMTP4376CA011AD4D79C1BAB727B14A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 08:06:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCm1v-000858-Ln
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 08:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab2C1GGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 02:06:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62553 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab2C1GGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 02:06:41 -0400
Received: by wejx9 with SMTP id x9so398710wej.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 23:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7gNvmzLoYyYQcn0KdmhDRu2W/MSs3JkSYZUGyy+vFYw=;
        b=ykpnPZo2QvWJ/ggh2eyTLKXndR02mhI2xzKaOS+mlPOr67+0EcL5FVyqnEBMl8ta+P
         BMPt7HJ3j2BxjO1qxlvM+WAag71CqVi4+nHbu1SfGAZ2d2gG/IAqGMqbdEpqDpbeQJti
         kgbRJCl3o6G7flYvIg5fFnnD2VlSLVz5nwvmYNEguFLT9uAmuHRvH8czxdPA9a4xmGYi
         kiJe3wmnXojbi8QCOuyV/0r3b+EJNpjEH/WZtG4lGbojCyHe48Tc+un9za8Ym+H24Gfa
         4FbQwMWBFs9C2Zy8M/7xv1T4PCBXFzA3ptHQKB0cRidelbKm7AWSslRoZy/0KE9Ipmc6
         3BiA==
Received: by 10.180.80.70 with SMTP id p6mr3840928wix.21.1332914800009;
        Tue, 27 Mar 2012 23:06:40 -0700 (PDT)
Received: from localhost (D4B2749A.static.ziggozakelijk.nl. [212.178.116.154])
        by mx.google.com with ESMTPS id l5sm55328542wia.11.2012.03.27.23.06.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 23:06:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP4376CA011AD4D79C1BAB727B14A0@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194107>

On Tue, Mar 27, 2012 at 05:26:23PM -0400, Anjib Mulepati wrote:
> So if I have a project called MyProject and inside that I have two
> sub-directories dir1 and dir2. Does that mean working directory is
> *ALWAYS* MyProject.

To be clear, the working directory or working tree is not necessarily a
path, but refers to the whole tree structure, so every file that belongs
to the repository.
