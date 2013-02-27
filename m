From: Jan Rueegg <jan.rueegg@dacuda.com>
Subject: [PATCH] contrib/subtree: fix Makefile to respect non-configure `make`
Date: Wed, 27 Feb 2013 14:09:29 +0100
Message-ID: <CAAiqqq43vkf5vHpwj6Nm39VCAeFCgULqU3rTSe=bHUZFsh3TEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 14:10:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAgm2-0006Zw-6b
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 14:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433Ab3B0NJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2013 08:09:51 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:51591 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980Ab3B0NJu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2013 08:09:50 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so558837ied.2
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 05:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dacuda.com; s=dacudamail;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=GtBhbcQQXgYExgytqYdzO5l1ewuU18lw+64clPyVtRo=;
        b=FrH8yDlRM8+A7Qaa3dyl+JNKIA/5AiEI7jtfd0XFjkCywAly8M79sW1J8L24WDtIQT
         h0a51MJMhCNrEbjOVmWHNm4tyyz+Ij7tjlzFELsNkCNvtudKn6E5P6Ocv6NzBf/giIqn
         Wr7+iInGaOal8PbZ/Xga3MXtfWdwsvpYQ6XWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=GtBhbcQQXgYExgytqYdzO5l1ewuU18lw+64clPyVtRo=;
        b=Uh/iBsCKn5k/8JNz/rf+Rx/MyWlMgG7pPvctUOmRDs/Xqfyd8hauCRpMhn8o5VKJzu
         nisPj+sjBtdu3OXbVPaKc/lBs14wrlZyJnE6FdbvBTcNqfO/2Ub1//WrgUb6b7NfTJsH
         uS8vVBmeHC4RcennLTDk8v1iljsO55fBKIeLXyqGWDAr3vfiAZpIQA0OkeQIiqnEMdY7
         m6PVrp3SUgQfJwjAlvuLux1wwVGPBH6FPPy6yEedFEjRWQ3YETe+9VlPk1Q3pEVRQcdy
         sKTHRndK5erk3QtFlfmEeLrulEFNeE7RI7iF72XYiqNguTKaqcikICQIWtukT8ohCNpK
         hgcw==
X-Received: by 10.50.33.203 with SMTP id t11mr1026145igi.97.1361970590130;
 Wed, 27 Feb 2013 05:09:50 -0800 (PST)
Received: by 10.42.156.1 with HTTP; Wed, 27 Feb 2013 05:09:29 -0800 (PST)
X-Gm-Message-State: ALoCoQl2u7FktN/eruBoLe5RodNpIDGaEzLHdx8zONg42OTo7QB+GWUQlWTTHTjfTt4hqFHed4A1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217202>

Hello

There was a message in this list before to try to fix the Makefile:
http://marc.info/?l=3Dgit&m=3D134116914230460&w=3D2

However, without any reaction following. See also here whats the proble=
m:
https://bugs.archlinux.org/task/30473

Anyone there who can have a look at the patch and integrate it upstream=
?

Regards
Jan R=FCegg
