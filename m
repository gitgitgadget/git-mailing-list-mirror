From: Yao Zhao <zhaox383@umn.edu>
Subject: [GSOC 2014]idea:Git Configuration API Improvement
Date: Thu, 20 Mar 2014 02:23:40 -0500
Message-ID: <1395300220-7540-1-git-send-email-zhaox383@umn.edu>
Cc: git@vger.kernel.org, Yao Zhao <zhaox383@umn.edu>
To: mhagger@alum.mit.edu, Matthieu.Moy@grenoble-inp.fr, peff@peff.net
X-From: git-owner@vger.kernel.org Thu Mar 20 08:24:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQXKx-00064F-9W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 08:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaCTHYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 03:24:08 -0400
Received: from vs-w.tc.umn.edu ([134.84.135.88]:54770 "EHLO vs-w.tc.umn.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbaCTHYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 03:24:07 -0400
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com [209.85.223.179])
	by vs-w.tc.umn.edu (UMN smtpd) with ESMTP
	for <git@vger.kernel.org>; Thu, 20 Mar 2014 02:24:04 -0500 (CDT)
X-Umn-Remote-Mta: [N] mail-ie0-f179.google.com [209.85.223.179] #+LO+TS+TR
X-Umn-Classification: local
Received: by mail-ie0-f179.google.com with SMTP id lx4so446906iec.38
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 00:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9bllje3Rrsws529wxGISdbH+jfwMLIoabS+TAXUBILg=;
        b=VkHqoX1F+NiqfFKNDT5C+TlkFarX731FI82pCUkaYbeTwd4Lgd9TpK8SjWl0XxWNaW
         ugrqP3Ef7/J9OTOatbzMKTDN7DhXtDwGCPFOl9Ne6/UNRq3xCTnNP9dJW0ZipAqjxN/B
         H8k6h3DnGHO7S4qusgLLCMf8iRLmEKfCzp2iS5hKE4PpnXmBxXjL6V7e+pQZ53uR5DEE
         dk2OfHwo0zribrcYezYw6EYPRR+bz9FuEYt5lPDbK8ztLE4gl1X2/7qa+5ywmaJJycFo
         pGzKh5244OcEgqywlQK2e1U4bdi7r+r5qmhUNvM4e5s0zNxNaI1I0F2hlk2o50jzOiVy
         avvg==
X-Gm-Message-State: ALoCoQkwgD994/ioEdo1+r6QxhSpTkrRfMVIpQY74s3kIuPXFQM82NwhCsPdpotTRM8u2bNlLouBIB/Bf/FyEhM/LkrOgg35kHBmy+C8oV2l80VWMTJKIBmf0kYIRe1nz4cKPbTOuOBtV1Vg77A/Cava05tiAGmklQ==
X-Received: by 10.50.189.228 with SMTP id gl4mr29515793igc.22.1395300244231;
        Thu, 20 Mar 2014 00:24:04 -0700 (PDT)
X-Received: by 10.50.189.228 with SMTP id gl4mr29515787igc.22.1395300244144;
        Thu, 20 Mar 2014 00:24:04 -0700 (PDT)
Received: from localhost.localdomain (c-71-63-157-152.hsd1.mn.comcast.net. [71.63.157.152])
        by mx.google.com with ESMTPSA id i16sm35006661igf.11.2014.03.20.00.24.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 00:24:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244522>

Hello, Michael, Matthieu and peff,

My name is Yao and I am interested in Git Configuration API Improvements listed in idea page in Git. I came up some ideas and really want to discuss them with you.

First is about when to start reading configuration file to cache. My idea is the time user starts call command that need configuration information (need to read configuration file).

Second is about data structure. I read Peff's email listed on idea page. He indicated two methods and I prefer syntax tree. I think there should be three or more syntax tree in the cache. One for system, one for global and one for local. If user indicate a file to be configuration file, add one more tree. Or maybe we can build one tree and tag every node to indicate where it belongs to.

Third one is about when to write back to file, I am really confused about it. I think one way could be when user leave git repository using "cd" to go back. But I am not sure if git could detect user calls "cd" to leave repository.

Thank you,

Yao
