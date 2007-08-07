From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: resumable git-clone?
Date: Tue, 7 Aug 2007 09:23:51 -0400
Message-ID: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 15:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIP2U-0005VI-Ic
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 15:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759869AbXHGNXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 09:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758310AbXHGNXy
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 09:23:54 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:54134 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262AbXHGNXw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 09:23:52 -0400
Received: by an-out-0708.google.com with SMTP id d31so320460and
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 06:23:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X1l/k7Q5iUm4Y6ZfdFfvBathxcw4hAcZvO5lkSL32Qgnyp2JxYnBute+I4npDtagrV1brMX7aXImpgli+UDBpcylvtPZUqcNYrazK8VdO6ZLPIlDz5vB+IouMO0EkP9PPhL7KJ2RsHvp2oAjAxSiGJCtLh+alIYUO3p44VwKVX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C/XH4NuIfQcrEDDM8rZttUdMmbLauL9pijXyIST3Bk27LLIeyeXJhs6oXlYLHR+dHspY8YBngdQtlmQXUxGQj3FvOI2hFkBfhGcssBPTOfIv/VPT4lzzlw1RO3lSlybqOXzUyrEaPhkhFUxp4kxjpGDMtFNONK6/xdft5U9vFbw=
Received: by 10.100.153.17 with SMTP id a17mr3782748ane.1186493031667;
        Tue, 07 Aug 2007 06:23:51 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Tue, 7 Aug 2007 06:23:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55254>

I was on a crappy connection and it was frustrated seeing git-clone
reached 80% then failed, then started over again. Can we support
resumable git-clone at some level? I think we could split into several
small packs, keep fetched ones, just get missing packs until we have
all.
I didn't clone via http so I don't know if http supports resumable.
-- 
Duy
