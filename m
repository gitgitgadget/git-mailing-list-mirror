From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 21:54:58 +1100
Message-ID: <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petko Manolov" <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 11:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF5vl-0001JJ-Gx
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 11:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbYAPKzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 05:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYAPKzA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 05:55:00 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:2466 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYAPKzA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 05:55:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so183252rvb.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 02:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qxGuRlNoFmOMsApcbtsbIor4BggX2O93wauSlrW7cVU=;
        b=HLAzA/UDRKs0bxss7te0H5VDH2r7hfd1DJgZVLYLz1PKf7hxVea5JOMX9raQN1DQae9W+A6HS3H3dbnXAYLgN/XH3EC1s3a7Mfs0TawT1XelPup0t3QkwZ4n3VuMpXeWyBKXCCvFJjZrtkQoClmWHKVxOGZX3Ex3OsTiftIV0A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p2GUs30cvaxV3fbQfh2AZU7/O0Li00Y63ypFAMEavV9jDsLix3JKZzaNZNP4SHnV4gPc7w6Q6eEsJ2qmVNcGjX8z/0nwQlT6GurdxHzcyksQWQ1GCIICDfE2atbDAuIsleXAdGvXWjkX2NwU2VAajU0Dc7bcH7kDPmau+yb8cJo=
Received: by 10.140.135.20 with SMTP id i20mr436732rvd.263.1200480898706;
        Wed, 16 Jan 2008 02:54:58 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Wed, 16 Jan 2008 02:54:58 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70652>

On Jan 16, 2008 9:34 PM, Petko Manolov <petkan@nucleusys.com> wrote:
>
> The nature of these binary files is such that i don't care neither about
> their history nor older versions.  Hence the question:  is there an easy
> way to tell git not to bother about the history of these particular files
> and keep the most recent version only?

If you don't care about versioning those files, why would you use a
version control system? Just store them somewhere else, and use
symlinks.


Dave.
