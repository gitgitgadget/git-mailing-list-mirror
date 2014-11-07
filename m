From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: What is the default refspec for fetch?
Date: Fri, 7 Nov 2014 16:31:08 +0100
Message-ID: <CAENte7inZ5fm2SzNPq=HNPKnPco9tM4T_es5Dphnpbia-uiLdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 16:31:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmlVe-0006nx-9W
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 16:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbaKGPba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 10:31:30 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:59102 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaKGPb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 10:31:29 -0500
Received: by mail-qc0-f172.google.com with SMTP id i17so2684402qcy.31
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=EL6n7Y/lunwQO+Zw9YMQ2LpHhffKpjbvuix++CWSBl8=;
        b=uEnq7Tk0vDbYj1JS4MBXq6erj90iyE9T4ImqXW5hpnLrJqyxLnkzcIH4HFX/ze5fgb
         U9I9TDWCH/R9QLdxDHh185n/lrxIZxrfzw4snJkvQIozXri9u7jCtV4Opzp5+/PbW04h
         p0k4rSYC0tU5FJEkjy5GYvrt8IjU74Ph+yNC0CHyErZWXbS/+xt1sb/Hme0DpWJctgM5
         t80JtojyBMXOuviDg/rAmVCIlvpMRg2dbMYuegeMMVbpRCyHmFQDS48I3JL/Tq2eaicQ
         kdH3bkA+PwGtES//qmp9Sqzi4DKoH9SJ3twKn4ON32oznZFyXk+ef5p+MI+Zu0YdY0JI
         x82A==
X-Received: by 10.229.139.195 with SMTP id f3mr18376355qcu.3.1415374288958;
 Fri, 07 Nov 2014 07:31:28 -0800 (PST)
Received: by 10.96.149.71 with HTTP; Fri, 7 Nov 2014 07:31:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In a repo where no remote.<name>.fetch config parameter is set what
should a "git fetch" do? My experiments let me think it's
"HEAD:FETCH_HEAD". Right?

I came to this question after finding out that when I clone repos in
bare mode then they don't have and explicit remote.<name>.fetch in
their config. But a "git fetch" sometimes updated "something".

Ciao
  Chris
