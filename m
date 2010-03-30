From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 0/2] git-gui: change to display the combined diff in the 
	case of conflicts.
Date: Wed, 31 Mar 2010 03:34:17 +1200
Message-ID: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 17:34:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwdST-0006b9-BM
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 17:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab0C3PeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 11:34:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38601 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab0C3PeS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 11:34:18 -0400
Received: by pwi5 with SMTP id 5so7825533pwi.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=1Ya/+karYlnXS52qusc40D9iP5/mLMErlwb6xC9JvOY=;
        b=YSh4+SAs9GTRtHZaGQuFN8RlxdTiHRxgt8OJvmFDYOPOr4pzJHOmP1KCVYbC+BUGZE
         g1+/MURnu8jsqgXdnSpDH0h9+Ca3h/MS6/hIQUonhIQ6BWa1Y2532c6C0GLDNWsbjpkS
         pAZWzhcEm2iiAmCNYry0fZ8LIInmpCnA0IMPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qgEtHgOtMyDaY6X/m3omIuh10SzC17hoEVbokdm/wOpMLvO/IqWKAu+Ic7iPCotHho
         gRJD+wdVMXP0gBOKpripawsiRwxvg3GCHB6MTJ74HLjtv5kPgF687nUwzj9+wpMnRvy5
         DBuD8QxpY8AlXJ3J3dfp4+NBzc9t6++BJZ3hY=
Received: by 10.114.13.5 with HTTP; Tue, 30 Mar 2010 08:34:17 -0700 (PDT)
Received: by 10.114.187.19 with SMTP id k19mr6503555waf.20.1269963257441; Tue, 
	30 Mar 2010 08:34:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143570>

This variant of the patch uses git diff -c instead of git diff HEAD,
at Johannes Sixt's suggestion.

The diff displayed in case of a merge conflict now shows the
differences between the merge result and each of the local and remote
heads and thus now also allows the user to assess the consequences of
"Use Remote Version" by showing how the merge result affects the state
of the local branch.

I have avoided using gmail client to forward this version of  patch
because of documented word-wrapping issues, so hopefully this will
apply cleanly.

[PATCH v3 1/2] git-gui: Introduce is_unmerged global variable to
encapsulate its derivation.
[PATCH v3 2/2] git-gui: change to display the combined diff in the
case of conflicts.

jon.
