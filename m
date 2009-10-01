From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: Git push over git protocol for corporate environment
Date: Thu, 01 Oct 2009 08:29:41 +0200
Message-ID: <4AC44C55.6080807@gmail.com>
References: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com> <873a64gfa6.fsf@sanosuke.troilus.org> <20091001000620.GN14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Poole <mdpoole@troilus.org>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 08:30:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtFB7-0002Ei-Je
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 08:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbZJAG3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 02:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZJAG3v
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 02:29:51 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:11404 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbZJAG3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 02:29:51 -0400
Received: by ey-out-2122.google.com with SMTP id 4so625996eyf.19
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 23:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=75yFmCb2G3mNEho3EN4SKZIWaHIhO3kWSTzXEt0P1Rc=;
        b=t7/vtIudQJkqsVrFHKV1GE8v07WgRQdR0+oPttk4ua0jhFfHFYnt+T48LVx38kzCtj
         /v2Nw2n2+W+IIHCq1Gb6UnLm6/tvCAX5y7bG0AmxrafyhqHdmi+oPhy5te9xL2z+9hCU
         0yEx5sBfHVkxPi0S2CIuNOu4wOIC+U0Q7oM8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uSw2U+NGI36QLX9Per5ozN/4Vy1JOIRSPDXzSJs0snsBMY5T4qdDhFzAcTtwn8kl2g
         pqZ6fVahTtKWPbzXuwMCIwz2RyCm09nUHWGzR6wYWkjon1d0NHLm+VF67xNudKPoClrJ
         uBxVi74fxwTObNo+te0u+rgDQ4NkuEQ6oYbIA=
Received: by 10.211.171.19 with SMTP id y19mr6113315ebo.95.1254378592778;
        Wed, 30 Sep 2009 23:29:52 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm1265341eyg.41.2009.09.30.23.29.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 23:29:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <20091001000620.GN14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129376>

Shawn O. Pearce said the following on 01.10.2009 02:06:
> Michael Poole <mdpoole@troilus.org> wrote:
>> (Others have mentioned Gerrit.  I use that at work, and my only
>> major wish is that it had per-branch rather than per-project
>> access controls.  It is a vast improvement over the Subversion
>> system we had before.)
> 
> You'll be happy to hear _everyone_ is demanding per-branch
> controls, I have to do it before the end of the year, maybe even
> before the end of the month...

Ugh, any pointers on this one? Does this mean that you're planning to 
add this sort of control in git itself, or just some way to facilitate 
the setting of owner/group on individual ref files? What about packed 
refs?

--
.marius
