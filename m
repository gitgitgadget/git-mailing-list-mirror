From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 00/11] add options to for-each-ref
Date: Thu, 25 Jun 2015 01:21:52 +0530
Message-ID: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 21:52:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qih-0006hc-8t
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbbFXTwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:52:23 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:32823 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbFXTwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:52:22 -0400
Received: by oiyy130 with SMTP id y130so37627211oiy.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=JqlWoyet3Znj+tWKlvOV7EqbCUzHQaU3yC9jfJ2Oqjw=;
        b=uLVz52IWQkTl82Ndk+SDdeacghwd+lr/TiG/Q/BUzy4EOW2HEky+KCb0Cubf4DjhAR
         ngoOrLl5dU6V/pH2hxDgCVnjQImbGjVS+TqZMNst6FhO5gG1iaL6NjiWLZjQtMpsWZF8
         sJRcber1/ZAJvmx463ygdGkNewgrKoapgP/pnpkF+nAZCR5rKAZyXXdNMyrEdRsVhGsv
         s9XpUeGPKsTjAN4Q9CeHYaq1l+BPVoUHMJK7XnHP5P93nxglEUR3ohXRkDMAneXPHVUW
         TuPNp04ZMRkE6iQSVD3nDbHR/mdKyyUXfFMzVRU5Hyd3I+pt8YeRy8sgyFNsN8Kq1Wtm
         wJYQ==
X-Received: by 10.182.29.68 with SMTP id i4mr35295634obh.57.1435175541907;
 Wed, 24 Jun 2015 12:52:21 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Wed, 24 Jun 2015 12:51:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272590>

v4 of this patch series can be found here :
http://article.gmane.org/gmane.comp.version-control.git/272285

This is a continuation of my GSoC project to unify git tag -l, git
branch -l and for-each-ref. Continued from this patch series :
http://thread.gmane.org/gmane.comp.version-control.git/271563

Changes in v5:
03/11: grammatical changes.
04/11: grammatical changes.
05/11: remove unnecessary if statement and remove caps used in commit message.
06/11: use xcalloc instead of using a commit_list as we know the size
of the array.
07/11: s/<object>/[<object>]/ as the object is optional.
08/11: rename parse_opt_commit_object_name() to parse_opt_commits().
09/11: make branch.c also to use the macros.
11/11: s/<object>/[<object>]/ as the object is optional.

Thanks to Matthieu, Christian, Junio and Eric for the input on the
last iteration.

-- 
Regards,
Karthik Nayak
