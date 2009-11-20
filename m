From: Jeenu V <jeenuv@gmail.com>
Subject: Ambiguous ref names
Date: Fri, 20 Nov 2009 15:48:44 +0530
Message-ID: <5195c8760911200218v5b75d690hbaaf00b44c8df6af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 11:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBQa6-0003lm-Nb
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbZKTKS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbZKTKS7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:18:59 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:61005 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZKTKS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:18:58 -0500
Received: by vws30 with SMTP id 30so877040vws.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 02:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=9y2HyaAQ2dtZEzblgSsKhYFiZtdLH2kn1q7otTlQiFw=;
        b=QA+XCMylJ3nXo/U5vMSeH14yqsOccexZcXItjtALlGGWwoaqQk5ra5QMeRGGHvh8kM
         AfcJoIcf1Ks4lrtCLBpSYY2q+eF5naMTMqQuFAXMoyWUUeU8zKjDY6zPsHE/iuOkUqfQ
         R278mrojZIQkPwKj2V0dTNOYRdTGiG6VqIap4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=TL54jOyWK/hEV18VmGSuXyF/5HrN/IbskwjwYpYn7ESP+zGskO1FGUoPAcAhbQBmCP
         LQKig8Y40WQuZLFTmB1PdDaq6n/CVsotheHVPQu9rJs3YqfwzvS+9kQj3Zi1l4UMpzSD
         Eklh+XBRl8EtSNisYczLjCKqXeJWmgEozsjBs=
Received: by 10.220.122.35 with SMTP id j35mr1471813vcr.106.1258712344491; 
	Fri, 20 Nov 2009 02:19:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133324>

Hi,

I'm re-posting this from the git-users Google Groups:

If I've two branches a.b.c and a.b.c.d, why does 'git checkout'
complains about ambiguous ref names? For example, if I'm in a.b.c.d,

896 $ git checkout a.b.c
warning: refname 'a.b.c' is ambiguous.
Switched to branch "a.b.c"

Is this some kind of a side effect of commit abbreviation? If so is
this kind of branch naming considered unsafe? Is there a way to make
git accept ref names verbatim, even if there's potential operation
that'd fail because of ambiguity?

-- 
:J
