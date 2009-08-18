From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] Windows & executable bit
Date: Tue, 18 Aug 2009 14:19:50 +0200
Message-ID: <40aa078e0908180519u41b28ce7oc851791db1d5f773@mail.gmail.com>
References: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl>
	 <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302>
	 <200908181223.48291.trast@student.ethz.ch>
	 <alpine.DEB.1.00.0908181355090.4680@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Ferry Huberts <ferry.huberts@pelagic.nl>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 14:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdNfT-0000aP-CC
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 14:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758816AbZHRMTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 08:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758807AbZHRMTu
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 08:19:50 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:38770 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbZHRMTu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 08:19:50 -0400
Received: by qyk34 with SMTP id 34so2668032qyk.33
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y6CD2yKziQO2JXntLvgRT0oEY7mPJfcMxcbwOcKAv24=;
        b=P9kJ0cZ+AkBiK9PfLuWHZAw80Gq6Oz1DOcyPfqJkvP0ql8PB8l3XcVGpOdQMVexoVZ
         ejXdPvHzm+qEjSoI6O4qWACgUAu6ncYZOCFVe+w2QLjsQ4MBvRj7AO75P8M5zF++kuoL
         dxZ7Ysg7eTz0A+ACCVutik52hg0Cdnw/WBb5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H1dw+n5LkSInCzdnI/nO6pkXqzAMKLCjtSaa9f8sFoMhrg/S7i8KQSYZY35+RDr9xa
         LnZrvuNN6SIhL5MEilUDceVbcFTkGrGK1PzT9g5C/pcFqaUUouJyI3mWJQM3CWUdOmOy
         IpG2GNotCRYTEx+GNe+ONKlMKRRKUKk4k3/dU=
Received: by 10.224.92.79 with SMTP id q15mr5278405qam.26.1250597990924; Tue, 
	18 Aug 2009 05:19:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908181355090.4680@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126386>

On Tue, Aug 18, 2009 at 1:55 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> > git config trust.fileMode false
>>
>> Isn't that core.filemode ?
>
> The matching is actually case-insensitive, but I prefer CamelCase here...

I believe the question was about it being in the trust vs the core section...

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
