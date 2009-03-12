From: Matthias Nothhaft <matthias.nothhaft@googlemail.com>
Subject: Transparently encrypt repository contents with GPG
Date: Thu, 12 Mar 2009 22:19:48 +0100
Message-ID: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 22:22:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhsLE-0000fs-Mw
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 22:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbZCLVTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 17:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbZCLVTw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 17:19:52 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:38095 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZCLVTv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 17:19:51 -0400
Received: by fxm24 with SMTP id 24so2306940fxm.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=XNM7DwZjVgbak+e3Lg4US3iyK4AXClwZMuBZ/YdxlKU=;
        b=woh/XZfMGpZz2hsrcQ2joYvi4wooyACFlHb+jJZc4nebp+4nt50fp0nZd2mvCDsHfx
         QsNYrqdViQuvBXb1854gDmvhR5k3EfjfBflo6b0X5TwjPtwCAEI20sEE/WOILwlLakio
         fQBXFCba90WViex6OENJ4eSPg3D+QgyXqSNxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=AdED7i0mOUZkooX2Mf9+uXJt41t4iUgzQQgIHE7+X8N+OZeBDiyqxA3Pq98FEBkb0J
         p8at1dg1Q8V2d6jxXWMwM29hOjKyomn8hkBMqHmWHGJcZ0pOafAq2adbdatBclWd1bZj
         8xarRqVFZuo1GKXE6EPegx21J/Ru1obJcw7vQ=
Received: by 10.86.51.10 with SMTP id y10mr337984fgy.51.1236892788622; Thu, 12 
	Mar 2009 14:19:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113124>

Hi,

I'm new to Git but I really already love it. ;-)

I would like to have repository that transparently encrypts and
decrypts all files using GPG.

What I need is a way to automatically modify each file

a) before it is written in the repository
b) after it is read from the repository

Is there a way to get this work somehow? Can someone give me some
hints where I need to begin?

regards,
Matthias
