From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Wed, 27 Oct 2010 19:54:55 -0500
Message-ID: <20101028005455.GC31501@burratino>
References: <20101027131506.4da06c6d@MonteCarlo>
 <20101027173132.GA15657@burratino>
 <20101027225318.GB1877@neumann>
 <20101027205217.3f28b9d1@MonteCarlo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 02:55:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBGlq-0000s9-F2
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 02:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933Ab0J1AzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 20:55:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54250 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757889Ab0J1AzE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 20:55:04 -0400
Received: by eye27 with SMTP id 27so1222995eye.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rFIOZhjSy/jh3grg2knSoFIBwUda747AaqN+9tk5S4k=;
        b=vpKkwG7cnP069P57vBgYtLDC5aE63V1+CiGsteasad32hjrbehs7AIsUglVwlQqyme
         wrUZ0pwjstWx24fMkgKkAu6Gw2Wn0oDSheT0Qa7Tc8xWGWHzL2PmC2FDqmKpIID24CO4
         bZacbCWqiPKUDDFD171c9s+IXAAoL8pmA75yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dlI4LWIoXEwYxw2q4CdPJHWZsQ+6NUJbtnZdTFmXt4Y53+AKosV/eznVD/diFwleHr
         2QjoOWpqCUOYiKQNITkfzJkLrgSDHQ9Ewvhk6wZg9tNtTWvrQuoFH9gxbclcm1y8fAnX
         LyBfLvYcrOswnTsJRanTAJI5DdYV4NAFiN45k=
Received: by 10.213.104.133 with SMTP id p5mr3823779ebo.77.1288227302311;
        Wed, 27 Oct 2010 17:55:02 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id q58sm326705eeh.21.2010.10.27.17.55.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 17:55:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101027205217.3f28b9d1@MonteCarlo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160145>

Peter van der Does wrote:

> The bash completion script could still be included with the core, but
> we can offer different versions for different shells.

Why?  That's three times the maintenance work.
