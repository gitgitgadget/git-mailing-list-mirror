From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git p4 submit always tries to re-apply every patch
Date: Thu, 2 Dec 2010 10:36:31 +0100
Message-ID: <AANLkTikiGd1dr2s8kxqPkt0k6Pncr39zR3+ek8Y1BonJ@mail.gmail.com>
References: <1291257039313-5794578.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: thussvm <thuss@volunteermatch.org>
X-From: git-owner@vger.kernel.org Thu Dec 02 10:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO5ai-0003Iv-Gi
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 10:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab0LBJge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 04:36:34 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61728 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440Ab0LBJgc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 04:36:32 -0500
Received: by ywl5 with SMTP id 5so3966811ywl.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 01:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=YuJsmTICXYLLumYEB/fnvM3qPotPxx+CWp1RGNwNQlY=;
        b=toE3Yv3aLNOZQH3J9raNop8Q5aZRzAFcdnImA0GXmETFD2pJfvryrvd9L3Sk+lishs
         BbZdRuzX+AAe9FJiUBmi3a/w0H7YlBXVtQiemIBzPzhlMY+vZq+O+ZhvNmJg/czQW0Ip
         RkmDcAH+zyeV7QIF6+xoBMdF4J3ScS9XoxPkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dlSVcURb3PfapjlcyUg5djdnzjuHvFMWFMOhFxoW0tLicb2FYFKNX80gO9aIdhumit
         7lv8embNiaEQixPYvxkrqRXobUgGCRBFmmcwte7HsScoEGUTdKC7g9BIf5yo0vIKq/T9
         RR/IU2bVsOSQTvp3ZPUB5FA6E1INi+yiQfAm4=
Received: by 10.100.166.18 with SMTP id o18mr321690ane.45.1291282591033; Thu,
 02 Dec 2010 01:36:31 -0800 (PST)
Received: by 10.100.121.13 with HTTP; Thu, 2 Dec 2010 01:36:30 -0800 (PST)
In-Reply-To: <1291257039313-5794578.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162689>

On Thursday, December 2, 2010, thussvm <thuss@volunteermatch.org> wrote:
>
> Whenever I run a git p4 submit after a git pull from the origin it tries to
> re-apply every commit, even ones that were already submitted previously
> (which results in self generated conflicts).

Try "git p4 sync" before submitting.

    -- Tor Arvid

-- 
   -- Tor Arvid
