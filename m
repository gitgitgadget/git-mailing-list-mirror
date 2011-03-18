From: "Sean B. Palmer" <sean@miscoranda.com>
Subject: Deleting a Bare Repo
Date: Fri, 18 Mar 2011 15:26:37 +0000
Message-ID: <AANLkTimaQ3dyXDJgY_Ys19jpNXx07vK2qNLQ_8Cp8NKi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 16:26:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0bZc-0002Zx-FY
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 16:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab1CRP0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 11:26:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42110 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694Ab1CRP0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 11:26:38 -0400
Received: by qwk3 with SMTP id 3so2890309qwk.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:x-google-sender-delegation
         :date:x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=fxVV6U7AO1hUf8S+26BR61Qarl2bofH70J1USJTn/WQ=;
        b=gRFVU/5cJ/JfCMvglAx4fv1cn3KduZh7TN0zbyDEPa8I0BQqdJLLIWsJx+jdpO+TcD
         mzgNu//TF+qCOCG+HuY4MiVp2IX9LZ7yL6Urn5602ki6bSXMQsUtEunN8e63COevBZnR
         Zy4OHgw4Fu+YCExKRV4t1rfU9RSTt6Qf1I84k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:x-google-sender-delegation:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=Mn1Q+zVYa/0EYH3A4hoC0dNkdjCi364c4kgY8eZWDX6PoAAsPNfd3FI3xtxcw6+XVH
         K2heLMvqk2I8CxD0ZTH+GyEntFndc0sQcapQcC8uG5JnPAlSCSz0ddvRRAf7jVR0VsWn
         vqj1qr2kgpCRBJCrpWi46+yi0FUKiljNE/R+I=
Received: by 10.229.119.151 with SMTP id z23mr1094195qcq.2.1300461997188; Fri,
 18 Mar 2011 08:26:37 -0700 (PDT)
X-Google-Sender-Delegation: sbpalmer@gmail.com
Received: by 10.229.82.74 with HTTP; Fri, 18 Mar 2011 08:26:37 -0700 (PDT)
X-Google-Sender-Auth: IgW--qEcxhgPDuua4_RgglUs_B4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169335>

I'd like to delete a bare git repo, but I want to check that (a) it's
being used as the actual git bare repo, e.g. if $GIT_DIR is set, and
(b) that it is actually a git repo. Using rm -rf .git/ doesn't seem
safe for these reasons, so is there a command in git itself to do
this?

I've been going through the man pages without success.

-- 
Sean B. Palmer, http://inamidst.com/sbp/
