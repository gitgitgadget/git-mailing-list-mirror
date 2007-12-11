From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Tue, 11 Dec 2007 15:06:30 +0000
Message-ID: <b0943d9e0712110706l324b98bfy1e71f9dfa36da4ab@mail.gmail.com>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
	 <20071211142347.GA22879@diana.vm.bytemark.co.uk>
	 <b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
	 <m3r6hts2yk.fsf@roke.D-201> <m3myshs27c.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:07:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26hA-0001Xe-IJ
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbXLKPGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbXLKPGb
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:06:31 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:65379 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbXLKPGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:06:30 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2065948rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=z0pDj8UcL0s74p56V29eRR3xtq3SXut1jYgOcKE77y8=;
        b=nvWtOe0EqJ5A59T1z3SxW2ylGkwRfY7sgEHPkcloelJIH3GZ2/yRVwNMRlAZKX0LDOvjyjKmDhXNsdQ87Vym6Vm57v0Oe8uhoWk4o9XsSsUXEXYv+xcnJ+T9fH2MIEG4wWrnBcqi8YCRABkn1g5Ln2mEIO3YVxudUJ9/Uj5z3iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kNBMTNeHL4wFwxK+BY0K2OBFc2mCS4qUhKRfl6TdNnnXBXimUqVg5Pc5yGkqiWZLB7btt6bpF2lHpiX3jkm+Zel1aGpDUBN86r8WjMJfv+OhTpkPUhE9D9FMQbaZ1QamXChD4UBuvFIB2M8Uu6Sy7EeEyLk1Yd7O0mjdABrlkH0=
Received: by 10.141.48.10 with SMTP id a10mr2750420rvk.1197385590064;
        Tue, 11 Dec 2007 07:06:30 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Tue, 11 Dec 2007 07:06:30 -0800 (PST)
In-Reply-To: <m3myshs27c.fsf@roke.D-201>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67869>

On 11/12/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> Ooops... I think I'd have to wait for 0.14.1
>
> $ rpmbuild --rebuild --target=noarch stgit-0.14-1.src.rpm
> [...]
> Python version 2.5 or newer required. Found 2.4.3.final.0

Or just change the string in stgit/version.py.

-- 
Catalin
