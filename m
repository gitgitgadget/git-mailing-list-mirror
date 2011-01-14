From: Victor Engmark <victor.engmark@gmail.com>
Subject: core.whitespace space-in-indent feature request
Date: Fri, 14 Jan 2011 13:40:49 +0100
Message-ID: <AANLkTikiHXofGVg9QECg9a4U4r4VGD1tb6oMV21nzd9W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 14 13:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdixr-0007oi-Ej
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 13:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab1ANMkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 07:40:53 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64178 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab1ANMkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 07:40:51 -0500
Received: by bwz15 with SMTP id 15so2474691bwz.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 04:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=MU1vf3+c8iH6NMd3mokD8tWAtEC7ON9MfM5XYLfCLb4=;
        b=BgfoD9Bb0P60eoLk7/rolmJfOjcC9sJLkwzWtQ9ou7yB/iXU+5pHaOoneGxnbjpem4
         /smrVlGhm4CqhWrFvcjNNsKODSD2lkcGbMiEjJ5+TVXNV3hLXa7SsOH+T/xbbkedWbCi
         Qn5QMS55c8Si37CprzGQ8Sa4ph0Yxc8Cc8oz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=BX7duXgJSZATua8Oo7pKXSVDLuM2FSIKGmSWLulJP4acJXl7MhDOGgqU7q29FfOTzq
         sUHUxYv2yNx7OEq15s4ifTORypoVUfPkIaOu5Q1iT658xK2Lf8rxUfkqLB/vRwNt9mLR
         r4D5eNeEj0R14NIwjhzEjmVX1CLFEZ8/hpsTw=
Received: by 10.204.122.65 with SMTP id k1mr568418bkr.80.1295008850001; Fri,
 14 Jan 2011 04:40:50 -0800 (PST)
Received: by 10.204.47.5 with HTTP; Fri, 14 Jan 2011 04:40:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165097>

Hi all,

I couldn't find this mentioned anywhere, but it would be useful for
languages where you typically want only tab characters in indentation,
like makefiles. Would be equivalent or similar to indent-with-non-tab
and tabwidth=1.

-- 
Victor Engmark
