From: Jeenu V <jeenuv@gmail.com>
Subject: Git reset -p on working tree
Date: Tue, 23 Nov 2010 14:41:50 +0530
Message-ID: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 10:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKovO-0006ta-7O
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 10:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953Ab0KWJMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 04:12:23 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45305 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab0KWJMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 04:12:22 -0500
Received: by wwa36 with SMTP id 36so8433204wwa.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 01:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=vxLBhQ5B951zDeMrPMM4XSZhto1s0yyNgrPJb9ilelg=;
        b=Y3yZ+J3/hBOCPujHSrVGNP5tLZvNXNc6mMLXadJ7IyvYVyQW6f/EGPIUeAO5AwMYhS
         gk+G+DzBFAKEHN4wa8wYiHxMr9VIUSoEKpwc4ksjP59mVqS8ZCllio2BB0kLj9oFHYcb
         ksx96+kW4obiH4H9CId1G5mS5lvAWS1n+qhqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=WB1kwh/weCxrYMSPnBlaNzbktqR0tgJvqmxjUYzYF/dGWl38i6fu5bxzRAMRZ3o2lD
         K1I8Lux+6Gl9vVjViVie/Oc/UsNmmxiKvld9aXjNMVKfpaJAtTaM3GhJVIuzyv65oHVM
         Wsnb0plzJBMsEKSBozjJ/8XRbMxJR8Z/+0UpA=
Received: by 10.216.191.160 with SMTP id g32mr748777wen.18.1290503540598; Tue,
 23 Nov 2010 01:12:20 -0800 (PST)
Received: by 10.216.10.209 with HTTP; Tue, 23 Nov 2010 01:11:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161934>

Often I find it useful to selectively undo the modifications that I
did to my working tree. The -p option to 'reset' that selectively
resets changes back to a given commit. Unfortunately the option
reports itself to be incompatible with --{hard,soft,mixed} and thus
can't be applied to working tree.

Right now I do this with vimdiff, by applying 'git diff' in reverse.
Wish reset supports -p on working tree operations as well because the
-p framework (of add, and reset) feels good to use.

-- 
Jeenu
