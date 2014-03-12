From: Orgad Shaneh <orgads@gmail.com>
Subject: git-gui resets author on amend
Date: Wed, 12 Mar 2014 08:28:08 +0200
Message-ID: <CAGHpTB+35j0njmCZ0uCgBVroe=Ma7HLnn6fDty8yebKWgEmECg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 07:28:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNceF-0002zK-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 07:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbaCLG2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 02:28:10 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:60435 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaCLG2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 02:28:09 -0400
Received: by mail-ob0-f180.google.com with SMTP id wn1so9457237obc.39
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 23:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GU/lgiI4KUCeU0I34A37ibb6t5Up2FZfzOzOXrShdLM=;
        b=jhbraDlOSV9R6cU/1c245IdYYHIwHz0InpJ1peAoRqfogbO696P0vpJa7HEm925vI3
         sITXdIkeKnfnElvAxQyfectmh43D463H0xe6jXuV37pdWfc+cAiBuFPiTmCSRG2lW2jW
         e3r1dz4KZIEgbZyixVRwhdlS68w0D5vf8QKeiYbuDtridChcmhrlXKwv8X7BmL/uq95+
         0BelQazlWaRT/F98Pnbv6LfRrtWy718e3KnGINYACWUD3IoTNYhuzA9wy6oLSk3kjIUS
         8w4UqXg1A25FiPwD2lSKJpbSHb9s8ISc4SrtonsXzMFfoGtaN7ockVxp6g78Rryx8sCl
         42DA==
X-Received: by 10.182.122.133 with SMTP id ls5mr91268obb.52.1394605688878;
 Tue, 11 Mar 2014 23:28:08 -0700 (PDT)
Received: by 10.182.135.74 with HTTP; Tue, 11 Mar 2014 23:28:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243921>

Hi,

Amending a commit using git gui resets its author, unlike plain "git
commit --amend".

- Orgad
