From: Timothee Cour <thelastmammoth@gmail.com>
Subject: support block comments in gitconfig
Date: Mon, 4 Apr 2016 19:19:25 -0700
Message-ID: <CANri+ExqdM-TTibWK07B2VFns6fQ09fmbqbCKC1VWET1tgRFNA@mail.gmail.com>
Reply-To: timothee.cour2@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 04:27:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anGi8-0005jJ-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 04:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbcDECVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 22:21:18 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36769 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbcDECVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 22:21:17 -0400
Received: by mail-oi0-f50.google.com with SMTP id y204so161288oie.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 19:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=EZEH4QCK+a/vBsKdkci2yT2jymwbZzaW8cVvzjoAFqc=;
        b=S/tgGWyucgcxVkdUIuWdZx5G1gNC1/n3G8GtfRIVeKtpw+GspLQCN8iF7Fq7EVBH8P
         9QIIxex8DeAELrS18Vv2OcRoHSlf1t11XeXhW/6oy3/3Y+uny3X7AgaaDvB/guCENb8w
         RswJxR25a/hLevMwjkDZFf+EzlrtB8AqQu4RQXLJouTa9WrU53Q70ylplQqYP1gvwPsZ
         +mjXoXHSsZbZvk6n7iSSyg5OdyHanAbywRKX77br/oR5k5pdNfB4Njh8q5RiB5ZV+UcQ
         MG4uVal7Msbu1Vb665RljG6blXd7Vu9sczpOMio7LqtVm9m0cLnO1LsrmYqgjJpj6J/8
         MX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=EZEH4QCK+a/vBsKdkci2yT2jymwbZzaW8cVvzjoAFqc=;
        b=kkjeyogdExr/OiTDJf4DvvoZcI1+VA2xyPbGb7MQsg63S5p4mHEgtamFIlMHBG4J3+
         TU/E+m1VrMUkqMren45F0SifO1xCYu6ppuDSb5fKM+H/PNGRu0M6gkVTuaEfxEsZnQ5v
         3F6dVzcqz2g25UupBOQRS0Tk2altT9BJzmFhAEoCHQzqZxfxFAtSorrlUHKDKBOGhYZA
         OEbgUaPMCyfDamqmFYDeQK4F9TC6HN+qxMh9/mL4TdOkYSjbdIy9xcAxrHgN8dnVqMLW
         nIotk8UgoVpu8hIn9iwFwU90y2batW/sYa4w9IoT8rvspkM2RlorJvOlEsVlqSesAHJ6
         JO1g==
X-Gm-Message-State: AD7BkJKa2cK4hxCz6+OdIekyqPhWvK6XqxlWw6FwB3sm/K1jj8qCebZyojaEfIZDjszF/ji3URK6kLGHJjyqcA==
X-Received: by 10.157.15.101 with SMTP id 92mr11328871ott.156.1459822794697;
 Mon, 04 Apr 2016 19:19:54 -0700 (PDT)
Received: by 10.157.42.170 with HTTP; Mon, 4 Apr 2016 19:19:25 -0700 (PDT)
X-Google-Sender-Auth: rTaaFZB3I5opUW1t097yA5c8VQ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290756>

Could we have block comments in gitconfig?
It's a nice-to-have supported in most languages.
eg:

#{
commented out block
#}

or other intuitive syntax
