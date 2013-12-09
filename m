From: George Papanikolaou <g3orge.app@gmail.com>
Subject: mv/rm submodules
Date: Mon, 9 Dec 2013 12:59:11 +0200
Message-ID: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 11:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpyYY-00009F-5a
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 11:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760423Ab3LIK7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 05:59:14 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50928 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759819Ab3LIK7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 05:59:13 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so3252417wgh.5
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 02:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hocw5VjPoXqlZeF1A/wqjJ2oSGzi6mHqgWjjHabj7zo=;
        b=m6JsU4R7njR0/YP69OlUpAiGpvx+8i1gP2DjsyoFC2jTSQDIqwIxIWI62pladMq3tM
         bvMQcA1MJ76MQg/TErV2JZSshRjA/9IMNbM/f+X0Mngvg7shZGfyQZXTciOTG9C03n0A
         8vV4pHVp3c0wcxtqWknUag1f/wKJqbo2aJrVzeOidYh2SDZT0N7Ka0e7/4VlsRrHHyJm
         5D918B89egbZPncVI2o6px3ChGcRWJe7DZrVUxXTz81iVpDyFtlY3SHBsZyci2DcXQ3c
         LmhzO/e8aD+Abkh+paG0XlDGlmfzVEC1MEwj8sORCXfnwH58PpW/ydJJ4RJNmVeqaNMs
         wZVw==
X-Received: by 10.180.36.231 with SMTP id t7mr13724421wij.40.1386586751426;
 Mon, 09 Dec 2013 02:59:11 -0800 (PST)
Received: by 10.194.75.132 with HTTP; Mon, 9 Dec 2013 02:59:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239066>

Hi list,

I was just playing with the new features of 'git mv' in 1.8.5 and
realized that both rm
and mv don't change the .git/config file. Is that on purpuse?
Also after mv you need to run 'submodule update' and I think this should be
documented somewhere.

Thanks..

-- 
George 'papanikge' Papanikolaou
g3orge.app@gmail.com
