From: Chris Kees <cekees@gmail.com>
Subject: --progress for git submodule update?
Date: Sat, 10 Mar 2012 01:17:28 -0600
Message-ID: <CAOVFbFiBOH2MyC3HUtf=hA_PssSRENW7uwpBVxh0TwnO7h90XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 08:17:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6GYa-0003mX-Kr
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 08:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab2CJHRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 02:17:30 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62162 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab2CJHRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 02:17:30 -0500
Received: by wibhq7 with SMTP id hq7so1353306wib.1
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 23:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PkbVQiOZGgDBBKva3zFiwN7oKVoaMqp+ceZijVl6F4Y=;
        b=U5b8Cdvksa9iXpc4s65y5rJaVne+T7zLX1BzfctL6SNE2irAg8t5C2o825u4yv2Gfl
         tCpqTMqOErI16+Idsl+FQ3YoVKFIGsXBOJhKvDucA11oZCrZg/UHUbzJ3y8uMGKs6NbJ
         tiiDsuLun7UQRhitxBCKwnUhD3zqtl0/MdM6hm3yaZ2miQaOJAUc4TO/tIcomtdmIHRS
         Xd1I1B+eMuc5RfRDXQGjfB7jRkQsSzi0LOkFM3DtnhUZAJ/imG4Gl6mj+K6H/MrK2WWg
         CyC5x0KaMZ19FfCoS6sGPMZAaw0W2lWznBmpGIfVR3TH6GWAoxDJ9GN0SsviDp9lbVN8
         KBVA==
Received: by 10.180.99.100 with SMTP id ep4mr11219228wib.7.1331363848795; Fri,
 09 Mar 2012 23:17:28 -0800 (PST)
Received: by 10.216.178.8 with HTTP; Fri, 9 Mar 2012 23:17:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192772>

Hi,

Would it be reasonable to have a --progress option for 'git submodule
update'? I'm using buildbot with a git repository containing large
submodules, and buildbot times out on the submodule update
occasionally because there is no output for long periods of time.
Adjusting buildbot's timeout factor will do for me in the short run.

Thanks,
Chris
