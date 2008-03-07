From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problems building git with custom curl installation
Date: Fri, 07 Mar 2008 05:40:35 -0800 (PST)
Message-ID: <m3ejamhctv.fsf@localhost.localdomain>
References: <47D08EA7.8000607@gravity.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ian Hinder <hinder@Gravity.PSU.Edu>
X-From: git-owner@vger.kernel.org Fri Mar 07 14:41:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXcp5-0002Pn-Hv
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 14:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbYCGNkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 08:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754552AbYCGNkk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 08:40:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:21567 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYCGNkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 08:40:39 -0500
Received: by nf-out-0910.google.com with SMTP id g13so265563nfb.21
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=aslsW3/vGugFGfTTctlSZMOGMR02Bw7uG/GXy/LC39M=;
        b=Klt2nl2qFthdEOU3bndL5JqzUUMeE62KyF3chSZDD/a2en7jTqCGjNoOPZw4lYofFo7+bfNU18wwhm+1LoQUiyAzWi+ZN5qd5LERVQO2epLU8H4SS1utnKJ9zuMpkDXgca2D5NV0Wh0VsCyfSDpTZA6V+oFCagsbFoUPtn9g1yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=HcjiK1vpTXwdPhvjuOLBgjdsPxZmp2Gi53ZZs8B28gawd0V6dtjr/NM7rb+Rxm3Yov93xQhAal9xi4lgpoaxFCrNhANbopETBUnzeD7CONHjoRy9yRv5GgiFSTnLmgz2VADc15gP11OVlE/zcjwTP/G4Ibh4/8xWPVPtRMUxUog=
Received: by 10.78.146.11 with SMTP id t11mr3651042hud.71.1204897236812;
        Fri, 07 Mar 2008 05:40:36 -0800 (PST)
Received: from localhost.localdomain ( [83.8.252.126])
        by mx.google.com with ESMTPS id 4sm2196688hud.61.2008.03.07.05.40.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 05:40:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m27DeVFG000401;
	Fri, 7 Mar 2008 14:40:32 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m27DeSac000397;
	Fri, 7 Mar 2008 14:40:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <47D08EA7.8000607@gravity.psu.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76490>

Ian Hinder <hinder@Gravity.PSU.Edu> writes:

> I suggest that the following are bugs:

> 3. The use of the makefile option NO_R_TO_GCC_LINKER is not
> automatically determined - perhaps an autoconf test could be written
> for it?  All the machines I have tried give an error if you try to
> give gcc a -R option, and gcc is being used as the linker.

I try to contribute to configure script, but I simply don't know how
robustly and in standard way to test if linker (gcc) accepts '-R'
option. Additionalyy, I don't have system where this is needed (it
fails), so I don't have a way to test if it works correctly.
 
> 1. Configure: Specifying the curl location leads to output that
> indicates that curl was not correctly located, even though a
> subsequent make finds it successfully and includes it in the build.

I guess that this bug is result of 3.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
